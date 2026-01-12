import argparse
import json
import re
from datetime import datetime
from io import StringIO
from pathlib import Path

from unified_planning.io import PDDLReader
from unified_planning.shortcuts import AnytimePlanner, OneshotPlanner, get_environment
from unified_planning.model.metrics import MinimizeSequentialPlanLength
from unified_planning.engines.results import PlanGenerationResultStatus

PLANNER_METADATA = {
    "enhsp": {"desc": "ENHSP", "timeout": 1800.0},
    "enhsp-opt": {"desc": "ENHSP OPT", "timeout": 1800.0},
    "enhsp-any": {"desc": "ENHSP ANY", "timeout": 1800.0},
}

DEFAULT_PLANNER_ORDER = [
    "enhsp",
    "enhsp-opt",
    "enhsp-any",
]


def parse_args():
    parser = argparse.ArgumentParser(
        description="Benchmark numeric planners with unified_planning"
    )
    parser.add_argument(
        "--domain",
        default="darksouls/domain.pddl",
        help="Path to the domain PDDL file (default: darksouls/domain.pddl)",
    )
    parser.add_argument(
        "--problem-dir",
        default="darksouls",
        help="Directory that contains the problem PDDL files (default: darksouls)",
    )
    parser.add_argument(
        "--problem-glob",
        default="problem-bench-*.pddl",
        help="Glob used to discover problems when --problems is not provided",
    )
    parser.add_argument(
        "--problems",
        nargs="+",
        help="Explicit list of problem file names (relative to --problem-dir)",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=10,
        help="Maximum number of problems to benchmark (default: 9, 0 disables the limit)",
    )
    parser.add_argument(
        "--planners",
        nargs="+",
        help="Subset of planners to test (default: enhsp, enhsp-opt, enhsp-any)",
    )
    parser.add_argument(
        "--timeout",
        type=float,
        help="Override timeout (seconds) for non-opt planners",
    )
    parser.add_argument(
        "--timeout-opt",
        type=float,
        help="Override timeout (seconds) for planners whose name contains 'opt'",
    )
    parser.add_argument(
        "--output",
        default="benchmark_results_numeric.json",
        help="JSON file where benchmark results will be stored",
    )
    parser.add_argument(
        "--plan-dir",
        default="plans-numeric",
        help="Directory where generated plans will be stored (default: plans-numeric)",
    )
    return parser.parse_args()


def detect_available_planners(candidates):
    print("Detecting available planners...")
    available = []
    for planner_name in candidates:
        try:
            with env.factory.OneshotPlanner(name=planner_name):
                available.append(planner_name)
                print(f"  OK: {planner_name}")
        except Exception as exc:
            print(f"  SKIP: {planner_name} ({exc})")
    print(f"Found {len(available)} planners: {', '.join(available) if available else 'none'}\n")
    return available


def collect_problem_files(problem_dir, explicit_names, glob_pattern, limit):
    base = Path(problem_dir)
    if explicit_names:
        files = [base / name for name in explicit_names]
    else:
        files = sorted(base.glob(glob_pattern))
    if limit and limit > 0:
        files = files[:limit]
    missing = [str(p) for p in files if not p.exists()]
    if missing:
        raise FileNotFoundError(f"Problem files not found: {', '.join(missing)}")
    if not files:
        raise FileNotFoundError("No problem files selected for benchmarking")
    return files


def extract_stats(planner_output):
    stats = {}
    patterns = {
        "metric": r"Metric \(Search\):([\d.]+)",
        "planning_time_ms": r"Planning Time \(msec\): (\d+)",
        "search_time_ms": r"Search Time \(msec\): (\d+)",
        "heuristic_time_ms": r"Heuristic Time \(msec\): (\d+)",
        "expanded_nodes": r"Expanded Nodes:(\d+)",
        "states_evaluated": r"States Evaluated:(\d+)",
        "dead_ends": r"Number of Dead-Ends detected:(\d+)",
        "duplicates": r"Number of Duplicates detected:(\d+)",
    }
    for key, pattern in patterns.items():
        matches = re.findall(pattern, planner_output)
        if matches:
            value = matches[-1]  # Take the last match for anytime planners
            stats[key] = (
                float(value) if "." in value else int(value)
            )
    return stats


def planner_label(planner_name):
    meta = PLANNER_METADATA.get(planner_name)
    return meta["desc"] if meta else planner_name.upper().replace("-", " ")


def resolve_timeout(planner_name, args):
    meta_timeout = PLANNER_METADATA.get(planner_name, {}).get("timeout")
    if args.timeout_opt is not None and "opt" in planner_name:
        return args.timeout_opt
    if args.timeout is not None and "opt" not in planner_name:
        return args.timeout
    if meta_timeout is not None:
        return meta_timeout
    return 120.0 if "opt" in planner_name else 60.0


def ensure_plan_dir(path):
    plan_dir = Path(path)
    plan_dir.mkdir(parents=True, exist_ok=True)
    return plan_dir


def format_plan(plan):
    if plan is None or not getattr(plan, "actions", None):
        return []
    lines = []
    for idx, action_instance in enumerate(plan.actions, start=1):
        params = ", ".join(str(p) for p in action_instance.actual_parameters)
        lines.append(f"{idx:02d}. {action_instance.action.name}({params})")
    return lines


def save_plan_lines(plan_lines, plan_dir, problem_name, planner_name):
    if not plan_lines:
        return None
    problem_stem = Path(problem_name).stem
    safe_planner = planner_name.replace("/", "_").replace(" ", "_")
    plan_file = plan_dir / f"{problem_stem}__{safe_planner}.plan"
    plan_file.write_text("\n".join(plan_lines) + "\n", encoding="utf-8")
    return str(plan_file)


def drop_quality_metrics(problem):
    """Return a version of problem without quality metrics (optimize plan length)."""
    clear_fn = getattr(problem, "clear_quality_metrics", None)
    if callable(clear_fn):
        clear_fn()
    elif hasattr(problem, "quality_metrics"):
        try:
            problem.quality_metrics = []  # type: ignore[attr-defined]
        except Exception:
            pass
    problem.add_quality_metric(MinimizeSequentialPlanLength())
    return problem


def solve_with_planner(planner_name, problem, timeout, output_stream):
    """Solve using appropriate interface for each planner.

    - enhsp:     default oneshot planner chosen from problem_kind.
    - enhsp-opt: oneshot planner with optimality guarantee.
    - enhsp-any: anytime planner; returns the last (best) plan produced.
    """
    start_time = datetime.now()

    if planner_name == "enhsp-any":
        with AnytimePlanner(          
            problem_kind=problem.kind,
            params={"params": "-s lazygbfs -h hmrp -ha true"},
            anytime_guarantee="INCREASING_QUALITY",
            ) as planner:
            engine_name = getattr(planner, "name", planner_name)
            best_result = None
            for i, result in enumerate(planner.get_solutions(problem, timeout=timeout, output_stream=output_stream)):
                print(f"  Anytime iteration {i+1}: status={result.status}, plan_length={len(result.plan.actions) if result.plan else 0}")
                best_result = result

        end_time = datetime.now()
        elapsed = (end_time - start_time).total_seconds()

        if best_result is None:
            class _NoPlan:
                plan = None
                status = PlanGenerationResultStatus.UNSOLVABLE_PROVEN
                metrics = {}

            return _NoPlan(), elapsed, engine_name

        return best_result, elapsed, engine_name

    # Optimal ENHSP: request an engine that provides SOLVED_OPTIMALLY;
    # if none supports all features, fall back to the enhsp-opt engine by name.
    if planner_name == "enhsp-opt":
        try:
            with OneshotPlanner(
                problem_kind=problem.kind,
                optimality_guarantee=PlanGenerationResultStatus.SOLVED_OPTIMALLY,
            ) as planner:
                result = planner.solve(
                    problem, output_stream=output_stream, timeout=timeout
                )
                engine_name = getattr(planner, "name", planner_name)
        except Exception as exc:
            # Fallback: directly request the enhsp-opt engine.
            print(f"  Warning: optimality_guarantee request failed;"
                  f" falling back to '{planner_name}' by name.")
            with OneshotPlanner(name=planner_name) as planner:
                result = planner.solve(
                    problem, output_stream=output_stream, timeout=timeout
                )
                engine_name = getattr(planner, "name", planner_name)
    else:
        # Default satisficing ENHSP (or any other suitable numeric planner)
        params = {"params": "-s lazygbfs -h hmrp -ha true"}
        with OneshotPlanner(problem_kind=problem.kind, params=params) as planner:
            result = planner.solve(
                problem, output_stream=output_stream, timeout=timeout
            )
            engine_name = getattr(planner, "name", planner_name)
    end_time = datetime.now()
    elapsed = (end_time - start_time).total_seconds()
    return result, elapsed, engine_name


def run_benchmark(domain_path, problems, planners, args):
    domain_file = str(domain_path)
    reader = PDDLReader()
    results = []
    plan_dir = ensure_plan_dir(args.plan_dir)

    print("=" * 80)
    print("NUMERIC PLANNING BENCHMARK")
    print("=" * 80)
    print(f"Domain: {domain_file}")
    print(f"Problems: {len(problems)}")
    print(f"Planners: {len(planners)}")
    print("=" * 80)

    for problem_path in problems:
        print(f"\n{'=' * 80}")
        print(f"Problem: {problem_path.name}")
        print("=" * 80)

        try:
            # Only cost mode: use original metric (e.g., total-cost) if present.
            problem_cost = reader.parse_problem(domain_file, str(problem_path))
            print(problem_cost.quality_metrics)
        except Exception as exc:
            print(f"  ERROR loading {problem_path}: {exc}")
            continue

        mode_key, mode_desc, problem = "cost", "with metric (e.g., total-cost)", problem_cost
        print(f"\n[MODE: {mode_key}] {mode_desc}")
        for planner_name in planners:
                planner_desc = planner_label(planner_name)
                timeout = resolve_timeout(planner_name, args)
                print(f"\n--- {planner_desc} ({planner_name}) ---")
                print(f"  Using timeout: {timeout}s")

                try:
                    start_time = datetime.now()
                    output_stream = StringIO()
                    result, elapsed_s, engine_name = solve_with_planner(
                        planner_name, problem, timeout, output_stream
                    )
                    total_time_ms = elapsed_s * 1000

                    entry = {
                        "problem": problem_path.name,
                        "planner": planner_name,
                        "planner_desc": planner_desc,
                        "mode": mode_key,
                        "engine": engine_name,
                        "status": str(result.status),
                        "timestamp": start_time.isoformat(),
                        "total_time_ms": total_time_ms,
                        "plan_length": len(result.plan.actions)
                        if result.plan
                        else 0,
                    }
                    raw_output = output_stream.getvalue()
                    plan_lines = format_plan(result.plan)
                    plan_path = save_plan_lines(
                        plan_lines, plan_dir, problem_path.name, f"{planner_name}__{mode_key}"
                    )
                    if plan_lines:
                        entry["plan_steps"] = plan_lines
                    if plan_path:
                        entry["plan_file"] = plan_path
                    entry.update(extract_stats(raw_output))

                    # Attach raw planner output for debugging, especially when
                    # ENHSP reports INTERNAL_ERROR.
                    if raw_output:
                        entry["raw_output"] = raw_output
                    results.append(entry)

                    print(f"  Engine: {engine_name}")
                    print(f"  Status: {entry['status']}")
                    print(f"  Time: {entry['total_time_ms']:.0f} ms")
                    print(f"  Plan length: {entry['plan_length']} actions")
                    if "metric" in entry:
                        print(f"  Plan cost: {entry['metric']}")
                    if "expanded_nodes" in entry:
                        print(f"  Expanded nodes: {entry['expanded_nodes']}")

                    # If the planner reports INTERNAL_ERROR, show its raw
                    # textual output to help understand the root cause.
                    if result.status == PlanGenerationResultStatus.INTERNAL_ERROR and raw_output:
                        print("  --- Planner raw output (INTERNAL_ERROR) ---")
                        print(raw_output)
                        print("  --- End of planner output ---")
                except Exception as exc:
                    print(f"  ERROR: {type(exc).__name__}: {exc}")
                    # Best-effort attempt to capture engine output even on exceptions.
                    raw_output = ""
                    try:
                        if "output_stream" in locals():
                            raw_output = output_stream.getvalue()
                    except Exception:
                        pass
                    results.append(
                        {
                            "problem": problem_path.name,
                            "planner": planner_name,
                            "planner_desc": planner_desc,
                            "mode": mode_key,
                            "status": "ERROR",
                            "error": str(exc),
                            "raw_output": raw_output,
                            "timestamp": datetime.now().isoformat(),
                        }
                    )

    return results


def write_results(results, output_path):
    with open(output_path, "w") as stream:
        json.dump(results, stream, indent=2)


def print_report(results, planners, output_path):
    print(f"\n{'=' * 80}")
    print("BENCHMARK COMPLETE")
    print("=" * 80)
    print(f"Results saved to: {output_path}\n")

    print("COMPARISON TABLE")
    print("-" * 110)
    print(
        f"{'Problem':<25} {'Planner':<20} {'Status':<15} {'Time (ms)':<12} "
        f"{'Plan Len':<10} {'Cost':<10} {'Nodes':<10}"
    )
    print("-" * 110)

    for entry in results:
        time_str = (
            f"{entry.get('total_time_ms', 0):.0f}"
            if "total_time_ms" in entry
            else "N/A"
        )
        cost_str = f"{entry.get('metric', 0):.0f}" if "metric" in entry else "N/A"
        nodes_str = str(entry.get("expanded_nodes", "N/A"))
        print(
            f"{entry['problem']:<25} "
            f"{entry['planner']:<20} "
            f"{entry['status']:<15} "
            f"{time_str:<12} "
            f"{entry.get('plan_length', 'N/A'):<10} "
            f"{cost_str:<10} "
            f"{nodes_str:<10}"
        )

    print("-" * 110)
    print("\nSUMMARY BY PLANNER")
    print("-" * 60)
    for planner_name in planners:
        planner_desc = planner_label(planner_name)
        planner_results = [
            r for r in results if r["planner"] == planner_name and "total_time_ms" in r
        ]
        if planner_results:
            avg_time = sum(r["total_time_ms"] for r in planner_results) / len(planner_results)
            avg_nodes = sum(r.get("expanded_nodes", 0) for r in planner_results) / len(
                planner_results
            )
            print(
                f"{planner_desc:<30}: Avg time: {avg_time:>8.0f} ms | "
                f"Avg nodes: {avg_nodes:>8.0f}"
            )
        else:
            print(f"{planner_desc:<30}: no successful runs")
    print("-" * 60)


def main():
    args = parse_args()
    domain_path = Path(args.domain)
    if not domain_path.exists():
        print(f"ERROR: Domain file not found: {domain_path}")
        return 1

    try:
        problems = collect_problem_files(
            args.problem_dir, args.problems, args.problem_glob, args.limit
        )
    except FileNotFoundError as exc:
        print(f"ERROR: {exc}")
        return 1

    candidate_planners = args.planners or DEFAULT_PLANNER_ORDER
    available_planners = detect_available_planners(candidate_planners)
    if not available_planners:
        print("ERROR: No numeric planners available in this environment.")
        return 1

    print("ENHSP PLANNER MODES")
    print("- enhsp: satisficing search; aims to find a good plan quickly,"
        " but does not guarantee optimal cost or minimal number of actions.")
    print("- enhsp-opt: optimal search; guarantees minimal value of the problem's"
        " metric when one is present.")
    print("- enhsp-any: portfolio/anytime configuration; internally runs multiple"
          " ENHSP variants and returns the best plan it has found when the"
          " search stops (still exposed as a single plan in UP).")
    print("This benchmark runs each problem only in cost mode:")
    print("  - cost: uses the PDDL quality metric (e.g., total-cost) when present.")
 

    results = run_benchmark(domain_path, problems, available_planners, args)
    write_results(results, args.output)
    print_report(results, available_planners, args.output)
    return 0


env = get_environment()
env.credits_stream = None


if __name__ == "__main__":
    raise SystemExit(main())
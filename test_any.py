from unified_planning.shortcuts import (
    OneshotPlanner,
    AnytimePlanner,
)
from unified_planning.io import PDDLReader

# Direct import of the ENHSP blind optimal engine; we will use it
# without going through the Unified Planning factory.
try:
    from up_enhsp.enhsp_planner import ENHSPOptBlindEngine
except Exception as exc:  # pragma: no cover - just a safety net for imports
    ENHSPOptBlindEngine = None  # type: ignore[assignment]
    print(f"Warning: could not import ENHSPOptBlindEngine: {exc}")


reader = PDDLReader()
problem = reader.parse_problem(
    "darksouls/domain.pddl",
    "darksouls/problem-bench-02.pddl",
)

# 1) Anytime: collect all solutions, keep the last (best-so-far)
with AnytimePlanner(name="enhsp-any") as a:
    last = None
    for i, r in enumerate(a.get_solutions(problem)):
        print(f"anytime step {i}: len={len(r.plan.actions)}, metric={r}")
        last = r
    if last is not None:
        print("anytime final:", len(last.plan.actions), last)
    else:
        print("anytime: no plan found")

# 2) Oneshot: single call (portfolio/anytime via oneshot wrapper)
with OneshotPlanner(name="enhsp-any") as o:
    r1 = o.solve(problem)
    if r1.plan is not None:
        print("oneshot:", len(r1.plan.actions), r1.metrics)
    else:
        print("oneshot: no plan found", r1.status)

# 3) Blind optimal ENHSP engine used directly (no factory registration)
if ENHSPOptBlindEngine is not None:
    try:
        with ENHSPOptBlindEngine() as b:
            rb = b.solve(problem)
            if rb.plan is not None:
                print("blind-opt:", len(rb.plan.actions), rb.metrics)
            else:
                print("blind-opt: no plan found", rb.status)
    except Exception as exc:
        print(f"blind-opt: ENHSPOptBlindEngine failed: {exc}")
else:
    print("blind-opt: ENHSPOptBlindEngine not available")
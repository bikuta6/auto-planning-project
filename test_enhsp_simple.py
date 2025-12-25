from unified_planning.io import PDDLReader
from unified_planning.shortcuts import *
from io import StringIO
import json
import re
from datetime import datetime
import signal
import sys

# Disable credits output
env = get_environment()
env.credits_stream = None

# Problems to test
problems = [
    f"problem-bench-0{i+1}.pddl" for i in range(9)
]

# Auto-detect available planners
print("Detecting available planners...")
available_planners = []
test_planners = [
    'enhsp', 'enhsp-opt', 'enhsp-any',
    'fast-downward', 'fast-downward-opt',
    'pyperplan', 'tamer', 'smtplan'
]

for planner_name in test_planners:
    try:
        with env.factory.OneshotPlanner(name=planner_name) as planner:
            available_planners.append(planner_name)
    except:
        pass

print(f"Found {len(available_planners)} planners: {', '.join(available_planners)}\n")

# Filter to numeric-capable planners (skip Fast Downward for numeric domains)
planners_to_test = [
    (name, name.upper().replace('-', ' '))
    for name in available_planners
    if 'fast-downward' not in name  # Fast Downward doesn't support numeric
]

if not planners_to_test:
    print("ERROR: No numeric planners found!")
    exit(1)

def extract_stats(enhsp_output):
    """Extract statistics from planner output"""
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
        match = re.search(pattern, enhsp_output)
        if match:
            stats[key] = float(match.group(1)) if '.' in match.group(1) else int(match.group(1))
    return stats

# Run benchmarks
results = []
path = "darksouls/"
domain_filename = path + "domain.pddl"

print("="*80)
print("NUMERIC PLANNING BENCHMARK")
print("="*80)
print(f"Domain: {domain_filename}")
print(f"Problems: {len(problems)}")
print(f"Planners: {len(planners_to_test)}")
print("="*80)

for problem_file in problems:
    print(f"\n{'='*80}")
    print(f"Problem: {problem_file}")
    print('='*80)
    
    reader = PDDLReader()
    problem_filename = path + problem_file
    problem = reader.parse_problem(domain_filename, problem_filename)
    
    for planner_name, planner_desc in planners_to_test:
        print(f"\n--- {planner_desc} ({planner_name}) ---")
        
        try:
            output_stream = StringIO()
            
            with OneshotPlanner(name=planner_name) as planner:
                start_time = datetime.now()
                # Set reasonable timeout (in seconds)
                timeout = 120.0 if 'opt' in planner_name else 60.0
                print(f"  Using timeout: {timeout}s")
                
                result = planner.solve(problem, output_stream=output_stream, timeout=timeout)
                end_time = datetime.now()
                total_time_ms = (end_time - start_time).total_seconds() * 1000
                
                total_time_ms = (end_time - start_time).total_seconds() * 1000
                total_time_ms = (end_time - start_time).total_seconds() * 1000
                
                # Build result entry
                entry = {
                    "problem": problem_file,
                    "planner": planner_name,
                    "planner_desc": planner_desc,
                    "status": str(result.status),
                    "timestamp": start_time.isoformat(),
                    "total_time_ms": total_time_ms,
                    "plan_length": len(result.plan.actions) if result.plan else 0,
                }
                
                # Extract planner-specific stats
                planner_output = output_stream.getvalue()
                entry.update(extract_stats(planner_output))
                
                results.append(entry)
                
                # Display summary
                print(f"  Status: {entry['status']}")
                print(f"  Timeout: {timeout}s")
                print(f"  Time: {entry['total_time_ms']:.0f} ms")
                print(f"  Plan length: {entry['plan_length']} actions")
                if 'metric' in entry:
                    print(f"  Plan cost: {entry['metric']}")
                if 'expanded_nodes' in entry:
                    print(f"  Expanded nodes: {entry['expanded_nodes']}")
                
        except Exception as e:
            print(f"  ERROR: {type(e).__name__}: {e}")
            results.append({
                "problem": problem_file,
                "planner": planner_name,
                "planner_desc": planner_desc,
                "status": "ERROR",
                "error": str(e),
                "timestamp": datetime.now().isoformat(),
            })

# Save benchmark results
output_file = "benchmark_results.json"
with open(output_file, 'w') as f:
    json.dump(results, f, indent=2)

print(f"\n{'='*80}")
print("BENCHMARK COMPLETE")
print('='*80)
print(f"Results saved to: {output_file}\n")

# Display comparison table
print("COMPARISON TABLE")
print("-" * 110)
print(f"{'Problem':<25} {'Planner':<20} {'Status':<15} {'Time (ms)':<12} {'Plan Len':<10} {'Cost':<10} {'Nodes':<10}")
print("-" * 110)

for entry in results:
    time_str = f"{entry.get('total_time_ms', 0):.0f}" if 'total_time_ms' in entry else 'N/A'
    cost_str = f"{entry.get('metric', 0):.0f}" if 'metric' in entry else 'N/A'
    nodes_str = str(entry.get('expanded_nodes', 'N/A'))
    
    print(f"{entry['problem']:<25} "
          f"{entry['planner']:<20} "
          f"{entry['status']:<15} "
          f"{time_str:<12} "
          f"{entry.get('plan_length', 'N/A'):<10} "
          f"{cost_str:<10} "
          f"{nodes_str:<10}")

print("-" * 110)

# Summary statistics
print("\nSUMMARY BY PLANNER")
print("-" * 60)
for planner_name, planner_desc in planners_to_test:
    planner_results = [r for r in results if r['planner'] == planner_name and 'total_time_ms' in r]
    if planner_results:
        avg_time = sum(r['total_time_ms'] for r in planner_results) / len(planner_results)
        avg_nodes = sum(r.get('expanded_nodes', 0) for r in planner_results) / len(planner_results)
        print(f"{planner_desc:<30}: Avg time: {avg_time:>8.0f} ms | Avg nodes: {avg_nodes:>8.0f}")
print("-" * 60)
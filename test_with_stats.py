from unified_planning.io import PDDLReader
from unified_planning.shortcuts import *
from io import StringIO
import json
import re
from datetime import datetime

# Disable credits output
get_environment().credits_stream = None

reader = PDDLReader()
path = "darksouls/"
domain_filename = path + "domain.pddl"
problem_filename = path + "problem-bench-02.pddl"
problem = reader.parse_problem(domain_filename, problem_filename)

print(f"Solving problem: {problem_filename}")

# Capture ENHSP output
output_stream = StringIO()

with OneshotPlanner(name='enhsp') as planner:
    result = planner.solve(problem, output_stream=output_stream)
    
    # Get ENHSP output
    enhsp_output = output_stream.getvalue()
    
    # Parse statistics from ENHSP output
    stats = {
        "problem": problem_filename,
        "status": str(result.status),
        "timestamp": datetime.now().isoformat(),
        "plan_length": len(result.plan.actions) if result.plan else 0,
    }
    
    # Extract numerical stats from ENHSP output
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
    
    # Display stats
    print("\n" + "="*60)
    print("PLANNING STATISTICS")
    print("="*60)
    for key, value in stats.items():
        print(f"{key:25s}: {value}")
    print("="*60)
    
    # Save stats to JSON
    output_file = "planning_stats.json"
    with open(output_file, 'w') as f:
        json.dump(stats, f, indent=2)
    print(f"\nStats saved to: {output_file}")
    
    # Save full ENHSP output
    log_file = "enhsp_output.log"
    with open(log_file, 'w') as f:
        f.write(enhsp_output)
    print(f"Full ENHSP output saved to: {log_file}")
    
    # Display plan
    if result.plan:
        print(f"\n{'='*60}")
        print("PLAN")
        print("="*60)
        for i, action in enumerate(result.plan.actions, 1):
            print(f"{i:2d}. {action}")

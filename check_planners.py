from unified_planning.shortcuts import *

# Check which planners are available
env = get_environment()
print("Available OneshotPlanners:")
for planner_name in env.factory.engines:
    try:
        planner = env.factory.OneshotPlanner(name=planner_name)
        print(f"  - {planner_name}")
    except:
        pass

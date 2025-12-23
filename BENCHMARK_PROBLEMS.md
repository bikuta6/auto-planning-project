# Dark Souls Benchmark Problem Suite

## Overview
Created 10 benchmark problems for each domain (numeric and FD) with increasing difficulty following IPC-style scaling.

## Problem Progression

| # | Name | Difficulty | Key Features | Metrics |
|---|------|-----------|--------------|---------|
| **01** | Tutorial | Very Easy | 1 boss, direct path | 2 locations, 1 boss, 0 keys |
| **02** | First Combat | Easy | 1 minor enemy + boss | 3 locations, 1 minor, 1 boss |
| **03** | Resource Management | Easy-Medium | 2 enemies, healing required | 4 locations, 2 minors, 1 boss |
| **04** | Locked Passage | Medium | Locked door + key | 4 locations, 1 key, 1 minor, 1 boss |
| **05** | Weapon Upgrade | Medium | Requires titanite/blacksmith | Weapon upgrade needed for boss |
| **06** | Two Bosses | Medium-Hard | Multiple objectives | 3 locations, 2 bosses, 2 minors |
| **07** | Complex Navigation | Medium-Hard | Shortcuts, larger map | 6 locations, 1 shortcut, 3 minors |
| **08** | Strategic Depth | Hard | 4 enemies, locked area | 5 locations, 1 key, 4 minors, 1 boss |
| **09** | Multi-Boss Gauntlet | Hard | 3 bosses, upgrade required | 5 locations, 3 bosses, weapon req |
| **10** | Epic Challenge | Very Hard | Large map, multiple upgrades | 8 locations, 2 keys, 3 bosses, 4 minors |

## Scaling Dimensions

### Map Complexity
- **01-04**: Linear paths (2-4 locations)
- **05-07**: Branching paths with shortcuts (5-6 locations)
- **08-10**: Complex networks with multiple branches (5-8 locations)

### Combat Intensity
- **01-02**: Single encounters
- **03-05**: Multiple minor enemies (2-3)
- **06-07**: Mixed encounters (minors + bosses)
- **08-10**: High density (4+ minors, multiple bosses)

### Strategic Depth
- **01-03**: Direct combat, basic resource management
- **04-05**: Exploration (keys, doors, upgrades)
- **06-07**: Multi-objective planning
- **08-10**: Full complexity (all mechanics active)

## Testing Both Domains

### Numeric Domain (CBP-roller)
```bash
..\cbp2\cbp-roller.exe -p .\darksouls\ -o domain.pddl -f problem-bench-01.pddl -O
```

### FD Domain (Fast Downward)
```bash
python ..\downward\fast-downward.py --alias lama-first darksouls-fd/domain.pddl darksouls-fd/problem-bench-01.pddl
```

## Files Created

### Numeric Problems (darksouls/)
- `problem-bench-01.pddl` through `problem-bench-10.pddl`

### FD Problems (darksouls-fd/)  
- `problem-bench-01.pddl` through `problem-bench-10.pddl`

## Evaluation Metrics

For your report, these problems will help evaluate:

1. **Scalability**: How performance degrades with problem size
2. **Planner Strengths**: Which planners excel at which problem types
3. **Optimization Quality**: Cost comparison across solutions
4. **Completeness**: Which planners find solutions for all problems
5. **Time Complexity**: Planning time vs problem complexity

## Expected Difficulty Curve

| Problems | Expected Behavior |
|----------|------------------|
| 01-03 | All planners should solve quickly (<1s) |
| 04-06 | Fast planners shine, some struggle with multi-objective |
| 07-08 | Larger search space, optimization quality matters |
| 09-10 | Complex resource management, may timeout for some planners |

## Notes

- All problems are solvable
- FD versions use propositionalized state (discrete HP/souls/phases)
- Numeric versions use fluents (requires CBP or OPTIC)
- Death/respawn mechanics included but shouldn't be needed for optimal solutions
- Weapon upgrades are gates, not damage modifiers

"""
Script to generate FD benchmark problems from numeric problems
Converts numeric values to discrete propositions
"""

bench_problems = [
    {
        "num": "02",
        "name": "First Combat",
        "difficulty": "Easy",
        "locations": ["firelink", "pathway", "boss-room"],
        "minor_enemies": [("hollow", "pathway")],
        "bosses": [("first-boss", "boss-room")],
        "hp_max": 4,  # hp0-hp4
        "estus": 3,
        "boss_phases": {"first-boss": 4},  # 4 hits
        "keys": [],
        "shortcuts": [],
    },
    {
        "num": "03",
        "name": "Resource Management",
        "difficulty": "Easy-Medium",
        "locations": ["firelink", "area1", "area2", "boss-room"],
        "minor_enemies": [("soldier1", "area1"), ("soldier2", "area2")],
        "bosses": [("area-boss", "boss-room")],
        "hp_max": 4,
        "estus": 3,
        "boss_phases": {"area-boss": 5},
        "keys": [],
        "shortcuts": [],
    },
    {
        "num": "04",
        "name": "Locked Passage",
        "difficulty": "Medium",
        "locations": ["firelink", "upper-area", "locked-area", "boss-room"],
        "minor_enemies": [("guard", "upper-area")],
        "bosses": [("gate-boss", "boss-room")],
        "hp_max": 4,
        "estus": 3,
        "boss_phases": {"gate-boss": 5},
        "keys": [("gate-key", "upper-area", "upper-area", "locked-area")],
        "shortcuts": [],
    },
    {
        "num": "05",
        "name": "Weapon Upgrade Required",
        "difficulty": "Medium",
        "locations": ["firelink", "forge", "mines", "boss-chamber"],
        "minor_enemies": [("miner", "mines")],
        "bosses": [("armored-boss", "boss-chamber")],
        "hp_max": 4,
        "estus": 4,
        "boss_phases": {"armored-boss": 6},
        "keys": [],
        "shortcuts": [],
        "titanite": "mines",
        "blacksmith": "forge",
        "boss_weapon_req": {"armored-boss": 1},
    },
]

def generate_fd_problem(config):
    num = config["num"]
    name = config["name"]
    difficulty = config["difficulty"]
    locations = config["locations"]
    minor_enemies = config.get("minor_enemies", [])
    bosses = config["bosses"]
    hp_max = config["hp_max"]
    estus = config["estus"]
    boss_phases = config["boss_phases"]
    keys = config.get("keys", [])
    shortcuts = config.get("shortcuts", [])
    titanite = config.get("titanite", None)
    blacksmith = config.get("blacksmith", None)
    boss_weapon_req = config.get("boss_weapon_req", {})
    
    content = f''';; ===================================================================
;; BENCHMARK PROBLEM {num} - FD Version: {name}
;; Difficulty: {difficulty}
;; ===================================================================
(define (problem bench-{num}-fd)
  (:domain dark-souls-fd)
  (:objects
    {" ".join(locations)} - location
'''
    
    # Keys
    if keys:
        key_names = [k[0] for k in keys]
        content += f"    {' '.join(key_names)} - key\n"
    
    # Minor enemies
    if minor_enemies:
        enemy_names = [e[0] for e in minor_enemies]
        content += f"    {' '.join(enemy_names)} - minor-enemy\n"
    
    # Bosses
    boss_names = [b[0] for b in bosses]
    content += f"    {' '.join(boss_names)} - boss\n\n"
    
    # Discrete levels
    hp_levels = " ".join([f"hp{i}" for i in range(hp_max + 1)])
    content += f"    {hp_levels} - hp-level\n"
    content += f"    w0 w1 - wlevel\n"
    content += f"    pl0 pl1 - player-level\n"
    
    # Boss phases
    max_phases = max(boss_phases.values())
    phase_levels = " ".join([f"bp{i}" for i in range(max_phases + 1)])
    content += f"    {phase_levels} - boss-phase\n"
    
    # Estus
    estus_slots = " ".join([f"e{i}" for i in range(1, estus + 1)])
    content += f"    {estus_slots} - estus-slot\n"
    
    # Souls
    content += f"    s0 s1 s2 s3 s4 s5 s6 s7 s8 - soul-level\n"
    content += "  )\n  (:init\n"
    
    # Map connections
    content += "    ;; Map\n"
    for i, loc in enumerate(locations):
        for j in range(i + 1, len(locations)):
            if j == i + 1 or (shortcuts and (loc, locations[j]) in shortcuts):
                content += f"    (connected {loc} {locations[j]})\n"
                content += f"    (connected {locations[j]} {loc})\n"
    
    # Special locations
    content += f"    (is-firelink {locations[0]})\n"
    content += f"    (has-bonfire {locations[0]})\n"
    
    if blacksmith:
        content += f"    (is-blacksmith {blacksmith})\n"
    
    if titanite:
        content += f"    (titanite-at {titanite})\n"
    
    # Keys
    if keys:
        content += "\n    ;; Keys\n"
        for key_name, loc, from_loc, to_loc in keys:
            content += f"    (key-at {key_name} {loc})\n"
            content += f"    (matches {key_name} {from_loc} {to_loc})\n"
            content += f"    (locked {from_loc} {to_loc})\n"
            content += f"    (locked {to_loc} {from_loc})\n"
    
    # Enemies
    if minor_enemies:
        content += "\n    ;; Minor enemies\n"
        for enemy_name, loc in minor_enemies:
            content += f"    (enemy-at {enemy_name} {loc})\n"
            content += f"    (is-alive {enemy_name})\n"
    
    # Bosses
    content += "\n    ;; Bosses\n"
    for boss_name, loc in bosses:
        content += f"    (enemy-at {boss_name} {loc})\n"
        content += f"    (is-alive {boss_name})\n"
        content += f"    (has-active-boss {loc})\n"
    
    # Player
    content += f"\n    (at-player {locations[0]})\n"
    content += f"    (last-rested-bonfire {locations[0]})\n\n"
    
    # HP ladder
    content += "    ;; HP ladder\n"
    for i in range(hp_max):
        content += f"    (hp-next hp{i} hp{i+1})"
        if i < hp_max - 1:
            content += " "
    content += "\n    (hp-zero hp0)\n"
    
    # HP ordering
    for i in range(hp_max + 1):
        for j in range(i, hp_max + 1):
            content += f"    (hp-leq hp{i} hp{j})"
            if not (i == hp_max and j == hp_max):
                content += " " if j < hp_max else "\n"
    
    content += f"    (player-max-hp hp{hp_max})\n"
    content += f"    (player-hp hp{hp_max})\n"
    content += "    (player-current-level pl0)\n"
    content += "    (player-level-next pl0 pl1)\n"
    content += "    (player-weapon-level w0)\n"
    if 1 in boss_weapon_req.values():
        content += "    (wlevel-next w0 w1)\n"
    
    # Boss phases
    content += "\n    ;; Boss phases\n"
    content += "    (boss-phase-zero bp0)\n"
    for boss_name, phases in boss_phases.items():
        for i in range(phases, 0, -1):
            content += f"    (boss-phase-next bp{i} bp{i-1})\n"
        content += f"    (boss-max-phase {boss_name} bp{phases})\n"
        content += f"    (boss-current-phase {boss_name} bp{phases})\n"
    
    # Estus
    content += "\n    ;; Estus\n"
    for i in range(1, estus + 1):
        content += f"    (estus-unlocked e{i}) (estus-full e{i})\n"
    
    # Souls
    content += "\n    ;; Souls ladder\n"
    for i in range(8):
        content += f"    (soul-next s{i} s{i+1})"
        if i < 7:
            content += " " if i % 4 != 3 else "\n"
    content += "\n    (player-max-souls s8)\n"
    content += "    (player-souls s0)\n"
    
    # Combat tables
    content += "\n    ;; Combat damage tables\n"
    for enemy_name, _ in minor_enemies:
        for i in range(hp_max, 0, -1):
            # Minor enemies do 1 HP damage
            content += f"    (hp-after-attack {enemy_name} hp{i} hp{i-1})\n"
    
    for boss_name, _ in bosses:
        for i in range(hp_max, 0, -1):
            # Bosses do 1 HP damage  
            content += f"    (hp-after-attack {boss_name} hp{i} hp{i-1})\n"
    
    # Soul drops
    content += "\n    ;; Soul drops (saturating)\n"
    for enemy_name, _ in minor_enemies + bosses:
        for i in range(9):
            gain = 2 if enemy_name in [e[0] for e in minor_enemies] else 3
            new_level = min(i + gain, 8)
            content += f"    (soul-after-drop {enemy_name} s{i} s{new_level})\n"
    
    # Level costs
    content += "\n    ;; Level up costs\n"
    for i in range(2, 9):
        content += f"    (soul-spend-for-level pl0 pl1 s{i} s{i-2})\n"
    
    # Boss weapon requirements
    content += "\n    ;; Boss weapon requirements\n"
    for boss_name, _ in bosses:
        req_level = boss_weapon_req.get(boss_name, 0)
        content += f"    (can-damage-boss {boss_name} w{req_level})\n"
    
    content += "\n    (= (total-cost) 0)\n"
    content += "  )\n"
    content += "  (:goal (and\n"
    for boss_name, _ in bosses:
        content += f"    (deposited-soul {boss_name})\n"
    content += "  ))\n"
    content += "  (:metric minimize (total-cost))\n"
    content += ")\n"
    
    return content

# Generate problems 02-05
for config in bench_problems:
    content = generate_fd_problem(config)
    filename = f"darksouls-fd/problem-bench-{config['num']}.pddl"
    print(f"Generated {filename}")
    with open(filename, 'w') as f:
        f.write(content)

print("\\nDone! Generated FD benchmark problems 02-05")

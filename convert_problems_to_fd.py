import argparse
import re
from pathlib import Path


def strip_comments(text: str) -> str:
    # Remove PDDL ';' comments (including ';;')
    return "\n".join(line.split(";", 1)[0] for line in text.splitlines())


def extract_block(text: str, start_marker: str) -> str:
    idx = text.find(start_marker)
    if idx < 0:
        raise ValueError(f"Missing marker {start_marker}")
    # Find the '(' that starts the section that contains the marker.
    # For example, for ':goal' we want the '(' in '(:goal ...)', not the next one in '(and ...)'.
    start = text.rfind("(", 0, idx)
    if start < 0:
        raise ValueError(f"Missing '(' before marker {start_marker}")
    depth = 0
    for i in range(start, len(text)):
        if text[i] == "(":
            depth += 1
        elif text[i] == ")":
            depth -= 1
            if depth == 0:
                return text[start : i + 1]
    raise ValueError(f"Unclosed block for {start_marker}")


def extract_section(text: str, marker: str) -> str:
    # returns inner content of (:<marker> ...)
    block = extract_block(text, marker)
    inner = block.strip()
    # remove leading '(:marker' and trailing ')'
    inner = re.sub(r"^\(\s*" + re.escape(marker) + r"\b", "", inner, flags=re.I).strip()
    if inner.endswith(")"):
        inner = inner[:-1]
    return inner.strip()


def parse_typed_objects(objects_inner: str) -> dict[str, list[str]]:
    tokens = re.findall(r"[^\s()]+", objects_inner)
    result: dict[str, list[str]] = {}
    current: list[str] = []
    i = 0
    while i < len(tokens):
        tok = tokens[i]
        if tok == "-":
            if not current:
                i += 1
                continue
            if i + 1 >= len(tokens):
                break
            typ = tokens[i + 1]
            result.setdefault(typ, []).extend(current)
            current = []
            i += 2
            continue
        current.append(tok)
        i += 1
    return result


def sexprs_in_init(init_inner: str) -> list[str]:
    sexprs: list[str] = []
    s = init_inner
    i = 0
    while i < len(s):
        if s[i].isspace():
            i += 1
            continue
        if s[i] != "(":
            i += 1
            continue
        depth = 0
        start = i
        while i < len(s):
            if s[i] == "(":
                depth += 1
            elif s[i] == ")":
                depth -= 1
                if depth == 0:
                    sexprs.append(s[start : i + 1].strip())
                    i += 1
                    break
            i += 1
        else:
            break
    return sexprs


def parse_int(text: str, pattern: str, default: int = 0) -> int:
    m = re.search(pattern, text, flags=re.I)
    if not m:
        return default
    return int(m.group(1))


def parse_boss_requirements(text: str) -> dict[str, int]:
    req: dict[str, int] = {}
    for m in re.finditer(r"\(=\s*\(boss-required-weapon-level\s+([^\s)]+)\)\s*(\d+)\s*\)", text, flags=re.I):
        req[m.group(1)] = int(m.group(2))
    return req


def parse_enemy_health(text: str) -> dict[str, int]:
    vals: dict[str, int] = {}
    for m in re.finditer(r"\(=\s*\(enemy-health\s+([^\s)]+)\)\s*(\d+)\s*\)", text, flags=re.I):
        vals[m.group(1)] = int(m.group(2))
    return vals


def hp_bucket(player_hp: int, player_max: int) -> str:
    if player_max <= 0:
        return "hp3"
    if player_hp >= player_max:
        return "hp3"
    ratio = player_hp / player_max
    if ratio >= 0.75:
        return "hp2"
    return "hp1"


def max_hp_bucket(player_max: int) -> str:
    """Map numeric max HP to an initial discrete cap.

    We intentionally keep the initial cap below the top bucket so that
    `level-up-stats` (which increments max HP by one step) can matter.
    """
    # All provided instances have player-max-health in ~[100,150].
    # Use hp2 as the baseline cap; hp3 is reachable via leveling.
    return "hp2"


def emit_objects_block(problem_name: str, typed: dict[str, list[str]],
                       estus_slots: list[str], soul_tokens: list[str],
                       wlevels: list[str], boss_phases: list[str]) -> str:
    lines = ["  (:objects"]

    def emit_type(typ: str, names: list[str]):
        if not names:
            return
        lines.append("    " + " ".join(names) + f" - {typ}")

    # keep known types if present
    for typ in ["location", "key", "minor-enemy", "boss", "enemy"]:
        if typ in typed:
            emit_type(typ, typed[typ])

    lines.append("")
    emit_type("hp-level", ["hp0", "hp1", "hp2", "hp3"])
    emit_type("wlevel", wlevels)
    emit_type("player-level", ["pl0", "pl1"])
    if boss_phases:
        emit_type("boss-phase", boss_phases)
    emit_type("estus-slot", estus_slots)
    if soul_tokens:
        emit_type("soul-token", soul_tokens)

    lines.append("  )")
    return "\n".join(lines)


def convert_problem(src_path: Path, dst_path: Path) -> None:
    raw = src_path.read_text(encoding="utf-8")
    text = strip_comments(raw)

    # problem name
    m = re.search(r"\(define\s*\(problem\s+([^\s)]+)\)", text, flags=re.I)
    if not m:
        raise ValueError(f"Cannot find problem name in {src_path.name}")
    pname = m.group(1)

    objects_inner = extract_section(text, ":objects")
    init_inner = extract_section(text, ":init")

    # goal block is copied as-is (no numeric there)
    goal_block = extract_block(text, ":goal")

    typed = parse_typed_objects(objects_inner)

    # numeric params
    p_hp = parse_int(text, r"\(=\s*\(player-health\)\s*(\d+)\s*\)")
    p_max = parse_int(text, r"\(=\s*\(player-max-health\)\s*(\d+)\s*\)")
    estus_charges = parse_int(text, r"\(=\s*\(estus-charges\)\s*(\d+)\s*\)", default=0)
    estus_max = parse_int(text, r"\(=\s*\(estus-max\)\s*(\d+)\s*\)", default=max(1, estus_charges))
    w_init = parse_int(text, r"\(=\s*\(player-weapon-level\)\s*(\d+)\s*\)", default=0)

    boss_req = parse_boss_requirements(text)
    enemy_hp = parse_enemy_health(text)

    bosses = typed.get("boss", [])
    enemy_objs = typed.get("enemy", [])
    minors_raw = typed.get("minor-enemy", [])

    # Some instances (notably problem.pddl) declare regular enemies as type 'enemy'
    # without using 'minor-enemy'. For the FD compilation, we treat all non-boss
    # enemies as 'minor-enemy' so they can be fought/executed for soul tokens.
    minors = sorted(set(minors_raw + [e for e in enemy_objs if e not in bosses]))
    if minors:
        typed["minor-enemy"] = minors
    # Keep 'enemy' for anything else (usually empty in provided instances)
    typed["enemy"] = [e for e in enemy_objs if e in bosses]

    max_req = 0
    if bosses:
        max_req = max([boss_req.get(b, 0) for b in bosses] + [w_init])
    else:
        max_req = w_init

    wlevels = [f"w{i}" for i in range(max_req + 1)]

    # Boss phases: heuristic based on enemy-health (more HP => more required hits).
    # This makes survivability matter without adding an explicit "must level" precondition.
    boss_hits: dict[str, int] = {}
    max_hits = 0
    for b in bosses:
        hp = enemy_hp.get(b, 200)
        if hp >= 350:
            hits = 5
        elif hp > 250:
            hits = 4
        else:
            hits = 2
        hits = max(1, hits)
        boss_hits[b] = hits
        max_hits = max(max_hits, hits)

    boss_phases = [f"bp{i}" for i in range(max_hits + 1)] if bosses else []

    # estus slots: keep enough capacity for "boss kill unlocks a new slot".
    # We reduce the *initial* unlocked amount by 1 to make survivability
    # (max HP via leveling) matter in longer boss fights.
    estus_max_start = max(1, estus_max - 1)
    estus_charges_start = min(estus_charges, estus_max_start)

    total_slots = max(1, estus_max + len(bosses))
    estus_slots = [f"e{i}" for i in range(1, total_slots + 1)]

    # soul tokens: one per minor enemy (earned), up to 20
    soul_tokens = [f"s{i}" for i in range(min(len(minors), 20))]

    # init facts: keep non-numeric s-exprs
    kept_facts = [sx for sx in sexprs_in_init(init_inner) if not sx.lstrip().startswith("(=")]

    # start building init
    init_lines: list[str] = ["  (:init"]
    for fact in kept_facts:
        init_lines.append("    " + fact)

    # player discrete state
    init_lines.append("")
    init_lines.append("    ;; discrete ladders")
    init_lines.append("    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)")
    init_lines.append("    (hp-zero hp0)")
    init_lines.append("    ;; hp ordering (<=)")
    init_lines.append("    (hp-leq hp0 hp0) (hp-leq hp0 hp1) (hp-leq hp0 hp2) (hp-leq hp0 hp3)")
    init_lines.append("    (hp-leq hp1 hp1) (hp-leq hp1 hp2) (hp-leq hp1 hp3)")
    init_lines.append("    (hp-leq hp2 hp2) (hp-leq hp2 hp3)")
    init_lines.append("    (hp-leq hp3 hp3)")

    max_hp = max_hp_bucket(p_max)
    init_lines.append(f"    (player-max-hp {max_hp})")
    # Start fully healed to the current max.
    init_lines.append(f"    (player-hp {max_hp})")

    init_lines.append("    (player-level pl0) (player-level-next pl0 pl1)")

    # weapon
    init_lines.append(f"    (player-weapon-level w{w_init})")
    for i in range(max_req):
        init_lines.append(f"    (wlevel-next w{i} w{i+1})")

    # boss phase chain and init
    if bosses:
        init_lines.append("")
        init_lines.append("    ;; boss phases (hits remaining)")
        init_lines.append("    (boss-phase-zero bp0)")
        for i in range(max_hits, 0, -1):
            init_lines.append(f"    (boss-phase-next bp{i} bp{i-1})")
        for b in bosses:
            hits = boss_hits[b]
            init_lines.append(f"    (boss-max-phase {b} bp{hits})")
            init_lines.append(f"    (boss-phase {b} bp{hits})")

    # estus init
    unlocked = min(estus_max_start, len(estus_slots))
    full = min(estus_charges_start, unlocked)
    for i in range(unlocked):
        init_lines.append(f"    (estus-unlocked {estus_slots[i]})")
    for i in range(full):
        init_lines.append(f"    (estus-full {estus_slots[i]})")

    # combat tables
    init_lines.append("")
    init_lines.append("    ;; combat consequences: each attack reduces HP by one step")
    enemies_all = sorted(set(minors + bosses + typed.get("enemy", [])))
    for e in enemies_all:
        init_lines.append(f"    (hp-after-attack {e} hp3 hp2)")
        init_lines.append(f"    (hp-after-attack {e} hp2 hp1)")
        init_lines.append(f"    (hp-after-attack {e} hp1 hp0)")

    # soul drops
    init_lines.append("")
    if soul_tokens and minors:
        init_lines.append("    ;; soul drops from minor enemies")
        for m_name, t_name in zip(minors, soul_tokens, strict=False):
            init_lines.append(f"    (drops-soul {m_name} {t_name})")

    # boss damage requirements
    if bosses:
        init_lines.append("")
        init_lines.append("    ;; boss weapon requirements")
        for b in bosses:
            req_level = boss_req.get(b, 0)
            for i in range(req_level, max_req + 1):
                init_lines.append(f"    (can-damage-boss {b} w{i})")

    init_lines.append("  )")

    # assemble output
    out = []
    out.append(f"(define (problem {pname}-fd)")
    out.append("  (:domain dark-souls-fd)")
    out.append(emit_objects_block(pname, typed, estus_slots, soul_tokens, wlevels, boss_phases))
    out.append("\n".join(init_lines))
    out.append("  " + goal_block.strip())
    out.append(")")

    dst_path.write_text("\n".join(out) + "\n", encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--overwrite", action="store_true", help="Overwrite existing *-fd.pddl outputs")
    args = parser.parse_args()

    root = Path(__file__).resolve().parent

    # Convert all problem*.pddl except already FD ones
    candidates = sorted(root.glob("problem*.pddl"))
    for src in candidates:
        name = src.name
        if name.endswith("-fd.pddl") or name == "problem-fd.pddl" or name == "domain-fd.pddl":
            continue
        if name.startswith("problem-") and name.count("-") >= 2 and name.endswith(".pddl"):
            # already something like problem-01-fd.pddl
            pass

        # output naming
        if name == "problem.pddl":
            dst = root / "problem-fd.pddl"
        elif re.match(r"problem-\d+\.pddl$", name):
            dst = root / name.replace(".pddl", "-fd.pddl")
        else:
            # leave other problems alone
            continue

        if dst.exists() and not args.overwrite:
            continue

        convert_problem(src, dst)
        print(f"Wrote {dst.name}")


if __name__ == "__main__":
    main()

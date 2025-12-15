import argparse
from pathlib import Path


def emit_chain(prefix: str, max_index: int) -> list[str]:
    return [f"{prefix}{i}" for i in range(max_index + 1)]


def emit_successor_facts(rel: str, objs: list[str]) -> list[str]:
    return [f"({rel} {objs[i]} {objs[i+1]})" for i in range(len(objs) - 1)]


def emit_leq_table(rel: str, objs: list[str]) -> list[str]:
    facts: list[str] = []
    for i in range(len(objs)):
        for j in range(i, len(objs)):
            facts.append(f"({rel} {objs[i]} {objs[j]})")
    return facts


def wrap_init_facts(facts: list[str], indent: str = "    ", per_line: int = 3) -> list[str]:
    lines: list[str] = []
    buf: list[str] = []
    for fact in facts:
        buf.append(fact)
        if len(buf) >= per_line:
            lines.append(indent + " ".join(buf))
            buf = []
    if buf:
        lines.append(indent + " ".join(buf))
    return lines


def generate_problem(
    problem_name: str,
    minor_enemies: int,
    max_soul_level: int,
    max_hp_level: int,
    boss_phase_max: int,
    player_levels: int,
    estus_slots: int,
) -> str:
    if minor_enemies < 0:
        raise ValueError("minor_enemies must be >= 0")
    if max_soul_level < 0:
        raise ValueError("max_soul_level must be >= 0")
    if max_hp_level < 1:
        raise ValueError("max_hp_level must be >= 1 (needs hp0..hpN)")
    if boss_phase_max < 1:
        raise ValueError("boss_phase_max must be >= 1 (needs bp0..bpN)")
    if player_levels < 1:
        raise ValueError("player_levels must be >= 1 (needs pl0..plN)")
    if estus_slots < 1:
        raise ValueError("estus_slots must be >= 1")

    locations = ["firelink", "field", "boss-arena"]
    boss = "boss1"
    minors = [f"mob{i+1}" for i in range(minor_enemies)]

    hp = emit_chain("hp", max_hp_level)  # hp0..hpN
    souls = emit_chain("s", max_soul_level)  # s0..sN
    wlevels = ["w0", "w1"]
    pls = emit_chain("pl", player_levels)  # pl0..plN
    bps = emit_chain("bp", boss_phase_max)  # bp0..bpN
    estus = [f"e{i+1}" for i in range(estus_slots)]

    out: list[str] = []
    out.append(f"(define (problem {problem_name})")
    out.append("  (:domain dark-souls-fd)")
    out.append("  (:objects")
    out.append(f"    {' '.join(locations)} - location")
    out.append("    dummy-key - key")
    if minors:
        out.append(f"    {' '.join(minors)} - minor-enemy")
    else:
        out.append("    dummy-minor-enemy - minor-enemy")
    out.append(f"    {boss} - boss")
    out.append("")
    out.append(f"    {' '.join(hp)} - hp-level")
    out.append(f"    {' '.join(wlevels)} - wlevel")
    out.append(f"    {' '.join(pls)} - player-level")
    out.append(f"    {' '.join(bps)} - boss-phase")
    out.append(f"    {' '.join(estus)} - estus-slot")
    out.append(f"    {' '.join(souls)} - soul-level")
    out.append("  )")

    out.append("  (:init")
    out.append("    ;; map")
    out.append("    (connected firelink field)")
    out.append("    (connected field firelink)")
    out.append("    (connected field boss-arena)")
    out.append("    (connected boss-arena field)")
    out.append("")
    out.append("    ;; landmarks")
    out.append("    (is-firelink firelink)")
    out.append("    (has-bonfire firelink)")
    out.append("    (has-bonfire field)")
    out.append("    (is-blacksmith firelink)")
    out.append("    (at-player firelink)")
    out.append("")

    out.append("    ;; enemies")
    if minors:
        for m in minors:
            out.append(f"    (enemy-at {m} field)")
            out.append(f"    (is-alive {m})")
    else:
        out.append("    (enemy-at dummy-minor-enemy field)")
        out.append("    (is-alive dummy-minor-enemy)")
    out.append(f"    (enemy-at {boss} boss-arena)")
    out.append(f"    (is-alive {boss})")
    out.append("    (has-active-boss boss-arena)")
    out.append("")

    out.append("    ;; discrete ladders")
    out.extend(wrap_init_facts(emit_successor_facts("hp-next", hp), per_line=3))
    out.append("    (hp-zero hp0)")
    out.append("")
    out.append("    ;; hp ordering (<=)")
    out.extend(wrap_init_facts(emit_leq_table("hp-leq", hp), per_line=4))
    out.append("")

    out.append(f"    (player-max-hp {hp[-1]})")
    out.append(f"    (player-hp {hp[-1]})")
    out.extend(wrap_init_facts(emit_successor_facts("player-level-next", pls), per_line=3))
    out.append(f"    (player-level {pls[0]})")

    out.append("")
    out.append("    ;; weapon")
    out.append("    (player-weapon-level w0)")
    out.append("    (wlevel-next w0 w1)")

    out.append("")
    out.append("    ;; souls ladder (discrete, with max)")
    out.extend(wrap_init_facts(emit_successor_facts("soul-next", souls), per_line=3))
    out.append(f"    (player-max-souls {souls[-1]})")
    out.append(f"    (player-souls {souls[0]})")

    out.append("")
    out.append("    ;; boss phases (hits remaining)")
    out.append("    (boss-phase-zero bp0)")
    out.extend(wrap_init_facts(emit_successor_facts("boss-phase-next", list(reversed(bps))), per_line=2))
    out.append(f"    (boss-max-phase {boss} {bps[-1]})")
    out.append(f"    (boss-phase {boss} {bps[-1]})")

    out.append("")
    out.append("    ;; estus")
    out.append(f"    (estus-unlocked {estus[0]})")
    out.append(f"    (estus-full {estus[0]})")

    out.append("")
    out.append("    ;; titanite to allow weapon upgrade")
    out.append("    (titanite-at field)")

    out.append("")
    out.append("    ;; combat consequences: each attack reduces HP by one step")
    enemies_for_tables = minors if minors else ["dummy-minor-enemy"]
    enemies_for_tables.append(boss)
    for e in enemies_for_tables:
        for i in range(len(hp) - 1, 0, -1):
            out.append(f"    (hp-after-attack {e} {hp[i]} {hp[i-1]})")

    out.append("")
    out.append("    ;; souls gain from minor enemies (saturating)")
    for m in (minors if minors else ["dummy-minor-enemy"]):
        for i in range(len(souls) - 1):
            out.append(f"    (soul-after-drop {m} {souls[i]} {souls[i+1]})")
        out.append(f"    (soul-after-drop {m} {souls[-1]} {souls[-1]})")

    out.append("")
    out.append("    ;; souls spend for leveling (cost increases per level)")
    for idx in range(len(pls) - 1):
        l1 = pls[idx]
        l2 = pls[idx + 1]
        cost = idx + 1
        # allow spending only if you have at least 'cost' souls
        for s_idx in range(cost, len(souls)):
            s1 = souls[s_idx]
            s2 = souls[s_idx - cost]
            out.append(f"    (soul-spend-for-level {l1} {l2} {s1} {s2})")

    out.append("")
    out.append("    ;; boss weapon requirements")
    out.append(f"    (can-damage-boss {boss} w1)")

    out.append("  )")
    out.append("  (:goal (and")
    out.append(f"    (not (is-alive {boss}))")
    out.append(f"    (deposited-soul {boss})")
    out.append("  ))")
    out.append(")")

    return "\n".join(out) + "\n"


def main() -> None:
    parser = argparse.ArgumentParser(
        description=(
            "Generate a minimal placeholder Fast-Downward-compatible PDDL problem for domain-fd.pddl. "
            "You can then tweak the generated file by hand."))
    parser.add_argument("--out", default="placeholder-fd.pddl", help="Output .pddl path")
    parser.add_argument("--name", default="placeholder-fd", help="PDDL problem name")
    parser.add_argument("--minor-enemies", type=int, required=True, help="Number of minor enemies")
    parser.add_argument("--max-soul-level", type=int, required=True, help="Max soul level index (creates s0..sN)")
    parser.add_argument("--max-hp-level", type=int, required=True, help="Max HP level index (creates hp0..hpN)")
    parser.add_argument("--boss-phase-max", type=int, required=True, help="Max boss phase index (creates bp0..bpN)")
    parser.add_argument(
        "--player-levels",
        type=int,
        default=3,
        help="Max player level index (creates pl0..plN). Default: 3",
    )
    parser.add_argument(
        "--estus-slots",
        type=int,
        default=2,
        help="Number of estus slots to declare (unlocks+fills only e1 initially). Default: 2",
    )

    args = parser.parse_args()

    content = generate_problem(
        problem_name=args.name,
        minor_enemies=args.minor_enemies,
        max_soul_level=args.max_soul_level,
        max_hp_level=args.max_hp_level,
        boss_phase_max=args.boss_phase_max,
        player_levels=args.player_levels,
        estus_slots=args.estus_slots,
    )

    out_path = Path(args.out)
    out_path.write_text(content, encoding="utf-8")
    print(f"Wrote {out_path}")


if __name__ == "__main__":
    main()

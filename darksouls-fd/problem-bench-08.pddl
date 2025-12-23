;; BENCHMARK 08-FD: Strategic Depth (4 warriors, locked area)
(define (problem bench-08-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink courtyard armory sanctum boss-hall - location
    gate-key - key
    warrior1 warrior2 warrior3 warrior4 - minor-enemy
    sanctum-lord - boss
    hp0 hp1 hp2 hp3 hp4 hp5 - hp-level
    w0 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 bp6 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 - soul-level
  )
  (:init
    (connected firelink courtyard) (connected courtyard firelink)
    (connected courtyard armory) (connected armory courtyard)
    (connected courtyard sanctum) (connected sanctum courtyard)
    (connected sanctum boss-hall) (connected boss-hall sanctum)
    (locked courtyard sanctum) (locked sanctum courtyard)
    (is-firelink firelink) (has-bonfire firelink) (has-bonfire sanctum)
    (key-at gate-key armory) (matches gate-key courtyard sanctum)
    (enemy-at warrior1 courtyard) (enemy-at warrior2 armory) (enemy-at warrior3 sanctum) (enemy-at warrior4 sanctum)
    (is-alive warrior1) (is-alive warrior2) (is-alive warrior3) (is-alive warrior4)
    (enemy-at sanctum-lord boss-hall) (is-alive sanctum-lord) (has-active-boss boss-hall)
    (at-player firelink) (last-rested-bonfire firelink)
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5)
    (hp-zero hp0)
    (hp-leq hp0 hp0) (hp-leq hp0 hp1) (hp-leq hp0 hp2) (hp-leq hp0 hp3) (hp-leq hp0 hp4) (hp-leq hp0 hp5)
    (hp-leq hp1 hp1) (hp-leq hp1 hp2) (hp-leq hp1 hp3) (hp-leq hp1 hp4) (hp-leq hp1 hp5)
    (hp-leq hp2 hp2) (hp-leq hp2 hp3) (hp-leq hp2 hp4) (hp-leq hp2 hp5)
    (hp-leq hp3 hp3) (hp-leq hp3 hp4) (hp-leq hp3 hp5)
    (hp-leq hp4 hp4) (hp-leq hp4 hp5)
    (hp-leq hp5 hp5)
    (player-max-hp hp5) (player-hp hp5)
    (player-current-level pl0) (player-level-next pl0 pl1)
    (player-weapon-level w0)
    (boss-phase-zero bp0)
    (boss-phase-next bp6 bp5) (boss-phase-next bp5 bp4) (boss-phase-next bp4 bp3) (boss-phase-next bp3 bp2) (boss-phase-next bp2 bp1) (boss-phase-next bp1 bp0)
    (boss-max-phase sanctum-lord bp6) (boss-current-phase sanctum-lord bp6)
    (estus-unlocked e1) (estus-full e1)
    (estus-unlocked e2) (estus-full e2)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6) (soul-next s6 s7) (soul-next s7 s8)
    (player-max-souls s8) (player-souls s0)
    (hp-after-attack warrior1 hp5 hp4) (hp-after-attack warrior1 hp4 hp3) (hp-after-attack warrior1 hp3 hp2) (hp-after-attack warrior1 hp2 hp1) (hp-after-attack warrior1 hp1 hp0)
    (hp-after-attack warrior2 hp5 hp4) (hp-after-attack warrior2 hp4 hp3) (hp-after-attack warrior2 hp3 hp2) (hp-after-attack warrior2 hp2 hp1) (hp-after-attack warrior2 hp1 hp0)
    (hp-after-attack warrior3 hp5 hp4) (hp-after-attack warrior3 hp4 hp3) (hp-after-attack warrior3 hp3 hp2) (hp-after-attack warrior3 hp2 hp1) (hp-after-attack warrior3 hp1 hp0)
    (hp-after-attack warrior4 hp5 hp4) (hp-after-attack warrior4 hp4 hp3) (hp-after-attack warrior4 hp3 hp2) (hp-after-attack warrior4 hp2 hp1) (hp-after-attack warrior4 hp1 hp0)
    (hp-after-attack sanctum-lord hp5 hp4) (hp-after-attack sanctum-lord hp4 hp3) (hp-after-attack sanctum-lord hp3 hp2) (hp-after-attack sanctum-lord hp2 hp1) (hp-after-attack sanctum-lord hp1 hp0)
    (soul-after-drop warrior1 s0 s2) (soul-after-drop warrior1 s1 s3) (soul-after-drop warrior1 s2 s4) (soul-after-drop warrior1 s3 s5) (soul-after-drop warrior1 s4 s6) (soul-after-drop warrior1 s5 s7) (soul-after-drop warrior1 s6 s8) (soul-after-drop warrior1 s7 s8) (soul-after-drop warrior1 s8 s8)
    (soul-after-drop warrior2 s0 s2) (soul-after-drop warrior2 s1 s3) (soul-after-drop warrior2 s2 s4) (soul-after-drop warrior2 s3 s5) (soul-after-drop warrior2 s4 s6) (soul-after-drop warrior2 s5 s7) (soul-after-drop warrior2 s6 s8) (soul-after-drop warrior2 s7 s8) (soul-after-drop warrior2 s8 s8)
    (soul-after-drop warrior3 s0 s2) (soul-after-drop warrior3 s1 s3) (soul-after-drop warrior3 s2 s4) (soul-after-drop warrior3 s3 s5) (soul-after-drop warrior3 s4 s6) (soul-after-drop warrior3 s5 s7) (soul-after-drop warrior3 s6 s8) (soul-after-drop warrior3 s7 s8) (soul-after-drop warrior3 s8 s8)
    (soul-after-drop warrior4 s0 s2) (soul-after-drop warrior4 s1 s3) (soul-after-drop warrior4 s2 s4) (soul-after-drop warrior4 s3 s5) (soul-after-drop warrior4 s4 s6) (soul-after-drop warrior4 s5 s7) (soul-after-drop warrior4 s6 s8) (soul-after-drop warrior4 s7 s8) (soul-after-drop warrior4 s8 s8)
    (soul-after-drop sanctum-lord s0 s4) (soul-after-drop sanctum-lord s1 s5) (soul-after-drop sanctum-lord s2 s6) (soul-after-drop sanctum-lord s3 s7) (soul-after-drop sanctum-lord s4 s8) (soul-after-drop sanctum-lord s5 s8) (soul-after-drop sanctum-lord s6 s8) (soul-after-drop sanctum-lord s7 s8) (soul-after-drop sanctum-lord s8 s8)
    (soul-spend-for-level pl0 pl1 s2 s0) (soul-spend-for-level pl0 pl1 s3 s1) (soul-spend-for-level pl0 pl1 s4 s2) (soul-spend-for-level pl0 pl1 s5 s3) (soul-spend-for-level pl0 pl1 s6 s4) (soul-spend-for-level pl0 pl1 s7 s5) (soul-spend-for-level pl0 pl1 s8 s6)
    (can-damage-boss sanctum-lord w0)
    (= (total-cost) 0)
  )
  (:goal (deposited-soul sanctum-lord))
  (:metric minimize (total-cost))
)

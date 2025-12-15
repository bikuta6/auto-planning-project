(define (problem placeholder-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink field boss-arena - location
    dummy-key - key
    mob1 mob2 mob3 - minor-enemy
    boss1 - boss

    hp0 hp1 hp2 hp3 hp4 hp5 hp6 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 bp6 - boss-phase
    e1 e2 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 - soul-level
  )
  (:init
    ;; map
    (connected firelink field)
    (connected field firelink)
    (connected field boss-arena)
    (connected boss-arena field)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire field)
    (is-blacksmith firelink)
    (at-player firelink)

    ;; enemies
    (enemy-at mob1 field)
    (is-alive mob1)
    (enemy-at mob2 field)
    (is-alive mob2)
    (enemy-at mob3 field)
    (is-alive mob3)
    (enemy-at boss1 boss-arena)
    (is-alive boss1)
    (has-active-boss boss-arena)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-next hp3 hp4) (hp-next hp4 hp5) (hp-next hp5 hp6)
    (hp-zero hp0)

    ;; hp ordering (<=)
    (hp-leq hp0 hp0) (hp-leq hp0 hp1) (hp-leq hp0 hp2) (hp-leq hp0 hp3)
    (hp-leq hp0 hp4) (hp-leq hp0 hp5) (hp-leq hp0 hp6) (hp-leq hp1 hp1)
    (hp-leq hp1 hp2) (hp-leq hp1 hp3) (hp-leq hp1 hp4) (hp-leq hp1 hp5)
    (hp-leq hp1 hp6) (hp-leq hp2 hp2) (hp-leq hp2 hp3) (hp-leq hp2 hp4)
    (hp-leq hp2 hp5) (hp-leq hp2 hp6) (hp-leq hp3 hp3) (hp-leq hp3 hp4)
    (hp-leq hp3 hp5) (hp-leq hp3 hp6) (hp-leq hp4 hp4) (hp-leq hp4 hp5)
    (hp-leq hp4 hp6) (hp-leq hp5 hp5) (hp-leq hp5 hp6) (hp-leq hp6 hp6)

    (player-max-hp hp6)
    (player-hp hp6)
    (player-level-next pl0 pl1) (player-level-next pl1 pl2) (player-level-next pl2 pl3)
    (player-level pl0)

    ;; weapon
    (player-weapon-level w0)
    (wlevel-next w0 w1)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3)
    (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp6 bp5) (boss-phase-next bp5 bp4)
    (boss-phase-next bp4 bp3) (boss-phase-next bp3 bp2)
    (boss-phase-next bp2 bp1) (boss-phase-next bp1 bp0)
    (boss-max-phase boss1 bp6)
    (boss-phase boss1 bp6)

    ;; estus
    (estus-unlocked e1)
    (estus-full e1)

    ;; titanite to allow weapon upgrade
    (titanite-at field)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack mob1 hp6 hp5)
    (hp-after-attack mob1 hp5 hp4)
    (hp-after-attack mob1 hp4 hp3)
    (hp-after-attack mob1 hp3 hp2)
    (hp-after-attack mob1 hp2 hp1)
    (hp-after-attack mob1 hp1 hp0)
    (hp-after-attack mob2 hp6 hp5)
    (hp-after-attack mob2 hp5 hp4)
    (hp-after-attack mob2 hp4 hp3)
    (hp-after-attack mob2 hp3 hp2)
    (hp-after-attack mob2 hp2 hp1)
    (hp-after-attack mob2 hp1 hp0)
    (hp-after-attack mob3 hp6 hp5)
    (hp-after-attack mob3 hp5 hp4)
    (hp-after-attack mob3 hp4 hp3)
    (hp-after-attack mob3 hp3 hp2)
    (hp-after-attack mob3 hp2 hp1)
    (hp-after-attack mob3 hp1 hp0)
    (hp-after-attack boss1 hp6 hp5)
    (hp-after-attack boss1 hp5 hp4)
    (hp-after-attack boss1 hp4 hp3)
    (hp-after-attack boss1 hp3 hp2)
    (hp-after-attack boss1 hp2 hp1)
    (hp-after-attack boss1 hp1 hp0)

    ;; souls gain from minor enemies (saturating)
    (soul-after-drop mob1 s0 s1)
    (soul-after-drop mob1 s1 s2)
    (soul-after-drop mob1 s2 s3)
    (soul-after-drop mob1 s3 s4)
    (soul-after-drop mob1 s4 s5)
    (soul-after-drop mob1 s5 s6)
    (soul-after-drop mob1 s6 s6)
    (soul-after-drop mob2 s0 s1)
    (soul-after-drop mob2 s1 s2)
    (soul-after-drop mob2 s2 s3)
    (soul-after-drop mob2 s3 s4)
    (soul-after-drop mob2 s4 s5)
    (soul-after-drop mob2 s5 s6)
    (soul-after-drop mob2 s6 s6)
    (soul-after-drop mob3 s0 s1)
    (soul-after-drop mob3 s1 s2)
    (soul-after-drop mob3 s2 s3)
    (soul-after-drop mob3 s3 s4)
    (soul-after-drop mob3 s4 s5)
    (soul-after-drop mob3 s5 s6)
    (soul-after-drop mob3 s6 s6)
    (soul-after-drop boss1 s0 s1)
    (soul-after-drop boss1 s1 s2)
    (soul-after-drop boss1 s2 s3)
    (soul-after-drop boss1 s3 s4)
    (soul-after-drop boss1 s4 s5)
    (soul-after-drop boss1 s5 s6)
    (soul-after-drop boss1 s6 s6)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0)
    (soul-spend-for-level pl0 pl1 s2 s1)
    (soul-spend-for-level pl0 pl1 s3 s2)
    (soul-spend-for-level pl0 pl1 s4 s3)
    (soul-spend-for-level pl0 pl1 s5 s4)
    (soul-spend-for-level pl0 pl1 s6 s5)
    (soul-spend-for-level pl1 pl2 s2 s0)
    (soul-spend-for-level pl1 pl2 s3 s1)
    (soul-spend-for-level pl1 pl2 s4 s2)
    (soul-spend-for-level pl1 pl2 s5 s3)
    (soul-spend-for-level pl1 pl2 s6 s4)
    (soul-spend-for-level pl2 pl3 s3 s0)
    (soul-spend-for-level pl2 pl3 s4 s1)
    (soul-spend-for-level pl2 pl3 s5 s2)
    (soul-spend-for-level pl2 pl3 s6 s3)

    ;; boss weapon requirements
    (can-damage-boss boss1 w1)
  )
  (:goal (and
    (not (is-alive boss1))
    (deposited-soul boss1)
  ))
)

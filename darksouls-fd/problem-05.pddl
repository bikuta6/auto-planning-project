(define (problem p05-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink swamp-entrance blighttown quelaag-arena - location
    dummy-key - key
    mob1 mob2 mob3 - minor-enemy
    quelaag - boss

    hp0 hp1 hp2 hp3 hp4 hp5 hp6 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 - player-level
    bp0 bp1 bp2 bp3 bp4 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 - soul-level
  )
  (:init
    (connected firelink swamp-entrance)
    (connected swamp-entrance firelink)
    (connected swamp-entrance blighttown)
    (connected blighttown swamp-entrance)
    (connected blighttown quelaag-arena)
    (connected quelaag-arena blighttown)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire blighttown)
    (is-blacksmith firelink)
    (enemy-at mob1 swamp-entrance)
    (enemy-at mob2 swamp-entrance)
    (enemy-at mob3 blighttown)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)
    (enemy-at quelaag quelaag-arena)
    (is-alive quelaag)
    (has-active-boss quelaag-arena)
    (at-player firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5) (hp-next hp5 hp6)
    (hp-zero hp0)
    ;; hp ordering (<=)
    (hp-leq hp0 hp0) (hp-leq hp0 hp1) (hp-leq hp0 hp2) (hp-leq hp0 hp3) (hp-leq hp0 hp4) (hp-leq hp0 hp5) (hp-leq hp0 hp6)
    (hp-leq hp1 hp1) (hp-leq hp1 hp2) (hp-leq hp1 hp3) (hp-leq hp1 hp4) (hp-leq hp1 hp5) (hp-leq hp1 hp6)
    (hp-leq hp2 hp2) (hp-leq hp2 hp3) (hp-leq hp2 hp4) (hp-leq hp2 hp5) (hp-leq hp2 hp6)
    (hp-leq hp3 hp3) (hp-leq hp3 hp4) (hp-leq hp3 hp5) (hp-leq hp3 hp6)
    (hp-leq hp4 hp4) (hp-leq hp4 hp5) (hp-leq hp4 hp6)
    (hp-leq hp5 hp5) (hp-leq hp5 hp6)
    (hp-leq hp6 hp6)

    (player-max-hp hp4)
    (player-hp hp4)
    (player-level pl0) (player-level-next pl0 pl1) (player-level-next pl1 pl2) (player-level-next pl2 pl3)
    (player-weapon-level w0)
    (wlevel-next w0 w1)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp4 bp3)
    (boss-max-phase quelaag bp4)
    (boss-phase quelaag bp4)
    (estus-unlocked e1)
    (estus-full e1)

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
    (hp-after-attack quelaag hp6 hp5)
    (hp-after-attack quelaag hp5 hp4)
    (hp-after-attack quelaag hp4 hp3)
    (hp-after-attack quelaag hp3 hp2)
    (hp-after-attack quelaag hp2 hp1)
    (hp-after-attack quelaag hp1 hp0)

    ;; souls gain from minor enemies (saturating)
    (soul-after-drop mob1 s0 s1) (soul-after-drop mob1 s1 s2) (soul-after-drop mob1 s2 s3) (soul-after-drop mob1 s3 s4) (soul-after-drop mob1 s4 s5) (soul-after-drop mob1 s5 s6) (soul-after-drop mob1 s6 s6)
    (soul-after-drop mob2 s0 s1) (soul-after-drop mob2 s1 s2) (soul-after-drop mob2 s2 s3) (soul-after-drop mob2 s3 s4) (soul-after-drop mob2 s4 s5) (soul-after-drop mob2 s5 s6) (soul-after-drop mob2 s6 s6)
    (soul-after-drop mob3 s0 s1) (soul-after-drop mob3 s1 s2) (soul-after-drop mob3 s2 s3) (soul-after-drop mob3 s3 s4) (soul-after-drop mob3 s4 s5) (soul-after-drop mob3 s5 s6) (soul-after-drop mob3 s6 s6)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)
    (soul-spend-for-level pl1 pl2 s2 s0) (soul-spend-for-level pl1 pl2 s3 s1) (soul-spend-for-level pl1 pl2 s4 s2) (soul-spend-for-level pl1 pl2 s5 s3) (soul-spend-for-level pl1 pl2 s6 s4)
    (soul-spend-for-level pl2 pl3 s3 s0) (soul-spend-for-level pl2 pl3 s4 s1) (soul-spend-for-level pl2 pl3 s5 s2) (soul-spend-for-level pl2 pl3 s6 s3)

    (titanite-at blighttown)

    ;; boss weapon requirements
    (can-damage-boss quelaag w1)
  )
  (:goal (and
    (not (is-alive quelaag))
    (deposited-soul quelaag)
  ))
)

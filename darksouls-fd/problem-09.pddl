(define (problem p09-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink ruins smith-hut valley - location
    titanite1 titanite2 - key
    dummy-minor-enemy - minor-enemy
    miniboss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 w2 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 - soul-level
  )
  (:init
    (connected firelink ruins)
    (connected ruins firelink)
    (connected ruins smith-hut)
    (connected smith-hut ruins)
    (connected smith-hut valley)
    (connected valley smith-hut)
    (titanite-at ruins)
    (titanite-at smith-hut)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire smith-hut)
    (is-blacksmith smith-hut)
    (enemy-at miniboss valley)
    (is-alive miniboss)
    (has-active-boss valley)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    ;; hp ordering (<=)
    (hp-leq hp0 hp0) (hp-leq hp0 hp1) (hp-leq hp0 hp2) (hp-leq hp0 hp3)
    (hp-leq hp1 hp1) (hp-leq hp1 hp2) (hp-leq hp1 hp3)
    (hp-leq hp2 hp2) (hp-leq hp2 hp3)
    (hp-leq hp3 hp3)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1)
    (player-weapon-level w0)
    (wlevel-next w0 w1)
    (wlevel-next w1 w2)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase miniboss bp2)
    (boss-current-phase miniboss bp2)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack dummy-minor-enemy hp3 hp2)
    (hp-after-attack dummy-minor-enemy hp2 hp1)
    (hp-after-attack dummy-minor-enemy hp1 hp0)
    (hp-after-attack miniboss hp3 hp2)
    (hp-after-attack miniboss hp2 hp1)
    (hp-after-attack miniboss hp1 hp0)

    ;; souls gain from minor enemies (saturating)
    (soul-after-drop dummy-minor-enemy s0 s1) (soul-after-drop dummy-minor-enemy s1 s2) (soul-after-drop dummy-minor-enemy s2 s3) (soul-after-drop dummy-minor-enemy s3 s4) (soul-after-drop dummy-minor-enemy s4 s5) (soul-after-drop dummy-minor-enemy s5 s6) (soul-after-drop dummy-minor-enemy s6 s6)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss miniboss w2)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (is-alive miniboss))
    (deposited-soul miniboss)
  ))
    (:metric minimize (total-cost))
)

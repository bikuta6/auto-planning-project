(define (problem p03-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink parish bell-tower - location
    key-bell - key
    bell-tower-guard - minor-enemy
    dummmy-boss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 - soul-level
  )
  (:init
    (connected firelink parish)
    (connected parish firelink)
    (connected parish bell-tower)
    (locked parish bell-tower)
    (locked bell-tower parish)
    (key-at key-bell firelink)
    (matches key-bell parish bell-tower)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire parish)
    (is-blacksmith firelink)
    (enemy-at bell-tower-guard bell-tower)
    (is-alive bell-tower-guard)
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

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase dummmy-boss bp2)
    (boss-current-phase dummmy-boss bp2)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack bell-tower-guard hp3 hp2)
    (hp-after-attack bell-tower-guard hp2 hp1)
    (hp-after-attack bell-tower-guard hp1 hp0)
    (hp-after-attack dummmy-boss hp3 hp2)
    (hp-after-attack dummmy-boss hp2 hp1)
    (hp-after-attack dummmy-boss hp1 hp0)

    ;; souls gain from minor enemies (saturating)
    (soul-after-drop bell-tower-guard s0 s1) (soul-after-drop bell-tower-guard s1 s2) (soul-after-drop bell-tower-guard s2 s3) (soul-after-drop bell-tower-guard s3 s4) (soul-after-drop bell-tower-guard s4 s5) (soul-after-drop bell-tower-guard s5 s6) (soul-after-drop bell-tower-guard s6 s6)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss dummmy-boss w0)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (locked parish bell-tower))
))
    (:metric minimize (total-cost))
)

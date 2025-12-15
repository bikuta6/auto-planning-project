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
    s0 - soul-token
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
    (player-level pl0) (player-level-next pl0 pl1)
    (player-weapon-level w0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase dummmy-boss bp2)
    (boss-phase dummmy-boss bp2)
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

    ;; soul drops from minor enemies
    (drops-soul bell-tower-guard s0)

    ;; boss weapon requirements
    (can-damage-boss dummmy-boss w0)
  )
  (:goal (and
    (not (locked parish bell-tower))
  ))
)

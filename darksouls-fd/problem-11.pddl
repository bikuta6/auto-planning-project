(define (problem p11-forced-levelup-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink undead-burg lower-burg boss-arena - location
    gate-key - key
    hollow1 hollow2 - minor-enemy
    taurus-demon - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 - soul-level
  )
  (:init
    (connected firelink undead-burg)
    (connected undead-burg firelink)
    (connected undead-burg lower-burg)
    (connected lower-burg undead-burg)
    (connected lower-burg boss-arena)
    (connected boss-arena lower-burg)
    (locked lower-burg boss-arena)
    (locked boss-arena lower-burg)
    (key-at gate-key undead-burg)
    (matches gate-key lower-burg boss-arena)
    (titanite-at undead-burg)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire undead-burg)
    (is-blacksmith firelink)
    (enemy-at hollow1 undead-burg)
    (enemy-at hollow2 lower-burg)
    (enemy-at taurus-demon boss-arena)
    (is-alive hollow1)
    (is-alive hollow2)
    (is-alive taurus-demon)
    (has-active-boss boss-arena)
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
    (player-current-level pl0) (player-level-next pl0 pl1)
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
    (boss-max-phase taurus-demon bp2)
    (boss-current-phase taurus-demon bp2)
    (estus-unlocked e1)
    (estus-full e1)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack hollow1 hp3 hp2)
    (hp-after-attack hollow1 hp2 hp1)
    (hp-after-attack hollow1 hp1 hp0)
    (hp-after-attack hollow2 hp3 hp2)
    (hp-after-attack hollow2 hp2 hp1)
    (hp-after-attack hollow2 hp1 hp0)
    (hp-after-attack taurus-demon hp3 hp2)
    (hp-after-attack taurus-demon hp2 hp1)
    (hp-after-attack taurus-demon hp1 hp0)

    ;; souls gain from minor enemies (saturating)
    (soul-after-drop hollow1 s0 s1) (soul-after-drop hollow1 s1 s2) (soul-after-drop hollow1 s2 s3) (soul-after-drop hollow1 s3 s4) (soul-after-drop hollow1 s4 s5) (soul-after-drop hollow1 s5 s6) (soul-after-drop hollow1 s6 s6)
    (soul-after-drop hollow2 s0 s1) (soul-after-drop hollow2 s1 s2) (soul-after-drop hollow2 s2 s3) (soul-after-drop hollow2 s3 s4) (soul-after-drop hollow2 s4 s5) (soul-after-drop hollow2 s5 s6) (soul-after-drop hollow2 s6 s6)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss taurus-demon w1)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (is-alive taurus-demon))
    (deposited-soul taurus-demon)
  ))
    (:metric minimize (total-cost))
)

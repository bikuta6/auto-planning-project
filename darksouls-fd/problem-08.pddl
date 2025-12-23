(define (problem p08-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink valley gatehouse inner-valley - location
    key-valley key-gate - key
    mob1 mob2 mob3 - minor-enemy
    dummy-boss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 - soul-level
  )
  (:init
    (connected firelink valley)
    (connected valley firelink)
    (connected valley gatehouse)
    (connected gatehouse valley)
    (connected gatehouse inner-valley)
    (connected inner-valley gatehouse)
    (locked gatehouse inner-valley)
    (locked inner-valley gatehouse)
    (key-at key-valley valley)
    (matches key-valley gatehouse inner-valley)
    (can-open-shortcut firelink valley)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire gatehouse)
    (is-blacksmith firelink)
    (enemy-at mob1 valley)
    (enemy-at mob2 gatehouse)
    (enemy-at mob3 inner-valley)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)
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
    (player-weapon-level w1)
    (wlevel-next w0 w1)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase dummy-boss bp2)
    (boss-current-phase dummy-boss bp2)
    (estus-unlocked e1)
    (estus-full e1)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack dummy-boss hp3 hp2)
    (hp-after-attack dummy-boss hp2 hp1)
    (hp-after-attack dummy-boss hp1 hp0)
    (hp-after-attack mob1 hp3 hp2)
    (hp-after-attack mob1 hp2 hp1)
    (hp-after-attack mob1 hp1 hp0)
    (hp-after-attack mob2 hp3 hp2)
    (hp-after-attack mob2 hp2 hp1)
    (hp-after-attack mob2 hp1 hp0)
    (hp-after-attack mob3 hp3 hp2)
    (hp-after-attack mob3 hp2 hp1)
    (hp-after-attack mob3 hp1 hp0)

    ;; souls gain from minor enemies (saturating)
    (soul-after-drop mob1 s0 s1) (soul-after-drop mob1 s1 s2) (soul-after-drop mob1 s2 s3) (soul-after-drop mob1 s3 s4) (soul-after-drop mob1 s4 s5) (soul-after-drop mob1 s5 s6) (soul-after-drop mob1 s6 s6)
    (soul-after-drop mob2 s0 s1) (soul-after-drop mob2 s1 s2) (soul-after-drop mob2 s2 s3) (soul-after-drop mob2 s3 s4) (soul-after-drop mob2 s4 s5) (soul-after-drop mob2 s5 s6) (soul-after-drop mob2 s6 s6)
    (soul-after-drop mob3 s0 s1) (soul-after-drop mob3 s1 s2) (soul-after-drop mob3 s2 s3) (soul-after-drop mob3 s3 s4) (soul-after-drop mob3 s4 s5) (soul-after-drop mob3 s5 s6) (soul-after-drop mob3 s6 s6)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss dummy-boss w0)
    (can-damage-boss dummy-boss w1)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (locked gatehouse inner-valley))
    (at-player inner-valley)
  ))
    (:metric minimize (total-cost))
)

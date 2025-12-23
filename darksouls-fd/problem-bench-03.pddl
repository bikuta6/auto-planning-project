;; ===================================================================
;; BENCHMARK PROBLEM 03 - FD Version: Resource Management
;; Difficulty: Easy-Medium
;; ===================================================================
(define (problem bench-03-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink area1 area2 boss-room - location
    soldier1 soldier2 - minor-enemy
    area-boss - boss

    hp0 hp1 hp2 hp3 hp4 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 - soul-level
  )
  (:init
    ;; Map
    (connected firelink area1)
    (connected area1 firelink)
    (connected area1 area2)
    (connected area2 area1)
    (connected area2 boss-room)
    (connected boss-room area2)
    (is-firelink firelink)
    (has-bonfire firelink)

    ;; Minor enemies
    (enemy-at soldier1 area1)
    (is-alive soldier1)
    (enemy-at soldier2 area2)
    (is-alive soldier2)

    ;; Bosses
    (enemy-at area-boss boss-room)
    (is-alive area-boss)
    (has-active-boss boss-room)

    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; HP ladder
    (hp-next hp0 hp1)     (hp-next hp1 hp2)     (hp-next hp2 hp3)     (hp-next hp3 hp4)
    (hp-zero hp0)
    (hp-leq hp0 hp0)     (hp-leq hp0 hp1)     (hp-leq hp0 hp2)     (hp-leq hp0 hp3)     (hp-leq hp0 hp4)
    (hp-leq hp1 hp1)     (hp-leq hp1 hp2)     (hp-leq hp1 hp3)     (hp-leq hp1 hp4)
    (hp-leq hp2 hp2)     (hp-leq hp2 hp3)     (hp-leq hp2 hp4)
    (hp-leq hp3 hp3)     (hp-leq hp3 hp4)
    (hp-leq hp4 hp4)    (player-max-hp hp4)
    (player-hp hp4)
    (player-current-level pl0)
    (player-level-next pl0 pl1)
    (player-weapon-level w0)

    ;; Boss phases
    (boss-phase-zero bp0)
    (boss-phase-next bp5 bp4)
    (boss-phase-next bp4 bp3)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase area-boss bp5)
    (boss-current-phase area-boss bp5)

    ;; Estus (leave e3 locked for boss to unlock)
    (estus-unlocked e1) (estus-full e1)
    (estus-unlocked e2) (estus-full e2)

    ;; Souls ladder
    (soul-next s0 s1)     (soul-next s1 s2)     (soul-next s2 s3)     (soul-next s3 s4)
    (soul-next s4 s5)     (soul-next s5 s6)     (soul-next s6 s7)     (soul-next s7 s8)
    (player-max-souls s8)
    (player-souls s0)

    ;; Combat damage tables
    (hp-after-attack soldier1 hp4 hp3)
    (hp-after-attack soldier1 hp3 hp2)
    (hp-after-attack soldier1 hp2 hp1)
    (hp-after-attack soldier1 hp1 hp0)
    (hp-after-attack soldier2 hp4 hp3)
    (hp-after-attack soldier2 hp3 hp2)
    (hp-after-attack soldier2 hp2 hp1)
    (hp-after-attack soldier2 hp1 hp0)
    (hp-after-attack area-boss hp4 hp3)
    (hp-after-attack area-boss hp3 hp2)
    (hp-after-attack area-boss hp2 hp1)
    (hp-after-attack area-boss hp1 hp0)

    ;; Soul drops (saturating)
    (soul-after-drop soldier1 s0 s2)
    (soul-after-drop soldier1 s1 s3)
    (soul-after-drop soldier1 s2 s4)
    (soul-after-drop soldier1 s3 s5)
    (soul-after-drop soldier1 s4 s6)
    (soul-after-drop soldier1 s5 s7)
    (soul-after-drop soldier1 s6 s8)
    (soul-after-drop soldier1 s7 s8)
    (soul-after-drop soldier1 s8 s8)
    (soul-after-drop soldier2 s0 s2)
    (soul-after-drop soldier2 s1 s3)
    (soul-after-drop soldier2 s2 s4)
    (soul-after-drop soldier2 s3 s5)
    (soul-after-drop soldier2 s4 s6)
    (soul-after-drop soldier2 s5 s7)
    (soul-after-drop soldier2 s6 s8)
    (soul-after-drop soldier2 s7 s8)
    (soul-after-drop soldier2 s8 s8)
    (soul-after-drop area-boss s0 s3)
    (soul-after-drop area-boss s1 s4)
    (soul-after-drop area-boss s2 s5)
    (soul-after-drop area-boss s3 s6)
    (soul-after-drop area-boss s4 s7)
    (soul-after-drop area-boss s5 s8)
    (soul-after-drop area-boss s6 s8)
    (soul-after-drop area-boss s7 s8)
    (soul-after-drop area-boss s8 s8)

    ;; Level up costs
    (soul-spend-for-level pl0 pl1 s2 s0)
    (soul-spend-for-level pl0 pl1 s3 s1)
    (soul-spend-for-level pl0 pl1 s4 s2)
    (soul-spend-for-level pl0 pl1 s5 s3)
    (soul-spend-for-level pl0 pl1 s6 s4)
    (soul-spend-for-level pl0 pl1 s7 s5)
    (soul-spend-for-level pl0 pl1 s8 s6)

    ;; Boss weapon requirements
    (can-damage-boss area-boss w0)

    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul area-boss)
  ))
  (:metric minimize (total-cost))
)

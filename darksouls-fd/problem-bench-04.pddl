;; ===================================================================
;; BENCHMARK PROBLEM 04 - FD Version: Locked Passage
;; Difficulty: Medium
;; ===================================================================
(define (problem bench-04-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink upper-area locked-area boss-room - location
    gate-key - key
    guard - minor-enemy
    gate-boss - boss

    hp0 hp1 hp2 hp3 hp4 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 - soul-level
  )
  (:init
    ;; Map
    (connected firelink upper-area)
    (connected upper-area firelink)
    (connected upper-area locked-area)
    (connected locked-area upper-area)
    (connected locked-area boss-room)
    (connected boss-room locked-area)
    (is-firelink firelink)
    (has-bonfire firelink)

    ;; Keys
    (key-at gate-key upper-area)
    (matches gate-key upper-area locked-area)
    (locked upper-area locked-area)
    (locked locked-area upper-area)

    ;; Minor enemies
    (enemy-at guard upper-area)
    (is-alive guard)

    ;; Bosses
    (enemy-at gate-boss boss-room)
    (is-alive gate-boss)
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
    (boss-max-phase gate-boss bp5)
    (boss-current-phase gate-boss bp5)

    ;; Estus
    (estus-unlocked e1) (estus-full e1)
    (estus-unlocked e2) (estus-full e2)
    (estus-unlocked e3) (estus-full e3)

    ;; Souls ladder
    (soul-next s0 s1)     (soul-next s1 s2)     (soul-next s2 s3)     (soul-next s3 s4)
    (soul-next s4 s5)     (soul-next s5 s6)     (soul-next s6 s7)     (soul-next s7 s8)
    (player-max-souls s8)
    (player-souls s0)

    ;; Combat damage tables
    (hp-after-attack guard hp4 hp3)
    (hp-after-attack guard hp3 hp2)
    (hp-after-attack guard hp2 hp1)
    (hp-after-attack guard hp1 hp0)
    (hp-after-attack gate-boss hp4 hp3)
    (hp-after-attack gate-boss hp3 hp2)
    (hp-after-attack gate-boss hp2 hp1)
    (hp-after-attack gate-boss hp1 hp0)

    ;; Soul drops (saturating)
    (soul-after-drop guard s0 s2)
    (soul-after-drop guard s1 s3)
    (soul-after-drop guard s2 s4)
    (soul-after-drop guard s3 s5)
    (soul-after-drop guard s4 s6)
    (soul-after-drop guard s5 s7)
    (soul-after-drop guard s6 s8)
    (soul-after-drop guard s7 s8)
    (soul-after-drop guard s8 s8)
    (soul-after-drop gate-boss s0 s3)
    (soul-after-drop gate-boss s1 s4)
    (soul-after-drop gate-boss s2 s5)
    (soul-after-drop gate-boss s3 s6)
    (soul-after-drop gate-boss s4 s7)
    (soul-after-drop gate-boss s5 s8)
    (soul-after-drop gate-boss s6 s8)
    (soul-after-drop gate-boss s7 s8)
    (soul-after-drop gate-boss s8 s8)

    ;; Level up costs
    (soul-spend-for-level pl0 pl1 s2 s0)
    (soul-spend-for-level pl0 pl1 s3 s1)
    (soul-spend-for-level pl0 pl1 s4 s2)
    (soul-spend-for-level pl0 pl1 s5 s3)
    (soul-spend-for-level pl0 pl1 s6 s4)
    (soul-spend-for-level pl0 pl1 s7 s5)
    (soul-spend-for-level pl0 pl1 s8 s6)

    ;; Boss weapon requirements
    (can-damage-boss gate-boss w0)

    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul gate-boss)
  ))
  (:metric minimize (total-cost))
)

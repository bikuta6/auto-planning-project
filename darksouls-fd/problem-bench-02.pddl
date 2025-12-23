;; ===================================================================
;; BENCHMARK PROBLEM 02 - FD Version: First Combat
;; Difficulty: Easy
;; ===================================================================
(define (problem bench-02-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink pathway boss-room - location
    hollow - minor-enemy
    first-boss - boss

    hp0 hp1 hp2 hp3 hp4 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 bp3 bp4 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 - soul-level
  )
  (:init
    ;; Map
    (connected firelink pathway)
    (connected pathway firelink)
    (connected pathway boss-room)
    (connected boss-room pathway)
    (is-firelink firelink)
    (has-bonfire firelink)

    ;; Minor enemies
    (enemy-at hollow pathway)
    (is-alive hollow)

    ;; Bosses
    (enemy-at first-boss boss-room)
    (is-alive first-boss)
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
    (boss-phase-next bp4 bp3)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase first-boss bp4)
    (boss-current-phase first-boss bp4)

    ;; Estus (leave e3 locked for boss to unlock)
    (estus-unlocked e1) (estus-full e1)
    (estus-unlocked e2) (estus-full e2)

    ;; Souls ladder
    (soul-next s0 s1)     (soul-next s1 s2)     (soul-next s2 s3)     (soul-next s3 s4)
    (soul-next s4 s5)     (soul-next s5 s6)     (soul-next s6 s7)     (soul-next s7 s8)
    (player-max-souls s8)
    (player-souls s0)

    ;; Combat damage tables
    (hp-after-attack hollow hp4 hp3)
    (hp-after-attack hollow hp3 hp2)
    (hp-after-attack hollow hp2 hp1)
    (hp-after-attack hollow hp1 hp0)
    (hp-after-attack first-boss hp4 hp3)
    (hp-after-attack first-boss hp3 hp2)
    (hp-after-attack first-boss hp2 hp1)
    (hp-after-attack first-boss hp1 hp0)

    ;; Soul drops (saturating)
    (soul-after-drop hollow s0 s2)
    (soul-after-drop hollow s1 s3)
    (soul-after-drop hollow s2 s4)
    (soul-after-drop hollow s3 s5)
    (soul-after-drop hollow s4 s6)
    (soul-after-drop hollow s5 s7)
    (soul-after-drop hollow s6 s8)
    (soul-after-drop hollow s7 s8)
    (soul-after-drop hollow s8 s8)
    (soul-after-drop first-boss s0 s3)
    (soul-after-drop first-boss s1 s4)
    (soul-after-drop first-boss s2 s5)
    (soul-after-drop first-boss s3 s6)
    (soul-after-drop first-boss s4 s7)
    (soul-after-drop first-boss s5 s8)
    (soul-after-drop first-boss s6 s8)
    (soul-after-drop first-boss s7 s8)
    (soul-after-drop first-boss s8 s8)

    ;; Level up costs
    (soul-spend-for-level pl0 pl1 s2 s0)
    (soul-spend-for-level pl0 pl1 s3 s1)
    (soul-spend-for-level pl0 pl1 s4 s2)
    (soul-spend-for-level pl0 pl1 s5 s3)
    (soul-spend-for-level pl0 pl1 s6 s4)
    (soul-spend-for-level pl0 pl1 s7 s5)
    (soul-spend-for-level pl0 pl1 s8 s6)

    ;; Boss weapon requirements
    (can-damage-boss first-boss w0)

    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul first-boss)
  ))
  (:metric minimize (total-cost))
)

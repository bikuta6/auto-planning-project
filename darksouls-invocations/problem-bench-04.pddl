;; ===================================================================
;; BENCHMARK PROBLEM 04: Locked Passage
;; Difficulty: Medium
;; Focus: Exploration with locked door and key
;; ===================================================================
(define (problem bench-04)
  (:domain dark-souls)
  (:objects
    firelink upper-area locked-area boss-room - location
    gate-key - key
    guard - minor-enemy
    gate-boss - boss
  )
  (:init
    (connected firelink upper-area)
    (connected upper-area firelink)
    (connected upper-area locked-area)
    (connected locked-area upper-area)
    (connected locked-area boss-room)
    (connected boss-room locked-area)
    
    (locked upper-area locked-area)
    (locked locked-area upper-area)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire locked-area)
    
    (key-at gate-key upper-area)
    (matches gate-key upper-area locked-area)
    
    (enemy-at guard upper-area)
    (is-alive guard)
    
    (enemy-at gate-boss boss-room)
    (is-alive gate-boss)
    (has-active-boss boss-room)
    
    (= (player-health) 110)
    (= (player-max-health) 110)
    (= (player-damage) 22)
    (= (player-souls) 0)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    (= (enemy-health guard) 50)
    (= (enemy-max-health guard) 50)
    (= (enemy-damage guard) 14)
    (= (enemy-soul-value guard) 60)
    
    (= (enemy-health gate-boss) 140)
    (= (enemy-max-health gate-boss) 140)
    (= (enemy-damage gate-boss) 25)
    (= (enemy-soul-value gate-boss) 800)
    (= (boss-required-weapon-level gate-boss) 0)

    ;; Summon stats (shared default configuration)
    (summon-available)
    (= (summon-health) 0)
    (= (summon-max-health) 100)
    (= (summon-damage) 18)
    (= (summon-cost) 10)
  )
  (:goal (and
    (deposited-soul gate-boss)
  ))
  (:metric minimize (total-cost))
)

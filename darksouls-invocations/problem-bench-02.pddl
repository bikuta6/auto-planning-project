;; ===================================================================
;; BENCHMARK PROBLEM 02: First Combat
;; Difficulty: Easy
;; Focus: Minor enemy combat before boss
;; ===================================================================
(define (problem bench-02)
  (:domain dark-souls)
  (:objects
    firelink pathway boss-room - location
    hollow - minor-enemy
    first-boss - boss
    dummmy-key - key
  )
  (:init
    (connected firelink pathway)
    (connected pathway firelink)
    (connected pathway boss-room)
    (connected boss-room pathway)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    
    (enemy-at hollow pathway)
    (is-alive hollow)
    
    (enemy-at first-boss boss-room)
    (is-alive first-boss)
    (has-active-boss boss-room)
    
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 25)
    (= (player-souls) 0)
    (= (estus-charges) 1)
    (= (estus-max) 1)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 50)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    (= (enemy-health hollow) 40)
    (= (enemy-max-health hollow) 40)
    (= (enemy-damage hollow) 10)
    (= (enemy-soul-value hollow) 50)
    
    (= (enemy-health first-boss) 200)
    (= (enemy-max-health first-boss) 200)
    (= (enemy-damage first-boss) 50)
    (= (enemy-soul-value first-boss) 600)
    (= (boss-required-weapon-level first-boss) 0)

    ;; Summon stats (shared default configuration)
    (summon-available)
    (= (summon-health) 0)
    (= (summon-max-health) 100)
    (= (summon-damage) 18)
    (= (summon-cost) 150)
  )
  (:goal (and
    (deposited-soul first-boss)
  ))
  (:metric minimize (total-cost))
)

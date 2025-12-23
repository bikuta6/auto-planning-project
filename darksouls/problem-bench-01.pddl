;; ===================================================================
;; BENCHMARK PROBLEM 01: Tutorial
;; Difficulty: Very Easy
;; Focus: Basic navigation and single boss fight
;; ===================================================================
(define (problem bench-01)
  (:domain dark-souls)
  (:objects
    firelink boss-room - location
    tutorial-boss - boss
    dummy-minor-enemy - minor-enemy
    dummy-key - key
  )
  (:init
    ;; Simple linear map
    (connected firelink boss-room)
    (connected boss-room firelink)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire boss-room)
    
    (enemy-at tutorial-boss boss-room)
    (is-alive tutorial-boss)
    (has-active-boss boss-room)
    
    ;; Player stats - strong enough to win easily
    (= (player-health) 150)
    (= (player-max-health) 150)
    (= (player-damage) 30)
    (= (player-souls) 0)
    (= (estus-charges) 5)
    (= (estus-max) 5)
    (= (estus-heal-amount) 50)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    ;; Boss stats - weak boss
    (= (enemy-health tutorial-boss) 90)
    (= (enemy-max-health tutorial-boss) 90)
    (= (enemy-damage tutorial-boss) 15)
    (= (enemy-soul-value tutorial-boss) 500)
    (= (boss-required-weapon-level tutorial-boss) 0)
  )
  (:goal (and
    (deposited-soul tutorial-boss)
  ))
  (:metric minimize (total-cost))
)

;; ===================================================================
;; BENCHMARK PROBLEM 03: Resource Management
;; Difficulty: Easy-Medium
;; Focus: Multiple enemies, need for healing strategy
;; ===================================================================
(define (problem bench-03)
  (:domain dark-souls)
  (:objects
    firelink area1 area2 boss-room - location
    soldier1 soldier2 - minor-enemy
    area-boss - boss
    dummmy-key - key
  )
  (:init
    (connected firelink area1)
    (connected area1 firelink)
    (connected area1 area2)
    (connected area2 area1)
    (connected area2 boss-room)
    (connected boss-room area2)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    
    (enemy-at soldier1 area1)
    (enemy-at soldier2 area2)
    (is-alive soldier1)
    (is-alive soldier2)
    
    (enemy-at area-boss boss-room)
    (is-alive area-boss)
    (has-active-boss boss-room)
    
    (= (player-health) 100)
    (= (player-max-health) 100)
    (= (player-damage) 20)
    (= (player-souls) 0)
    (= (estus-charges) 2)
    (= (estus-max) 2)
    (= (estus-heal-amount) 35)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    (= (enemy-health soldier1) 35)
    (= (enemy-max-health soldier1) 35)
    (= (enemy-damage soldier1) 12)
    (= (enemy-soul-value soldier1) 40)
    
    (= (enemy-health soldier2) 40)
    (= (enemy-max-health soldier2) 40)
    (= (enemy-damage soldier2) 15)
    (= (enemy-soul-value soldier2) 45)
    
    (= (enemy-health area-boss) 180)
    (= (enemy-max-health area-boss) 180)
    (= (enemy-damage area-boss) 20)
    (= (enemy-soul-value area-boss) 700)
    (= (boss-required-weapon-level area-boss) 0)
  )
  (:goal (and
    (deposited-soul area-boss)
  ))
  (:metric minimize (total-cost))
)

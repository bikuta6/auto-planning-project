;; ===================================================================
;; BENCHMARK PROBLEM 05: Weapon Upgrade Required
;; Difficulty: Medium
;; Focus: Need to find titanite and upgrade weapon
;; ===================================================================
(define (problem bench-05)
  (:domain dark-souls)
  (:objects
    firelink forge mines boss-chamber - location
    smith-key - key
    miner - minor-enemy
    armored-boss - boss
  )
  (:init
    (connected firelink forge)
    (connected forge firelink)
    (connected firelink mines)
    (connected mines firelink)
    (connected mines boss-chamber)
    (connected boss-chamber mines)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    (is-blacksmith forge)
    
    (titanite-at mines)
    
    (enemy-at miner mines)
    (is-alive miner)
    
    (enemy-at armored-boss boss-chamber)
    (is-alive armored-boss)
    (has-active-boss boss-chamber)
    
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 18)
    (= (player-souls) 0)
    (= (estus-charges) 4)
    (= (estus-max) 4)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    (= (enemy-health miner) 45)
    (= (enemy-max-health miner) 45)
    (= (enemy-damage miner) 13)
    (= (enemy-soul-value miner) 55)
    
    (= (enemy-health armored-boss) 160)
    (= (enemy-max-health armored-boss) 160)
    (= (enemy-damage armored-boss) 28)
    (= (enemy-soul-value armored-boss) 900)
    (= (boss-required-weapon-level armored-boss) 1) ;; Requires weapon upgrade!

    ;; Summon stats (shared default configuration)
    (summon-available)
    (= (summon-health) 0)
    (= (summon-max-health) 100)
    (= (summon-damage) 18)
    (= (summon-cost) 150)
  )
  (:goal (and
    (deposited-soul armored-boss)
  ))
  (:metric minimize (total-cost))
)

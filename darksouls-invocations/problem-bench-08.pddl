;; ===================================================================
;; BENCHMARK PROBLEM 08: Strategic Depth
;; Difficulty: Hard
;; Focus: Multiple enemies, need for leveling and strategic resting
;; ===================================================================
(define (problem bench-08)
  (:domain dark-souls)
  (:objects
    firelink courtyard armory sanctum boss-hall - location
    gate-key - key
    warrior1 warrior2 warrior3 warrior4 - minor-enemy
    sanctum-lord - boss
  )
  (:init
    (connected firelink courtyard)
    (connected courtyard firelink)
    (connected courtyard armory)
    (connected armory courtyard)
    (connected courtyard sanctum)
    (connected sanctum courtyard)
    (connected sanctum boss-hall)
    (connected boss-hall sanctum)
    
    (locked courtyard sanctum)
    (locked sanctum courtyard)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire sanctum)
    
    (key-at gate-key armory)
    (matches gate-key courtyard sanctum)
    
    (enemy-at warrior1 courtyard)
    (enemy-at warrior2 armory)
    (enemy-at warrior3 sanctum)
    (enemy-at warrior4 sanctum)
    (is-alive warrior1)
    (is-alive warrior2)
    (is-alive warrior3)
    (is-alive warrior4)
    
    (enemy-at sanctum-lord boss-hall)
    (is-alive sanctum-lord)
    (has-active-boss boss-hall)
    
    (= (player-health) 110)
    (= (player-max-health) 110)
    (= (player-damage) 20)
    (= (player-souls) 0)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 38)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    (= (enemy-health warrior1) 52)
    (= (enemy-max-health warrior1) 52)
    (= (enemy-damage warrior1) 17)
    (= (enemy-soul-value warrior1) 65)
    
    (= (enemy-health warrior2) 55)
    (= (enemy-max-health warrior2) 55)
    (= (enemy-damage warrior2) 18)
    (= (enemy-soul-value warrior2) 68)
    
    (= (enemy-health warrior3) 58)
    (= (enemy-max-health warrior3) 58)
    (= (enemy-damage warrior3) 19)
    (= (enemy-soul-value warrior3) 70)
    
    (= (enemy-health warrior4) 60)
    (= (enemy-max-health warrior4) 60)
    (= (enemy-damage warrior4) 20)
    (= (enemy-soul-value warrior4) 72)
    
    (= (enemy-health sanctum-lord) 170)
    (= (enemy-max-health sanctum-lord) 170)
    (= (enemy-damage sanctum-lord) 30)
    (= (enemy-soul-value sanctum-lord) 1000)
    (= (boss-required-weapon-level sanctum-lord) 0)

    ;; Summon stats (shared default configuration)
    (summon-available)
    (= (summon-health) 0)
    (= (summon-max-health) 100)
    (= (summon-damage) 18)
    (= (summon-cost) 10)
  )
  (:goal (and
    (deposited-soul sanctum-lord)
  ))
  (:metric minimize (total-cost))
)

;; ===================================================================
;; BENCHMARK PROBLEM 06: Two Bosses
;; Difficulty: Medium-Hard
;; Focus: Multiple boss objectives
;; ===================================================================
(define (problem bench-06)
  (:domain dark-souls)
  (:objects
    firelink tower crypt - location
    knight thief - minor-enemy
    tower-boss crypt-boss - boss
    dummy-key - key
  )
  (:init
    (connected firelink tower)
    (connected tower firelink)
    (connected firelink crypt)
    (connected crypt firelink)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire tower)
    
    (enemy-at knight tower)
    (enemy-at thief crypt)
    (is-alive knight)
    (is-alive thief)
    
    (enemy-at tower-boss tower)
    (enemy-at crypt-boss crypt)
    (is-alive tower-boss)
    (is-alive crypt-boss)
    (has-active-boss tower)
    (has-active-boss crypt)
    
    (= (player-health) 130)
    (= (player-max-health) 130)
    (= (player-damage) 24)
    (= (player-souls) 0)
    (= (estus-charges) 4)
    (= (estus-max) 4)
    (= (estus-heal-amount) 45)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    (= (enemy-health knight) 55)
    (= (enemy-max-health knight) 55)
    (= (enemy-damage knight) 16)
    (= (enemy-soul-value knight) 70)
    
    (= (enemy-health thief) 50)
    (= (enemy-max-health thief) 50)
    (= (enemy-damage thief) 18)
    (= (enemy-soul-value thief) 65)
    
    (= (enemy-health tower-boss) 140)
    (= (enemy-max-health tower-boss) 140)
    (= (enemy-damage tower-boss) 26)
    (= (enemy-soul-value tower-boss) 850)
    (= (boss-required-weapon-level tower-boss) 0)
    
    (= (enemy-health crypt-boss) 150)
    (= (enemy-max-health crypt-boss) 150)
    (= (enemy-damage crypt-boss) 28)
    (= (enemy-soul-value crypt-boss) 900)
    (= (boss-required-weapon-level crypt-boss) 0)
  )
  (:goal (and
    (deposited-soul tower-boss)
    (deposited-soul crypt-boss)
  ))
  (:metric minimize (total-cost))
)

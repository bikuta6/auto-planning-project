;; ===================================================================
;; BENCHMARK PROBLEM 10: Epic Challenge
;; Difficulty: Very Hard
;; Focus: Large map, many enemies, multiple upgrades needed, complex goals
;; ===================================================================
(define (problem bench-10)
  (:domain dark-souls)
  (:objects
    firelink workshop burg parish depths catacombs fortress throne - location
    master-key catacombs-key - key
    hollow bandit skeleton giant - minor-enemy
    gaping-dragon iron-golem final-lord - boss
  )
  (:init
    (connected firelink workshop)
    (connected workshop firelink)
    (connected firelink burg)
    (connected burg firelink)
    (connected burg parish)
    (connected parish burg)
    (connected parish depths)
    (connected depths parish)
    (connected firelink catacombs)
    (connected catacombs firelink)
    (connected catacombs fortress)
    (connected fortress catacombs)
    (connected fortress throne)
    (connected throne fortress)
    
    (locked parish depths)
    (locked depths parish)
    (locked catacombs fortress)
    (locked fortress catacombs)
    
    (can-open-shortcut parish firelink)
    (can-open-shortcut fortress catacombs)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire parish)
    (has-bonfire fortress)
    (is-blacksmith workshop)
    
    (key-at master-key burg)
    (key-at catacombs-key depths)
    (matches master-key parish depths)
    (matches catacombs-key catacombs fortress)
    
    (titanite-at workshop)
    
    (enemy-at hollow burg)
    (enemy-at bandit parish)
    (enemy-at skeleton catacombs)
    (enemy-at giant fortress)
    (is-alive hollow)
    (is-alive bandit)
    (is-alive skeleton)
    (is-alive giant)
    
    (enemy-at gaping-dragon depths)
    (enemy-at iron-golem fortress)
    (enemy-at final-lord throne)
    (is-alive gaping-dragon)
    (is-alive iron-golem)
    (is-alive final-lord)
    (has-active-boss depths)
    (has-active-boss fortress)
    (has-active-boss throne)
    
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 20)
    (= (player-souls) 0)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    (= (enemy-health hollow) 50)
    (= (enemy-max-health hollow) 50)
    (= (enemy-damage hollow) 16)
    (= (enemy-soul-value hollow) 60)
    
    (= (enemy-health bandit) 60)
    (= (enemy-max-health bandit) 60)
    (= (enemy-damage bandit) 20)
    (= (enemy-soul-value bandit) 75)
    
    (= (enemy-health skeleton) 55)
    (= (enemy-max-health skeleton) 55)
    (= (enemy-damage skeleton) 18)
    (= (enemy-soul-value skeleton) 68)
    
    (= (enemy-health giant) 80)
    (= (enemy-max-health giant) 80)
    (= (enemy-damage giant) 25)
    (= (enemy-soul-value giant) 95)
    
    (= (enemy-health gaping-dragon) 160)
    (= (enemy-max-health gaping-dragon) 160)
    (= (enemy-damage gaping-dragon) 30)
    (= (enemy-soul-value gaping-dragon) 950)
    (= (boss-required-weapon-level gaping-dragon) 0)
    
    (= (enemy-health iron-golem) 180)
    (= (enemy-max-health iron-golem) 180)
    (= (enemy-damage iron-golem) 35)
    (= (enemy-soul-value iron-golem) 1100)
    (= (boss-required-weapon-level iron-golem) 1)
    
    (= (enemy-health final-lord) 200)
    (= (enemy-max-health final-lord) 200)
    (= (enemy-damage final-lord) 38)
    (= (enemy-soul-value final-lord) 1500)
    (= (boss-required-weapon-level final-lord) 1)

    ;; Summon stats (shared default configuration)
    (summon-available)
    (= (summon-health) 0)
    (= (summon-max-health) 100)
    (= (summon-damage) 18)
    (= (summon-cost) 150)
  )
  (:goal (and
    (deposited-soul gaping-dragon)
    (deposited-soul iron-golem)
    (deposited-soul final-lord)
  ))
  (:metric minimize (total-cost))
)

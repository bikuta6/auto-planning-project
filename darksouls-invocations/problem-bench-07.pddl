;; ===================================================================
;; BENCHMARK PROBLEM 07: Complex Navigation
;; Difficulty: Medium-Hard
;; Focus: Larger map with shortcuts
;; ===================================================================
(define (problem bench-07)
  (:domain dark-souls)
  (:objects
    firelink plaza upper lower shortcut-dest boss-arena - location
    plaza-key - key
    grunt1 grunt2 grunt3 - minor-enemy
    plaza-boss - boss
  )
  (:init
    (connected firelink plaza)
    (connected plaza firelink)
    (connected plaza upper)
    (connected upper plaza)
    (connected upper lower)
    (connected lower upper)
    (connected lower boss-arena)
    (connected boss-arena lower)
    
    (can-open-shortcut lower firelink)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire lower)
    
    (enemy-at grunt1 plaza)
    (enemy-at grunt2 upper)
    (enemy-at grunt3 lower)
    (is-alive grunt1)
    (is-alive grunt2)
    (is-alive grunt3)
    
    (enemy-at plaza-boss boss-arena)
    (is-alive plaza-boss)
    (has-active-boss boss-arena)
    
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 23)
    (= (player-souls) 0)
    (= (estus-charges) 4)
    (= (estus-max) 4)
    (= (estus-heal-amount) 42)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    (= (enemy-health grunt1) 48)
    (= (enemy-max-health grunt1) 48)
    (= (enemy-damage grunt1) 15)
    (= (enemy-soul-value grunt1) 58)
    
    (= (enemy-health grunt2) 52)
    (= (enemy-max-health grunt2) 52)
    (= (enemy-damage grunt2) 16)
    (= (enemy-soul-value grunt2) 62)
    
    (= (enemy-health grunt3) 50)
    (= (enemy-max-health grunt3) 50)
    (= (enemy-damage grunt3) 17)
    (= (enemy-soul-value grunt3) 60)
    
    (= (enemy-health plaza-boss) 155)
    (= (enemy-max-health plaza-boss) 155)
    (= (enemy-damage plaza-boss) 29)
    (= (enemy-soul-value plaza-boss) 950)
    (= (boss-required-weapon-level plaza-boss) 0)

    ;; Summon stats (shared default configuration)
    (summon-available)
    (= (summon-health) 0)
    (= (summon-max-health) 100)
    (= (summon-damage) 18)
    (= (summon-cost) 150)
  )
  (:goal (and
    (deposited-soul plaza-boss)
  ))
  (:metric minimize (total-cost))
)

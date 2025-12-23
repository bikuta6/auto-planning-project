;; =================================================================
;; PROBLEM 4: Multiple Bosses
;; Difficulty: Medium
;; Concepts: Sequential boss fights, resource management between fights
;; Challenge: Defeat two bosses, must return to deposit souls
;; =================================================================

(define (problem darksouls-p04-multiboss)
  (:domain dark-souls)
  (:objects
    firelink lower-area upper-area boss1-room boss2-room - location
    taurus-demon bell-gargoyle - boss
    dummy-minor-enemy - minor-enemy
    dummy-key - key
  )
  (:init
    ;; Map layout
    (connected firelink lower-area)
    (connected lower-area firelink)
    (connected lower-area boss1-room)
    (connected boss1-room lower-area)
    (connected lower-area upper-area)
    (connected upper-area lower-area)
    (connected upper-area boss2-room)
    (connected boss2-room upper-area)

    ;; Locations
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire upper-area)

    ;; Both bosses
    (enemy-at taurus-demon boss1-room)
    (is-alive taurus-demon)
    (has-active-boss boss1-room)
    
    (enemy-at bell-gargoyle boss2-room)
    (is-alive bell-gargoyle)
    (has-active-boss boss2-room)

    ;; Player stats
    (= (player-health) 130)
    (= (player-max-health) 130)
    (= (player-damage) 25)
    (= (player-souls) 0)
    (= (estus-charges) 4)
    (= (estus-max) 4)
    (= (estus-heal-amount) 45)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Boss 1 stats
    (= (enemy-health taurus-demon) 160)
    (= (enemy-max-health taurus-demon) 160)
    (= (enemy-damage taurus-demon) 30)
    (= (enemy-soul-value taurus-demon) 500)
    (= (boss-required-weapon-level taurus-demon) 0)

    ;; Boss 2 stats
    (= (enemy-health bell-gargoyle) 180)
    (= (enemy-max-health bell-gargoyle) 180)
    (= (enemy-damage bell-gargoyle) 28)
    (= (enemy-soul-value bell-gargoyle) 600)
    (= (boss-required-weapon-level bell-gargoyle) 0)
  )
  (:goal (and
    (deposited-soul taurus-demon)
    (deposited-soul bell-gargoyle)
  ))
  (:metric minimize (total-cost))
)

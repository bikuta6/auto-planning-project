;; =================================================================
;; PROBLEM 7: Tight Resource Management
;; Difficulty: Medium-Hard
;; Concepts: Strategic resting, resource optimization, fleeing
;; Challenge: Limited resources, may need to rest and revive enemies
;; =================================================================

(define (problem darksouls-p07-resources)
  (:domain dark-souls)
  (:objects
    firelink passage-1 passage-2 safe-room boss-arena - location
    seath-dragon - boss
    crystal-hollow-1 crystal-hollow-2 - minor-enemy
    dummy-key - key
  )
  (:init
    ;; Path to boss with safe room
    (connected firelink passage-1)
    (connected passage-1 firelink)
    (connected passage-1 passage-2)
    (connected passage-2 passage-1)
    (connected passage-2 safe-room)
    (connected safe-room passage-2)
    (connected safe-room boss-arena)
    (connected boss-arena safe-room)

    ;; Locations
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire safe-room)

    ;; Minor enemies draining resources
    (enemy-at crystal-hollow-1 passage-1)
    (is-alive crystal-hollow-1)
    
    (enemy-at crystal-hollow-2 passage-2)
    (is-alive crystal-hollow-2)

    ;; Boss
    (enemy-at seath-dragon boss-arena)
    (is-alive seath-dragon)
    (has-active-boss boss-arena)

    ;; Player stats - VERY limited resources
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 25)
    (= (player-souls) 0)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Minor enemy 1
    (= (enemy-health crystal-hollow-1) 60)
    (= (enemy-max-health crystal-hollow-1) 60)
    (= (enemy-damage crystal-hollow-1) 22)
    (= (enemy-soul-value crystal-hollow-1) 120)

    ;; Minor enemy 2
    (= (enemy-health crystal-hollow-2) 70)
    (= (enemy-max-health crystal-hollow-2) 70)
    (= (enemy-damage crystal-hollow-2) 24)
    (= (enemy-soul-value crystal-hollow-2) 140)

    ;; Boss stats - tough fight
    (= (enemy-health seath-dragon) 200)
    (= (enemy-max-health seath-dragon) 200)
    (= (enemy-damage seath-dragon) 30)
    (= (enemy-soul-value seath-dragon) 1000)
    (= (boss-required-weapon-level seath-dragon) 0)
  )
  (:goal (and
    (deposited-soul seath-dragon)
  ))
  (:metric minimize (total-cost))
)

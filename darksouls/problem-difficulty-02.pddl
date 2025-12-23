;; =================================================================
;; PROBLEM 2: Resource Management Introduction
;; Difficulty: Easy
;; Concepts: Movement, combat with health management, Estus usage
;; Challenge: Boss hits harder, must manage healing during fight
;; =================================================================

(define (problem darksouls-p02-healing)
  (:domain dark-souls)
  (:objects
    firelink passage boss-chamber - location
    asylum-demon - boss
    dummy-minor-enemy - minor-enemy
    dummy-key - key
  )
  (:init
    ;; Linear path to boss
    (connected firelink passage)
    (connected passage firelink)
    (connected passage boss-chamber)
    (connected boss-chamber passage)

    ;; Locations
    (is-firelink firelink)
    (has-bonfire firelink)

    ;; Boss
    (enemy-at asylum-demon boss-chamber)
    (is-alive asylum-demon)
    (has-active-boss boss-chamber)

    ;; Player stats - limited healing resources
    (= (player-health) 100)
    (= (player-max-health) 100)
    (= (player-damage) 20)
    (= (player-souls) 0)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Boss stats - requires healing during fight
    (= (enemy-health asylum-demon) 180)
    (= (enemy-max-health asylum-demon) 180)
    (= (enemy-damage asylum-demon) 25)
    (= (enemy-soul-value asylum-demon) 500)
    (= (boss-required-weapon-level asylum-demon) 0)
  )
  (:goal (and
    (deposited-soul asylum-demon)
  ))
  (:metric minimize (total-cost))
)

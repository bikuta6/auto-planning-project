;; =================================================================
;; PROBLEM 5: Locked Areas and Keys
;; Difficulty: Medium
;; Concepts: Exploration, key collection, unlocking doors
;; Challenge: Find key to access boss area
;; =================================================================

(define (problem darksouls-p05-keys)
  (:domain dark-souls)
  (:objects
    firelink courtyard tower key-room locked-passage boss-chamber - location
    iron-golem - boss
    dummy-minor-enemy - minor-enemy
    tower-key - key
  )
  (:init
    ;; Map with locked section
    (connected firelink courtyard)
    (connected courtyard firelink)
    (connected courtyard tower)
    (connected tower courtyard)
    (connected tower key-room)
    (connected key-room tower)
    (connected courtyard locked-passage)
    (connected locked-passage courtyard)
    (connected locked-passage boss-chamber)
    (connected boss-chamber locked-passage)

    ;; Locked door
    (locked courtyard locked-passage)
    (locked locked-passage courtyard)

    ;; Key location and matching
    (key-at tower-key key-room)
    (matches tower-key courtyard locked-passage)
    (matches tower-key locked-passage courtyard)

    ;; Locations
    (is-firelink firelink)
    (has-bonfire firelink)

    ;; Boss
    (enemy-at iron-golem boss-chamber)
    (is-alive iron-golem)
    (has-active-boss boss-chamber)

    ;; Player stats
    (= (player-health) 140)
    (= (player-max-health) 140)
    (= (player-damage) 30)
    (= (player-souls) 0)
    (= (estus-charges) 5)
    (= (estus-max) 5)
    (= (estus-heal-amount) 50)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Boss stats
    (= (enemy-health iron-golem) 200)
    (= (enemy-max-health iron-golem) 200)
    (= (enemy-damage iron-golem) 32)
    (= (enemy-soul-value iron-golem) 700)
    (= (boss-required-weapon-level iron-golem) 0)
  )
  (:goal (and
    (deposited-soul iron-golem)
  ))
  (:metric minimize (total-cost))
)

;; =================================================================
;; PROBLEM 3: Weapon Upgrade Required
;; Difficulty: Easy-Medium
;; Concepts: Exploration, item collection, weapon upgrade mechanics
;; Challenge: Must find titanite and upgrade weapon before boss
;; =================================================================

(define (problem darksouls-p03-upgrade)
  (:domain dark-souls)
  (:objects
    firelink undead-parish blacksmith-area titanite-room boss-arena - location
    capra-demon - boss
    dummy-minor-enemy - minor-enemy
    dummy-key - key
  )
  (:init
    ;; Map with branching paths
    (connected firelink undead-parish)
    (connected undead-parish firelink)
    (connected undead-parish blacksmith-area)
    (connected blacksmith-area undead-parish)
    (connected undead-parish titanite-room)
    (connected titanite-room undead-parish)
    (connected titanite-room boss-arena)
    (connected boss-arena titanite-room)

    ;; Locations
    (is-firelink firelink)
    (has-bonfire firelink)
    (is-blacksmith blacksmith-area)

    ;; Titanite for upgrade
    (titanite-at titanite-room)

    ;; Boss requiring upgraded weapon
    (enemy-at capra-demon boss-arena)
    (is-alive capra-demon)
    (has-active-boss boss-arena)

    ;; Player stats
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 20)
    (= (player-souls) 0)
    (= (estus-charges) 4)
    (= (estus-max) 4)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Boss stats - requires weapon level 1
    (= (enemy-health capra-demon) 180)
    (= (enemy-max-health capra-demon) 180)
    (= (enemy-damage capra-demon) 28)
    (= (enemy-soul-value capra-demon) 600)
    (= (boss-required-weapon-level capra-demon) 1)
  )
  (:goal (and
    (deposited-soul capra-demon)
  ))
  (:metric minimize (total-cost))
)

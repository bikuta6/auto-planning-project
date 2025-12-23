;; =================================================================
;; PROBLEM 6: Minor Enemies
;; Difficulty: Medium
;; Concepts: Fighting minor enemies, resource drain before boss
;; Challenge: Clear enemies blocking path, manage resources
;; =================================================================

(define (problem darksouls-p06-minors)
  (:domain dark-souls)
  (:objects
    firelink entrance hallway boss-gate boss-room - location
    ornstein-smough - boss
    hollow-soldier hollow-knight - minor-enemy
    dummy-key - key
  )
  (:init
    ;; Linear path with enemies
    (connected firelink entrance)
    (connected entrance firelink)
    (connected entrance hallway)
    (connected hallway entrance)
    (connected hallway boss-gate)
    (connected boss-gate hallway)
    (connected boss-gate boss-room)
    (connected boss-room boss-gate)

    ;; Locations
    (is-firelink firelink)
    (has-bonfire firelink)

    ;; Minor enemies blocking path
    (enemy-at hollow-soldier entrance)
    (is-alive hollow-soldier)
    
    (enemy-at hollow-knight hallway)
    (is-alive hollow-knight)

    ;; Boss
    (enemy-at ornstein-smough boss-room)
    (is-alive ornstein-smough)
    (has-active-boss boss-room)

    ;; Player stats
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 25)
    (= (player-souls) 0)
    (= (estus-charges) 4)
    (= (estus-max) 4)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Minor enemy 1 stats
    (= (enemy-health hollow-soldier) 50)
    (= (enemy-max-health hollow-soldier) 50)
    (= (enemy-damage hollow-soldier) 15)
    (= (enemy-soul-value hollow-soldier) 100)

    ;; Minor enemy 2 stats
    (= (enemy-health hollow-knight) 80)
    (= (enemy-max-health hollow-knight) 80)
    (= (enemy-damage hollow-knight) 20)
    (= (enemy-soul-value hollow-knight) 150)

    ;; Boss stats
    (= (enemy-health ornstein-smough) 200)
    (= (enemy-max-health ornstein-smough) 200)
    (= (enemy-damage ornstein-smough) 28)
    (= (enemy-soul-value ornstein-smough) 800)
    (= (boss-required-weapon-level ornstein-smough) 0)
  )
  (:goal (and
    (deposited-soul ornstein-smough)
  ))
  (:metric minimize (total-cost))
)

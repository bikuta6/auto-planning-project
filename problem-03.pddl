(define (problem p03)
  (:domain dark-souls)
  (:objects
    firelink parish bell-tower - location
    key-bell - key
    bell-tower-guard - minor-enemy 
    dummmy-boss - boss
  )
  (:init
    ;; map and lock
    (connected firelink parish)
    (connected parish firelink)
    (connected parish bell-tower)
    (locked parish bell-tower)
    (locked bell-tower parish)
    (key-at key-bell firelink)
    (matches key-bell parish bell-tower)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire parish)
    (is-blacksmith firelink)

    ;; enemy
    (enemy-at bell-tower-guard bell-tower)
    (is-alive bell-tower-guard)

    ;; player
    (= (player-health) 110)
    (= (player-max-health) 110)
    (= (player-damage) 14)
    (= (player-souls) 0)
    (= (estus-charges) 2)
    (= (estus-max) 3)
    (= (estus-heal-amount) 35)
    (= (level-up-cost) 120)
    (= (player-weapon-level) 0)
    (at-player firelink)
    (= (total-cost) 0)

    ;; enemy stats
    (= (enemy-health bell-tower-guard) 50)
    (= (enemy-max-health bell-tower-guard) 50)
    (= (enemy-damage bell-tower-guard) 8)
    (= (enemy-soul-value bell-tower-guard) 60)
  )
  (:goal (and
    (not (locked parish bell-tower))
  ))
  (:metric minimize (total-cost))
)

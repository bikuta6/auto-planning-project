(define (problem p09)
  (:domain dark-souls)
  (:objects
    firelink ruins smith-hut valley - location
    titanite1 titanite2 - key
    miniboss - boss
    dummy-minor-enemy - minor-enemy
  )
  (:init
    ;; map
    (connected firelink ruins)
    (connected ruins firelink)
    (connected ruins smith-hut)
    (connected smith-hut ruins)
    (connected smith-hut valley)
    (connected valley smith-hut)

    ;; titanite locations
    (titanite-at ruins)
    (titanite-at smith-hut)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire smith-hut)
    (is-blacksmith smith-hut)

    ;; enemy
    (enemy-at miniboss valley)
    (is-alive miniboss)
    (has-active-boss valley)

    ;; player
    (= (player-health) 130)
    (= (player-max-health) 130)
    (= (player-damage) 14)
    (= (player-souls) 350)
    (= (estus-charges) 2)
    (= (estus-max) 3)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 200)
    (= (player-weapon-level) 0)
    (at-player firelink)
    (= (total-cost) 0)

    ;; enemy stats
    (= (enemy-health miniboss) 200)
    (= (enemy-max-health miniboss) 200)
    (= (enemy-damage miniboss) 22)
    (= (enemy-soul-value miniboss) 500)
    (= (boss-required-weapon-level miniboss) 2)
  )
  (:goal (and
    (not (is-alive miniboss))
    (deposited-soul miniboss)
  ))
  (:metric minimize (total-cost))
)

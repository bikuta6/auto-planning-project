(define (problem p04)
  (:domain dark-souls)
  (:objects
    firelink depths sewer-entrance depths-boss-arena - location
    titanite1 - key
    titanite-node - location
    mini-boss - boss
    dummy-minor-enemy - minor-enemy
  )
  (:init
    ;; map
    (connected firelink sewer-entrance)
    (connected sewer-entrance firelink)
    (connected sewer-entrance depths)
    (connected depths sewer-entrance)
    (connected depths depths-boss-arena)
    (connected depths-boss-arena depths)

    ;; titanite placed in sewer entrance
    (titanite-at sewer-entrance)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire depths)
    (is-blacksmith firelink)

    ;; enemies
    (enemy-at mini-boss depths-boss-arena)
    (is-alive mini-boss)
    (has-active-boss depths-boss-arena)

    ;; player
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 12)
    (= (player-souls) 200)
    (= (estus-charges) 2)
    (= (estus-max) 3)
    (= (estus-heal-amount) 35)
    (= (level-up-cost) 150)
    (= (player-weapon-level) 0)
    (at-player firelink)
    (= (total-cost) 0)

    ;; enemy stats
    (= (enemy-health mini-boss) 160)
    (= (enemy-max-health mini-boss) 160)
    (= (enemy-damage mini-boss) 16)
    (= (enemy-soul-value mini-boss) 300)
    (= (boss-required-weapon-level mini-boss) 1)
  )
  (:goal (and
    (deposited-soul mini-boss)
  ))
  (:metric minimize (total-cost))
)

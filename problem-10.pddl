(define (problem p10)
  (:domain dark-souls)
  (:objects
    firelink long-road mid-camp boss-lair - location
    mob1 mob2 mob3 - minor-enemy
    lair-boss - boss
    dummmy-key - key
  )
  (:init
    ;; map
    (connected firelink long-road)
    (connected long-road firelink)
    (connected long-road mid-camp)
    (connected mid-camp long-road)
    (connected mid-camp boss-lair)
    (connected boss-lair mid-camp)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire mid-camp)
    (is-blacksmith firelink)

    ;; enemies
    (enemy-at mob1 long-road)
    (enemy-at mob2 mid-camp)
    (enemy-at mob3 mid-camp)
    (enemy-at lair-boss boss-lair)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)
    (is-alive lair-boss)
    (has-active-boss boss-lair)

    ;; player
    (= (player-health) 110)
    (= (player-max-health) 130)
    (= (player-damage) 13)
    (= (player-souls) 200)
    (= (estus-charges) 1)
    (= (estus-max) 2)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 150)
    (= (player-weapon-level) 1)
    (at-player firelink)
    (= (total-cost) 0)

    ;; stats
    (= (enemy-health mob1) 30)
    (= (enemy-max-health mob1) 30)
    (= (enemy-damage mob1) 6)
    (= (enemy-soul-value mob1) 20)

    (= (enemy-health mob2) 40)
    (= (enemy-max-health mob2) 40)
    (= (enemy-damage mob2) 8)
    (= (enemy-soul-value mob2) 30)

    (= (enemy-health mob3) 45)
    (= (enemy-max-health mob3) 45)
    (= (enemy-damage mob3) 9)
    (= (enemy-soul-value mob3) 35)

    (= (enemy-health lair-boss) 240)
    (= (enemy-max-health lair-boss) 240)
    (= (enemy-damage lair-boss) 26)
    (= (enemy-soul-value lair-boss) 800)
    (= (boss-required-weapon-level lair-boss) 1)
  )
  (:goal (and
    (not (is-alive lair-boss))
    (deposited-soul lair-boss)
  ))
  (:metric minimize (total-cost))
)

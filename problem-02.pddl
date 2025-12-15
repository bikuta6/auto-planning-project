(define (problem p02)
  (:domain dark-souls)
  (:objects
    firelink burg-square gargoyle-rooftop - location
    gargoyle1 gargoyle2 - boss
    mob1 mob2 - minor-enemy
    dummy-key - key
  )
  (:init
    ;; map
    (connected firelink burg-square)
    (connected burg-square firelink)
    (connected burg-square gargoyle-rooftop)
    (connected gargoyle-rooftop burg-square)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire burg-square)
    (is-blacksmith firelink)

    ;; enemies
    (enemy-at mob1 burg-square)
    (enemy-at mob2 burg-square)
    (enemy-at gargoyle1 gargoyle-rooftop)
    (enemy-at gargoyle2 gargoyle-rooftop)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive gargoyle1)
    (is-alive gargoyle2)
    (has-active-boss gargoyle-rooftop)

    ;; functions / player
    (= (player-health) 110)
    (= (player-max-health) 110)
    (= (player-damage) 12)
    (= (player-souls) 0)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 35)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (at-player firelink)
    (= (total-cost) 0)

    ;; mob stats
    (= (enemy-health mob1) 30)
    (= (enemy-max-health mob1) 30)
    (= (enemy-damage mob1) 5)
    (= (enemy-soul-value mob1) 20)

    (= (enemy-health mob2) 35)
    (= (enemy-max-health mob2) 35)
    (= (enemy-damage mob2) 6)
    (= (enemy-soul-value mob2) 25)

    ;; gargoyle1 (treat as boss-level for challenge)
    (= (enemy-health gargoyle1) 120)
    (= (enemy-max-health gargoyle1) 120)
    (= (enemy-damage gargoyle1) 15)
    (= (enemy-soul-value gargoyle1) 400)
    (= (boss-required-weapon-level gargoyle1) 0)

    ;; gargoyle2 (treat as boss-level for challenge)
    (= (enemy-health gargoyle2) 130)
    (= (enemy-max-health gargoyle2) 130)
    (= (enemy-damage gargoyle2) 16)
    (= (enemy-soul-value gargoyle2) 450)
    (= (boss-required-weapon-level gargoyle2) 0)

  )
  (:goal (and
    (deposited-soul gargoyle1)
    (deposited-soul gargoyle2)
  ))
  (:metric minimize (total-cost))
)

(define (problem p05)
  (:domain dark-souls)
  (:objects
    firelink swamp-entrance blighttown quelaag-arena - location
    mob1 mob2 mob3 - minor-enemy
    quelaag - boss
    dummy-key - key
  )
  (:init
    ;; map
    (connected firelink swamp-entrance)
    (connected swamp-entrance firelink)
    (connected swamp-entrance blighttown)
    (connected blighttown swamp-entrance)
    (connected blighttown quelaag-arena)
    (connected quelaag-arena blighttown)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire blighttown)
    (is-blacksmith firelink)

    ;; enemies
    (enemy-at mob1 swamp-entrance)
    (enemy-at mob2 swamp-entrance)
    (enemy-at mob3 blighttown)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)

    (enemy-at quelaag quelaag-arena)
    (is-alive quelaag)
    (has-active-boss quelaag-arena)

    ;; player: low estus
    (= (player-health) 100)
    (= (player-max-health) 120)
    (= (player-damage) 13)
    (= (player-souls) 100)
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
    (= (enemy-health mob2) 30)
    (= (enemy-max-health mob2) 30)
    (= (enemy-health mob3) 45)
    (= (enemy-max-health mob3) 45)
    (= (enemy-damage mob1) 6)
    (= (enemy-damage mob2) 6)
    (= (enemy-damage mob3) 8)
    (= (enemy-soul-value mob1) 20)
    (= (enemy-soul-value mob2) 20)
    (= (enemy-soul-value mob3) 30)

    (= (enemy-health quelaag) 220)
    (= (enemy-max-health quelaag) 220)
    (= (enemy-damage quelaag) 24)
    (= (enemy-soul-value quelaag) 700)
    (= (boss-required-weapon-level quelaag) 1)
  )
  (:goal (and
    (not (is-alive quelaag))
    (deposited-soul quelaag)
  ))
  (:metric minimize (total-cost))
)

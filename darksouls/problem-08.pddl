(define (problem p08)
  (:domain dark-souls)
  (:objects
    firelink valley gatehouse inner-valley - location
    key-valley key-gate - key
    mob1 mob2 mob3 - minor-enemy
    dummy-boss - boss
  )
  (:init
    ;; map
    (connected firelink valley)
    (connected valley firelink)
    (connected valley gatehouse)
    (connected gatehouse valley)
    (connected gatehouse inner-valley)
    (connected inner-valley gatehouse)
    (locked gatehouse inner-valley)
    (locked inner-valley gatehouse)
    (key-at key-valley valley)
    (matches key-valley gatehouse inner-valley)
    (can-open-shortcut firelink valley)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire gatehouse)
    (is-blacksmith firelink)

    ;; enemies
    (enemy-at mob1 valley)
    (enemy-at mob2 gatehouse)
    (enemy-at mob3 inner-valley)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)

    ;; player
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 14)
    (= (player-souls) 80)
    (= (estus-charges) 2)
    (= (estus-max) 2)
    (= (estus-heal-amount) 35)
    (= (level-up-cost) 140)
    (= (player-weapon-level) 1)
    (at-player firelink)
    (= (total-cost) 0)

    ;; stats
    (= (enemy-health mob1) 40)
    (= (enemy-max-health mob1) 40)
    (= (enemy-health mob2) 45)
    (= (enemy-max-health mob2) 45)
    (= (enemy-health mob3) 60)
    (= (enemy-max-health mob3) 60)
    (= (enemy-damage mob1) 6)
    (= (enemy-damage mob2) 8)
    (= (enemy-damage mob3) 10)
    (= (enemy-soul-value mob1) 25)
    (= (enemy-soul-value mob2) 30)
    (= (enemy-soul-value mob3) 60)
  )
  (:goal (and
    (not (locked gatehouse inner-valley))
    (at-player inner-valley)
  ))
  (:metric minimize (total-cost))
)

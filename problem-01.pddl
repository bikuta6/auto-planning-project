(define (problem p01)
  (:domain dark-souls)
  (:objects
    firelink undead-burg taurus-arena - location
    taurus - boss
    dummy-minor-enemy - minor-enemy
    dummy-key - key
  )
  (:init
    ;; map
    (connected firelink undead-burg)
    (connected undead-burg firelink)
    (connected undead-burg taurus-arena)
    (connected taurus-arena undead-burg)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire undead-burg)
    (is-blacksmith firelink)

    ;; boss
    (enemy-at taurus taurus-arena)
    (is-alive taurus)
    (has-active-boss taurus-arena)

    ;; functions / player
    (= (player-health) 120)
    (= (player-max-health) 120)
    (= (player-damage) 15)
    (= (player-souls) 0)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; enemy stats
    (= (enemy-health taurus) 180)
    (= (enemy-max-health taurus) 180)
    (= (enemy-damage taurus) 18)
    (= (enemy-soul-value taurus) 500)
    (= (boss-required-weapon-level taurus) 0)
  )
  (:goal (and
    (deposited-soul taurus)
  ))
  (:metric minimize (total-cost))
)

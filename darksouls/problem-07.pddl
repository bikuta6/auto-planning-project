(define (problem p07)
  (:domain dark-souls)
  (:objects
    firelink anor-entrance anor-hall ornstein-smough-approach - location
    minib1 minib2 minib3 - minor-enemy
    ornstein smough - boss
    dummy-key - key
  )
  (:init
    ;; map
    (connected firelink anor-entrance)
    (connected anor-entrance firelink)
    (connected anor-entrance anor-hall)
    (connected anor-hall anor-entrance)
    (connected anor-hall ornstein-smough-approach)
    (connected ornstein-smough-approach anor-hall)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire anor-hall)
    (is-blacksmith firelink)

    ;; enemies
    (enemy-at minib1 anor-entrance)
    (enemy-at minib2 anor-hall)
    (enemy-at minib3 anor-hall)
    (enemy-at ornstein ornstein-smough-approach)
    (enemy-at smough ornstein-smough-approach)
    (is-alive minib1)
    (is-alive minib2)
    (is-alive minib3)
    (is-alive ornstein)
    (is-alive smough)
    (has-active-boss ornstein-smough-approach)

    ;; player
    (= (player-health) 150)
    (= (player-max-health) 150)
    (= (player-damage) 18)
    (= (player-souls) 500)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 45)
    (= (level-up-cost) 250)
    (= (player-weapon-level) 2)
    (at-player firelink)
    (= (total-cost) 0)

    ;; stats
    (= (enemy-health minib1) 50)
    (= (enemy-max-health minib1) 50)
    (= (enemy-damage minib1) 8)
    (= (enemy-soul-value minib1) 40)

    (= (enemy-health minib2) 60)
    (= (enemy-max-health minib2) 60)
    (= (enemy-damage minib2) 10)
    (= (enemy-soul-value minib2) 50)

    (= (enemy-health minib3) 55)
    (= (enemy-max-health minib3) 55)
    (= (enemy-damage minib3) 9)
    (= (enemy-soul-value minib3) 45)

    (= (enemy-health ornstein) 280)
    (= (enemy-max-health ornstein) 280)
    (= (enemy-damage ornstein) 32)
    (= (enemy-soul-value ornstein) 1200)
    (= (boss-required-weapon-level ornstein) 2)

    (= (enemy-health smough) 300)
    (= (enemy-max-health smough) 300)
    (= (enemy-damage smough) 34)
    (= (enemy-soul-value smough) 1500)
    (= (boss-required-weapon-level smough) 2)
  )
  (:goal (and
    (not (is-alive ornstein))
    (not (is-alive smough))
    (deposited-soul ornstein)
    (deposited-soul smough)
  ))
  (:metric minimize (total-cost))
)

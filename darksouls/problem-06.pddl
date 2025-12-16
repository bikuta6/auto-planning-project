(define (problem p06)
  (:domain dark-souls)
  (:objects
    firelink sen-entrance sen-inner anor-entrance - location
    shortcut-key - key
    sen-guard1 sen-guard2 - minor-enemy
    iron-golem - boss
  )
  (:init
    ;; map and locked path
    (connected firelink sen-entrance)
    (connected sen-entrance firelink)
    (connected sen-entrance sen-inner)
    (connected sen-inner sen-entrance)
    (connected sen-inner anor-entrance)
    (connected anor-entrance sen-inner)
    (locked sen-inner anor-entrance)
    (locked anor-entrance sen-inner)
    (key-at shortcut-key sen-entrance)
    (matches shortcut-key sen-inner anor-entrance)
    (can-open-shortcut sen-entrance sen-inner)

    ;; titanite for weapon upgrades
    (titanite-at sen-entrance)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire sen-entrance)
    (is-blacksmith firelink)

    ;; enemies
    (enemy-at sen-guard1 sen-entrance)
    (enemy-at sen-guard2 sen-inner)
    (enemy-at iron-golem anor-entrance)
    (is-alive sen-guard1)
    (is-alive sen-guard2)
    (is-alive iron-golem)
    (has-active-boss anor-entrance)

    ;; player
    (= (player-health) 130)
    (= (player-max-health) 130)
    (= (player-damage) 16)
    (= (player-souls) 300)
    (= (estus-charges) 2)
    (= (estus-max) 3)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 200)
    (= (player-weapon-level) 1)
    (at-player firelink)
    (= (total-cost) 0)

    ;; stats
    (= (enemy-health sen-guard1) 40)
    (= (enemy-max-health sen-guard1) 40)
    (= (enemy-damage sen-guard1) 7)
    (= (enemy-soul-value sen-guard1) 30)

    (= (enemy-health sen-guard2) 50)
    (= (enemy-max-health sen-guard2) 50)
    (= (enemy-damage sen-guard2) 9)
    (= (enemy-soul-value sen-guard2) 50)

    (= (enemy-health iron-golem) 260)
    (= (enemy-max-health iron-golem) 260)
    (= (enemy-damage iron-golem) 28)
    (= (enemy-soul-value iron-golem) 1000)
    (= (boss-required-weapon-level iron-golem) 2)
  )
  (:goal (and
    (not (is-alive iron-golem))
    (deposited-soul iron-golem)
  ))
  (:metric minimize (total-cost))
)

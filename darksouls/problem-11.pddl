(define (problem p11-forced-levelup)
  (:domain dark-souls)
  (:objects
    firelink undead-burg lower-burg boss-arena - location
    gate-key - key
    hollow1 hollow2 - minor-enemy
    taurus-demon - boss
  )
  (:init
    ;; map connections
    (connected firelink undead-burg)
    (connected undead-burg firelink)
    (connected undead-burg lower-burg)
    (connected lower-burg undead-burg)
    (connected lower-burg boss-arena)
    (connected boss-arena lower-burg)
    (locked lower-burg boss-arena)
    (locked boss-arena lower-burg)
    (key-at gate-key undead-burg)
    (matches gate-key lower-burg boss-arena)

    ;; titanite for weapon upgrades
    (titanite-at undead-burg)

    ;; landmarks
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire undead-burg)
    (is-blacksmith firelink)

    ;; enemies - strategically placed to force combat
    (enemy-at hollow1 undead-burg)
    (enemy-at hollow2 lower-burg)
    (enemy-at taurus-demon boss-arena)
    (is-alive hollow1)
    (is-alive hollow2)
    (is-alive taurus-demon)
    (has-active-boss boss-arena)

    ;; player stats - LOW initial health to force level-up
    (= (player-health) 100)
    (= (player-max-health) 100)
    (= (player-damage) 15)
    (= (player-souls) 250)  ;; Just enough for one level-up
    (= (estus-charges) 2)
    (= (estus-max) 2)
    (= (estus-heal-amount) 35)
    (= (level-up-cost) 200)
    (= (player-weapon-level) 0)
    (at-player firelink)
    (= (total-cost) 0)

    ;; enemy stats - hollow1: moderate threat
    (= (enemy-health hollow1) 45)
    (= (enemy-max-health hollow1) 45)
    (= (enemy-damage hollow1) 18)  ;; High damage
    (= (enemy-soul-value hollow1) 40)

    ;; enemy stats - hollow2: another moderate threat
    (= (enemy-health hollow2) 50)
    (= (enemy-max-health hollow2) 50)
    (= (enemy-damage hollow2) 20)  ;; High damage
    (= (enemy-soul-value hollow2) 50)

    ;; boss stats - requires multiple hits, deals heavy damage
    ;; Player needs ~160 HP to survive the fight (multiple attacks needed)
    ;; With 100 HP base, player MUST level up to get 130 HP minimum
    (= (enemy-health taurus-demon) 180)
    (= (enemy-max-health taurus-demon) 180)
    (= (enemy-damage taurus-demon) 30)  ;; Devastating damage
    (= (enemy-soul-value taurus-demon) 800)
    (= (boss-required-weapon-level taurus-demon) 1)  ;; Requires weapon upgrade too
  )
  (:goal (and
    (not (is-alive taurus-demon))
    (deposited-soul taurus-demon)
  ))
  (:metric minimize (total-cost))
)

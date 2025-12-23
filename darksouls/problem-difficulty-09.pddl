;; =================================================================
;; PROBLEM 9: Stat Leveling Required
;; Difficulty: Hard
;; Concepts: Soul farming, stat leveling, strategic upgrades
;; Challenge: Must level up stats to survive boss, requires farming
;; =================================================================

(define (problem darksouls-p09-leveling)
  (:domain dark-souls)
  (:objects
    firelink forest-entrance forest-depths farming-area titanite-cave 
    blacksmith-shop boss-lair - location
    nito-gravelord - boss
    forest-guardian-1 forest-guardian-2 forest-guardian-3 - minor-enemy
    dummy-key - key
  )
  (:init
    ;; Map layout
    (connected firelink forest-entrance)
    (connected forest-entrance firelink)
    (connected forest-entrance forest-depths)
    (connected forest-depths forest-entrance)
    (connected forest-depths farming-area)
    (connected farming-area forest-depths)
    (connected farming-area titanite-cave)
    (connected titanite-cave farming-area)
    (connected firelink blacksmith-shop)
    (connected blacksmith-shop firelink)
    (connected titanite-cave boss-lair)
    (connected boss-lair titanite-cave)

    ;; Locations
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire farming-area)
    (is-blacksmith blacksmith-shop)

    ;; Titanite for upgrade
    (titanite-at titanite-cave)

    ;; Minor enemies for soul farming
    (enemy-at forest-guardian-1 forest-entrance)
    (is-alive forest-guardian-1)
    
    (enemy-at forest-guardian-2 forest-depths)
    (is-alive forest-guardian-2)
    
    (enemy-at forest-guardian-3 farming-area)
    (is-alive forest-guardian-3)

    ;; Boss requiring both levels and upgrade
    (enemy-at nito-gravelord boss-lair)
    (is-alive nito-gravelord)
    (has-active-boss boss-lair)

    ;; Player stats - WEAK, needs leveling
    (= (player-health) 100)
    (= (player-max-health) 100)
    (= (player-damage) 20)
    (= (player-souls) 0)
    (= (estus-charges) 4)
    (= (estus-max) 4)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 150)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Forest guardian 1 - good soul value
    (= (enemy-health forest-guardian-1) 70)
    (= (enemy-max-health forest-guardian-1) 70)
    (= (enemy-damage forest-guardian-1) 20)
    (= (enemy-soul-value forest-guardian-1) 180)

    ;; Forest guardian 2
    (= (enemy-health forest-guardian-2) 75)
    (= (enemy-max-health forest-guardian-2) 75)
    (= (enemy-damage forest-guardian-2) 22)
    (= (enemy-soul-value forest-guardian-2) 200)

    ;; Forest guardian 3
    (= (enemy-health forest-guardian-3) 80)
    (= (enemy-max-health forest-guardian-3) 80)
    (= (enemy-damage forest-guardian-3) 24)
    (= (enemy-soul-value forest-guardian-3) 220)

    ;; Boss stats - very tough, requires preparation
    (= (enemy-health nito-gravelord) 240)
    (= (enemy-max-health nito-gravelord) 240)
    (= (enemy-damage nito-gravelord) 35)
    (= (enemy-soul-value nito-gravelord) 1500)
    (= (boss-required-weapon-level nito-gravelord) 1)
  )
  (:goal (and
    (deposited-soul nito-gravelord)
  ))
  (:metric minimize (total-cost))
)

;; =================================================================
;; PROBLEM 8: Shortcuts and Optimization
;; Difficulty: Medium-Hard
;; Concepts: Opening shortcuts, optimal path planning
;; Challenge: Find and open shortcut for efficient routing
;; =================================================================

(define (problem darksouls-p08-shortcuts)
  (:domain dark-souls)
  (:objects
    firelink long-path-1 long-path-2 long-path-3 shortcut-start 
    shortcut-end boss-area - location
    four-kings - boss
    darkwraith-1 darkwraith-2 - minor-enemy
    dummy-key - key
  )
  (:init
    ;; Long winding path
    (connected firelink long-path-1)
    (connected long-path-1 firelink)
    (connected long-path-1 long-path-2)
    (connected long-path-2 long-path-1)
    (connected long-path-2 long-path-3)
    (connected long-path-3 long-path-2)
    (connected long-path-3 shortcut-end)
    (connected shortcut-end long-path-3)
    (connected shortcut-end boss-area)
    (connected boss-area shortcut-end)

    ;; Shortcut from firelink (not connected initially)
    (connected firelink shortcut-start)
    (connected shortcut-start firelink)
    (can-open-shortcut shortcut-start shortcut-end)

    ;; Locations
    (is-firelink firelink)
    (has-bonfire firelink)

    ;; Enemies on long path
    (enemy-at darkwraith-1 long-path-2)
    (is-alive darkwraith-1)
    
    (enemy-at darkwraith-2 long-path-3)
    (is-alive darkwraith-2)

    ;; Boss
    (enemy-at four-kings boss-area)
    (is-alive four-kings)
    (has-active-boss boss-area)

    ;; Player stats
    (= (player-health) 130)
    (= (player-max-health) 130)
    (= (player-damage) 28)
    (= (player-souls) 0)
    (= (estus-charges) 4)
    (= (estus-max) 4)
    (= (estus-heal-amount) 45)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Darkwraith 1
    (= (enemy-health darkwraith-1) 90)
    (= (enemy-max-health darkwraith-1) 90)
    (= (enemy-damage darkwraith-1) 26)
    (= (enemy-soul-value darkwraith-1) 200)

    ;; Darkwraith 2
    (= (enemy-health darkwraith-2) 95)
    (= (enemy-max-health darkwraith-2) 95)
    (= (enemy-damage darkwraith-2) 28)
    (= (enemy-soul-value darkwraith-2) 220)

    ;; Boss stats
    (= (enemy-health four-kings) 240)
    (= (enemy-max-health four-kings) 240)
    (= (enemy-damage four-kings) 30)
    (= (enemy-soul-value four-kings) 1200)
    (= (boss-required-weapon-level four-kings) 0)
  )
  (:goal (and
    (deposited-soul four-kings)
  ))
  (:metric minimize (total-cost))
)

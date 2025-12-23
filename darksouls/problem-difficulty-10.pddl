;; =================================================================
;; PROBLEM 10: Full Complexity
;; Difficulty: Hard
;; Concepts: All mechanics combined - keys, upgrades, multiple bosses,
;;           shortcuts, resource management, stat leveling
;; Challenge: Complex multi-stage adventure with all systems
;; =================================================================

(define (problem darksouls-p10-fullgame)
  (:domain dark-souls)
  (:objects
    firelink hub-area locked-wing key-tower blacksmith-district
    titanite-room shortcut-lever enemy-corridor safe-bonfire
    boss1-fog boss2-fog - location
    
    gwyn-lord quelaag-witch - boss
    silver-knight black-knight chaos-bug - minor-enemy
    master-key - key
  )
  (:init
    ;; Complex map
    (connected firelink hub-area)
    (connected hub-area firelink)
    (connected hub-area blacksmith-district)
    (connected blacksmith-district hub-area)
    (connected hub-area enemy-corridor)
    (connected enemy-corridor hub-area)
    (connected enemy-corridor safe-bonfire)
    (connected safe-bonfire enemy-corridor)
    (connected safe-bonfire boss1-fog)
    (connected boss1-fog safe-bonfire)
    
    ;; Locked section
    (connected hub-area locked-wing)
    (connected locked-wing hub-area)
    (connected locked-wing key-tower)
    (connected key-tower locked-wing)
    
    ;; Locked doors
    (locked hub-area locked-wing)
    (locked locked-wing hub-area)
    
    ;; Path to second boss
    (connected key-tower titanite-room)
    (connected titanite-room key-tower)
    (connected titanite-room shortcut-lever)
    (connected shortcut-lever titanite-room)
    (connected shortcut-lever boss2-fog)
    (connected boss2-fog shortcut-lever)
    
    ;; Shortcut path
    (connected firelink shortcut-lever)
    (connected shortcut-lever firelink)
    (can-open-shortcut shortcut-lever firelink)

    ;; Key location
    (key-at master-key key-tower)
    (matches master-key hub-area locked-wing)
    (matches master-key locked-wing hub-area)

    ;; Titanite location
    (titanite-at titanite-room)

    ;; Locations
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire safe-bonfire)
    (is-blacksmith blacksmith-district)

    ;; Minor enemies
    (enemy-at silver-knight enemy-corridor)
    (is-alive silver-knight)
    
    (enemy-at black-knight locked-wing)
    (is-alive black-knight)
    
    (enemy-at chaos-bug titanite-room)
    (is-alive chaos-bug)

    ;; Bosses
    (enemy-at quelaag-witch boss1-fog)
    (is-alive quelaag-witch)
    (has-active-boss boss1-fog)
    
    (enemy-at gwyn-lord boss2-fog)
    (is-alive gwyn-lord)
    (has-active-boss boss2-fog)

    ;; Player stats - moderate starting
    (= (player-health) 110)
    (= (player-max-health) 110)
    (= (player-damage) 22)
    (= (player-souls) 0)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 120)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Silver knight
    (= (enemy-health silver-knight) 85)
    (= (enemy-max-health silver-knight) 85)
    (= (enemy-damage silver-knight) 25)
    (= (enemy-soul-value silver-knight) 180)

    ;; Black knight
    (= (enemy-health black-knight) 110)
    (= (enemy-max-health black-knight) 110)
    (= (enemy-damage black-knight) 32)
    (= (enemy-soul-value black-knight) 250)

    ;; Chaos bug
    (= (enemy-health chaos-bug) 65)
    (= (enemy-max-health chaos-bug) 65)
    (= (enemy-damage chaos-bug) 20)
    (= (enemy-soul-value chaos-bug) 150)

    ;; Boss 1 - medium difficulty
    (= (enemy-health quelaag-witch) 200)
    (= (enemy-max-health quelaag-witch) 200)
    (= (enemy-damage quelaag-witch) 30)
    (= (enemy-soul-value quelaag-witch) 1000)
    (= (boss-required-weapon-level quelaag-witch) 0)

    ;; Boss 2 - requires upgrade and leveling
    (= (enemy-health gwyn-lord) 280)
    (= (enemy-max-health gwyn-lord) 280)
    (= (enemy-damage gwyn-lord) 38)
    (= (enemy-soul-value gwyn-lord) 2000)
    (= (boss-required-weapon-level gwyn-lord) 1)
  )
  (:goal (and
    (deposited-soul quelaag-witch)
    (deposited-soul gwyn-lord)
  ))
  (:metric minimize (total-cost))
)

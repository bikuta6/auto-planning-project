;; =================================================================
;; PROBLEM 11: Ultimate Challenge
;; Difficulty: Very Hard
;; Concepts: All mechanics with tight constraints, optimal planning required
;; Challenge: Three bosses, limited resources, strategic farming,
;;            multiple upgrades needed, complex routing
;; =================================================================

(define (problem darksouls-p11-challenge)
  (:domain dark-souls)
  (:objects
    firelink depths-entrance depths-lower depths-depths catacombs-entry
    catacombs-mid catacombs-deep titanite-vault-1 titanite-vault-2
    blacksmith-hidden farming-zone-1 farming-zone-2 shortcut-upper
    shortcut-lower boss-gate-1 boss-gate-2 boss-gate-3 key-chamber - location
    
    manus-abyss artorias-knight kalameet-dragon - boss
    
    skeleton-warrior-1 skeleton-warrior-2 necromancer 
    abyss-wraith torch-hollow - minor-enemy
    
    catacombs-key - key
  )
  (:init
    ;; Complex interconnected map
    (connected firelink depths-entrance)
    (connected depths-entrance firelink)
    (connected depths-entrance depths-lower)
    (connected depths-lower depths-entrance)
    (connected depths-lower depths-depths)
    (connected depths-depths depths-lower)
    (connected depths-depths blacksmith-hidden)
    (connected blacksmith-hidden depths-depths)
    (connected blacksmith-hidden titanite-vault-1)
    (connected titanite-vault-1 blacksmith-hidden)
    
    ;; Locked catacombs path
    (connected depths-depths catacombs-entry)
    (connected catacombs-entry depths-depths)
    (locked depths-depths catacombs-entry)
    (locked catacombs-entry depths-depths)
    
    (connected catacombs-entry catacombs-mid)
    (connected catacombs-mid catacombs-entry)
    (connected catacombs-mid catacombs-deep)
    (connected catacombs-deep catacombs-mid)
    (connected catacombs-deep key-chamber)
    (connected key-chamber catacombs-deep)
    (connected catacombs-deep titanite-vault-2)
    (connected titanite-vault-2 catacombs-deep)
    
    ;; Farming zones
    (connected depths-lower farming-zone-1)
    (connected farming-zone-1 depths-lower)
    (connected catacombs-mid farming-zone-2)
    (connected farming-zone-2 catacombs-mid)
    
    ;; Shortcut system
    (connected firelink shortcut-upper)
    (connected shortcut-upper firelink)
    (can-open-shortcut shortcut-upper shortcut-lower)
    (connected shortcut-lower catacombs-deep)
    (connected catacombs-deep shortcut-lower)
    
    ;; Boss areas
    (connected titanite-vault-1 boss-gate-1)
    (connected boss-gate-1 titanite-vault-1)
    (connected farming-zone-2 boss-gate-2)
    (connected boss-gate-2 farming-zone-2)
    (connected titanite-vault-2 boss-gate-3)
    (connected boss-gate-3 titanite-vault-2)

    ;; Key setup
    (key-at catacombs-key key-chamber)
    (matches catacombs-key depths-depths catacombs-entry)
    (matches catacombs-key catacombs-entry depths-depths)

    ;; Titanite locations
    (titanite-at titanite-vault-1)
    (titanite-at titanite-vault-2)

    ;; Special locations
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire farming-zone-1)
    (has-bonfire farming-zone-2)
    (is-blacksmith blacksmith-hidden)

    ;; Minor enemies - strategic placement
    (enemy-at skeleton-warrior-1 depths-entrance)
    (is-alive skeleton-warrior-1)
    
    (enemy-at skeleton-warrior-2 depths-lower)
    (is-alive skeleton-warrior-2)
    
    (enemy-at necromancer catacombs-mid)
    (is-alive necromancer)
    
    (enemy-at abyss-wraith farming-zone-1)
    (is-alive abyss-wraith)
    
    (enemy-at torch-hollow farming-zone-2)
    (is-alive torch-hollow)

    ;; Three challenging bosses
    (enemy-at artorias-knight boss-gate-1)
    (is-alive artorias-knight)
    (has-active-boss boss-gate-1)
    
    (enemy-at kalameet-dragon boss-gate-2)
    (is-alive kalameet-dragon)
    (has-active-boss boss-gate-2)
    
    (enemy-at manus-abyss boss-gate-3)
    (is-alive manus-abyss)
    (has-active-boss boss-gate-3)

    ;; Player stats - VERY WEAK initially
    (= (player-health) 100)
    (= (player-max-health) 100)
    (= (player-damage) 20)
    (= (player-souls) 0)
    (= (estus-charges) 3)
    (= (estus-max) 3)
    (= (estus-heal-amount) 40)
    (= (level-up-cost) 180)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)

    (at-player firelink)

    ;; Skeleton warrior 1
    (= (enemy-health skeleton-warrior-1) 60)
    (= (enemy-max-health skeleton-warrior-1) 60)
    (= (enemy-damage skeleton-warrior-1) 18)
    (= (enemy-soul-value skeleton-warrior-1) 150)

    ;; Skeleton warrior 2
    (= (enemy-health skeleton-warrior-2) 65)
    (= (enemy-max-health skeleton-warrior-2) 65)
    (= (enemy-damage skeleton-warrior-2) 20)
    (= (enemy-soul-value skeleton-warrior-2) 160)

    ;; Necromancer - tough miniboss
    (= (enemy-health necromancer) 100)
    (= (enemy-max-health necromancer) 100)
    (= (enemy-damage necromancer) 28)
    (= (enemy-soul-value necromancer) 300)

    ;; Abyss wraith - farmable
    (= (enemy-health abyss-wraith) 75)
    (= (enemy-max-health abyss-wraith) 75)
    (= (enemy-damage abyss-wraith) 22)
    (= (enemy-soul-value abyss-wraith) 200)

    ;; Torch hollow - farmable
    (= (enemy-health torch-hollow) 70)
    (= (enemy-max-health torch-hollow) 70)
    (= (enemy-damage torch-hollow) 20)
    (= (enemy-soul-value torch-hollow) 190)

    ;; Boss 1 - requires first upgrade
    (= (enemy-health artorias-knight) 240)
    (= (enemy-max-health artorias-knight) 240)
    (= (enemy-damage artorias-knight) 35)
    (= (enemy-soul-value artorias-knight) 1500)
    (= (boss-required-weapon-level artorias-knight) 1)

    ;; Boss 2 - requires second upgrade
    (= (enemy-health kalameet-dragon) 280)
    (= (enemy-max-health kalameet-dragon) 280)
    (= (enemy-damage kalameet-dragon) 38)
    (= (enemy-soul-value kalameet-dragon) 1800)
    (= (boss-required-weapon-level kalameet-dragon) 2)

    ;; Boss 3 - final challenge, requires second upgrade
    (= (enemy-health manus-abyss) 300)
    (= (enemy-max-health manus-abyss) 300)
    (= (enemy-damage manus-abyss) 40)
    (= (enemy-soul-value manus-abyss) 2500)
    (= (boss-required-weapon-level manus-abyss) 2)
  )
  (:goal (and
    (deposited-soul artorias-knight)
    (deposited-soul kalameet-dragon)
    (deposited-soul manus-abyss)
  ))
  (:metric minimize (total-cost))
)

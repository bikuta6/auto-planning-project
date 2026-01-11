;; ===================================================================
;; BENCHMARK PROBLEM 09: Multi-Boss Gauntlet
;; Difficulty: Hard
;; Focus: Three bosses requiring different strategies
;; ===================================================================
(define (problem bench-09)
  (:domain dark-souls)
  (:objects
    firelink forge east-wing west-wing north-tower - location
    sentinel1 sentinel2 - minor-enemy
    east-guardian west-champion north-tyrant - boss
  )
  (:init
    (connected firelink forge)
    (connected forge firelink)
    (connected firelink east-wing)
    (connected east-wing firelink)
    (connected firelink west-wing)
    (connected west-wing firelink)
    (connected firelink north-tower)
    (connected north-tower firelink)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    (is-blacksmith forge)
    
    (titanite-at forge)
    
    (enemy-at sentinel1 east-wing)
    (enemy-at sentinel2 west-wing)
    (is-alive sentinel1)
    (is-alive sentinel2)
    
    (enemy-at east-guardian east-wing)
    (enemy-at west-champion west-wing)
    (enemy-at north-tyrant north-tower)
    (is-alive east-guardian)
    (is-alive west-champion)
    (is-alive north-tyrant)
    (has-active-boss east-wing)
    (has-active-boss west-wing)
    (has-active-boss north-tower)
    
    (= (player-health) 130)
    (= (player-max-health) 130)
    (= (player-damage) 22)
    (= (player-souls) 0)
    (= (estus-charges) 4)
    (= (estus-max) 4)
    (= (estus-heal-amount) 45)
    (= (level-up-cost) 100)
    (= (player-weapon-level) 0)
    (= (total-cost) 0)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    (= (enemy-health sentinel1) 58)
    (= (enemy-max-health sentinel1) 58)
    (= (enemy-damage sentinel1) 18)
    (= (enemy-soul-value sentinel1) 72)
    
    (= (enemy-health sentinel2) 60)
    (= (enemy-max-health sentinel2) 60)
    (= (enemy-damage sentinel2) 19)
    (= (enemy-soul-value sentinel2) 75)
    
    (= (enemy-health east-guardian) 145)
    (= (enemy-max-health east-guardian) 145)
    (= (enemy-damage east-guardian) 27)
    (= (enemy-soul-value east-guardian) 880)
    (= (boss-required-weapon-level east-guardian) 0)
    
    (= (enemy-health west-champion) 150)
    (= (enemy-max-health west-champion) 150)
    (= (enemy-damage west-champion) 28)
    (= (enemy-soul-value west-champion) 920)
    (= (boss-required-weapon-level west-champion) 0)
    
    (= (enemy-health north-tyrant) 180)
    (= (enemy-max-health north-tyrant) 180)
    (= (enemy-damage north-tyrant) 34)
    (= (enemy-soul-value north-tyrant) 1100)
    (= (boss-required-weapon-level north-tyrant) 1) ;; Requires upgrade

    ;; Summon stats (shared default configuration)
    (summon-available)
    (= (summon-health) 0)
    (= (summon-max-health) 100)
    (= (summon-damage) 18)
    (= (summon-cost) 10)
  )
  (:goal (and
    (deposited-soul east-guardian)
    (deposited-soul west-champion)
    (deposited-soul north-tyrant)
  ))
  (:metric minimize (total-cost))
)

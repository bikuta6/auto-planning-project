;; =================================================================
;; FD PROBLEM 1: Tutorial - Basic Movement and Combat
;; Difficulty: Very Easy
;; Concepts: Movement, basic boss combat with sufficient health
;; Challenge: Defeat one weak boss, no special mechanics needed
;; =================================================================

(define (problem darksouls-fd-p01-tutorial)
  (:domain dark-souls-fd)
  (:objects
    firelink boss-room - location
    tutorial-boss - boss
    dummy-minor-enemy - minor-enemy
    dummy-key - key

    ;; Health levels (0-150)
    hp0 hp15 hp30 hp45 hp60 hp75 hp90 hp105 hp120 hp135 hp150 - hp-level
    
    ;; Weapon levels
    w0 w1 w2 - wlevel
    
    ;; Player levels
    plv1 plv2 plv3 - player-level
    
    ;; Boss phases (4 attacks to kill - 120hp / 30 damage)
    phase0 phase1 phase2 phase3 phase4 - boss-phase
    
    ;; Estus slots
    estus1 estus2 estus3 estus4 estus5 - estus-slot
    
    ;; Soul levels
    souls0 souls300 souls600 souls900 - soul-level
  )

  (:init
    ;; Map
    (connected firelink boss-room)
    (connected boss-room firelink)
    (is-firelink firelink)
    (has-bonfire firelink)
    
    ;; Boss
    (enemy-at tutorial-boss boss-room)
    (is-alive tutorial-boss)
    (has-active-boss boss-room)
    (boss-current-phase tutorial-boss phase4)
    (boss-max-phase tutorial-boss phase4)
    (boss-phase-zero phase0)
    (boss-phase-next phase4 phase3)
    (boss-phase-next phase3 phase2)
    (boss-phase-next phase2 phase1)
    (boss-phase-next phase1 phase0)
    
    ;; Player state
    (at-player firelink)
    (player-hp hp150)
    (player-max-hp hp150)
    (player-weapon-level w0)
    (player-current-level plv1)
    (player-souls souls0)
    (player-max-souls souls900)
    
    ;; HP progression chain
    (hp-next hp0 hp15) (hp-next hp15 hp30) (hp-next hp30 hp45)
    (hp-next hp45 hp60) (hp-next hp60 hp75) (hp-next hp75 hp90)
    (hp-next hp90 hp105) (hp-next hp105 hp120) (hp-next hp120 hp135)
    (hp-next hp135 hp150)
    
    ;; HP comparisons (for healing limits)
    (hp-leq hp0 hp0) (hp-leq hp0 hp15) (hp-leq hp0 hp30) (hp-leq hp0 hp45)
    (hp-leq hp0 hp60) (hp-leq hp0 hp75) (hp-leq hp0 hp90) (hp-leq hp0 hp105)
    (hp-leq hp0 hp120) (hp-leq hp0 hp135) (hp-leq hp0 hp150)
    (hp-leq hp15 hp15) (hp-leq hp15 hp30) (hp-leq hp15 hp45) (hp-leq hp15 hp60)
    (hp-leq hp15 hp75) (hp-leq hp15 hp90) (hp-leq hp15 hp105) (hp-leq hp15 hp120)
    (hp-leq hp15 hp135) (hp-leq hp15 hp150)
    (hp-leq hp30 hp30) (hp-leq hp30 hp45) (hp-leq hp30 hp60) (hp-leq hp30 hp75)
    (hp-leq hp30 hp90) (hp-leq hp30 hp105) (hp-leq hp30 hp120) (hp-leq hp30 hp135)
    (hp-leq hp30 hp150)
    (hp-leq hp45 hp45) (hp-leq hp45 hp60) (hp-leq hp45 hp75) (hp-leq hp45 hp90)
    (hp-leq hp45 hp105) (hp-leq hp45 hp120) (hp-leq hp45 hp135) (hp-leq hp45 hp150)
    (hp-leq hp60 hp60) (hp-leq hp60 hp75) (hp-leq hp60 hp90) (hp-leq hp60 hp105)
    (hp-leq hp60 hp120) (hp-leq hp60 hp135) (hp-leq hp60 hp150)
    (hp-leq hp75 hp75) (hp-leq hp75 hp90) (hp-leq hp75 hp105) (hp-leq hp75 hp120)
    (hp-leq hp75 hp135) (hp-leq hp75 hp150)
    (hp-leq hp90 hp90) (hp-leq hp90 hp105) (hp-leq hp90 hp120) (hp-leq hp90 hp135)
    (hp-leq hp90 hp150)
    (hp-leq hp105 hp105) (hp-leq hp105 hp120) (hp-leq hp105 hp135) (hp-leq hp105 hp150)
    (hp-leq hp120 hp120) (hp-leq hp120 hp135) (hp-leq hp120 hp150)
    (hp-leq hp135 hp135) (hp-leq hp135 hp150)
    (hp-leq hp150 hp150)
    
    (hp-zero hp0)
    
    ;; Boss damage: 15 per hit
    (hp-after-attack tutorial-boss hp150 hp135)
    (hp-after-attack tutorial-boss hp135 hp120)
    (hp-after-attack tutorial-boss hp120 hp105)
    (hp-after-attack tutorial-boss hp105 hp90)
    (hp-after-attack tutorial-boss hp90 hp75)
    (hp-after-attack tutorial-boss hp75 hp60)
    (hp-after-attack tutorial-boss hp60 hp45)
    (hp-after-attack tutorial-boss hp45 hp30)
    
    ;; Boss can be damaged by any weapon level
    (can-damage-boss tutorial-boss w0)
    (can-damage-boss tutorial-boss w1)
    (can-damage-boss tutorial-boss w2)
    
    ;; Weapon levels
    (wlevel-next w0 w1)
    (wlevel-next w1 w2)
    
    ;; Player levels
    (player-level-next plv1 plv2)
    (player-level-next plv2 plv3)
    
    ;; Estus slots - 5 available
    (estus-unlocked estus1)
    (estus-unlocked estus2)
    (estus-unlocked estus3)
    (estus-unlocked estus4)
    (estus-unlocked estus5)
    (estus-full estus1)
    (estus-full estus2)
    (estus-full estus3)
    (estus-full estus4)
    (estus-full estus5)
    
    ;; Soul progression
    (soul-next souls0 souls300)
    (soul-next souls300 souls600)
    (soul-next souls600 souls900)
    (soul-after-drop tutorial-boss souls0 souls300)
    (soul-after-drop tutorial-boss souls300 souls600)
    (soul-after-drop tutorial-boss souls600 souls900)
    
    ;; Level up costs
    (soul-spend-for-level plv1 plv2 souls300 souls0)
    (soul-spend-for-level plv2 plv3 souls600 souls0)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul tutorial-boss)
  ))
    (:metric minimize (total-cost))
)

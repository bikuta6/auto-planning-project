;; ===================================================================
;; BENCHMARK PROBLEM 01 - FD Version: Tutorial
;; Difficulty: Very Easy
;; Focus: Basic navigation and single boss fight
;; ===================================================================
(define (problem bench-01-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink boss-room - location
    tutorial-boss - boss
    
    hp0 hp1 hp2 hp3 hp4 hp5 - hp-level
    w0 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 bp3 - boss-phase
    e1 e2 e3 e4 e5 - estus-slot
    s0 s1 s2 s3 s4 s5 - soul-level
  )
  (:init
    (connected firelink boss-room)
    (connected boss-room firelink)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire boss-room)
    
    (enemy-at tutorial-boss boss-room)
    (is-alive tutorial-boss)
    (has-active-boss boss-room)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
    ;; HP ladder (0-5)
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5)
    (hp-zero hp0)
    (hp-leq hp0 hp0) (hp-leq hp0 hp1) (hp-leq hp0 hp2) (hp-leq hp0 hp3) (hp-leq hp0 hp4) (hp-leq hp0 hp5)
    (hp-leq hp1 hp1) (hp-leq hp1 hp2) (hp-leq hp1 hp3) (hp-leq hp1 hp4) (hp-leq hp1 hp5)
    (hp-leq hp2 hp2) (hp-leq hp2 hp3) (hp-leq hp2 hp4) (hp-leq hp2 hp5)
    (hp-leq hp3 hp3) (hp-leq hp3 hp4) (hp-leq hp3 hp5)
    (hp-leq hp4 hp4) (hp-leq hp4 hp5)
    (hp-leq hp5 hp5)
    
    (player-max-hp hp5)
    (player-hp hp5)
    (player-current-level pl0)
    (player-level-next pl0 pl1)
    (player-weapon-level w0)
    
    ;; Boss phases (3 hits to kill)
    (boss-phase-zero bp0)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase tutorial-boss bp3)
    (boss-current-phase tutorial-boss bp3)
    
    ;; Estus (5 charges, leave e5 locked for boss to unlock)
    (estus-unlocked e1) (estus-unlocked e2) (estus-unlocked e3) (estus-unlocked e4)
    (estus-full e1) (estus-full e2) (estus-full e3) (estus-full e4)
    
    ;; Souls ladder
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5)
    (player-max-souls s5)
    (player-souls s0)
    
    ;; Combat: boss does 1 HP damage per hit
    (hp-after-attack tutorial-boss hp5 hp4)
    (hp-after-attack tutorial-boss hp4 hp3)
    (hp-after-attack tutorial-boss hp3 hp2)
    (hp-after-attack tutorial-boss hp2 hp1)
    (hp-after-attack tutorial-boss hp1 hp0)
    
    ;; Soul gains (saturating)
    (soul-after-drop tutorial-boss s0 s3)
    (soul-after-drop tutorial-boss s1 s4)
    (soul-after-drop tutorial-boss s2 s5)
    (soul-after-drop tutorial-boss s3 s5)
    (soul-after-drop tutorial-boss s4 s5)
    (soul-after-drop tutorial-boss s5 s5)
    
    ;; Level up costs
    (soul-spend-for-level pl0 pl1 s2 s0)
    (soul-spend-for-level pl0 pl1 s3 s1)
    (soul-spend-for-level pl0 pl1 s4 s2)
    (soul-spend-for-level pl0 pl1 s5 s3)
    
    (can-damage-boss tutorial-boss w0)
    
    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul tutorial-boss)
  ))
  (:metric minimize (total-cost))
)

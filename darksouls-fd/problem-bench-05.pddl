;; ===================================================================
;; BENCHMARK PROBLEM 05 - FD Version: Weapon Upgrade Required
;; Difficulty: Medium
;; ===================================================================
(define (problem bench-05-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink forge mines boss-chamber - location
    miner - minor-enemy
    armored-boss - boss

    hp0 hp1 hp2 hp3 hp4 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 bp6 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 - soul-level
  )
  (:init
    ;; Map
    (connected firelink forge)
    (connected forge firelink)
    (connected forge mines)
    (connected mines forge)
    (connected mines boss-chamber)
    (connected boss-chamber mines)
    (is-firelink firelink)
    (has-bonfire firelink)
    (is-blacksmith forge)
    (titanite-at mines)

    ;; Minor enemies
    (enemy-at miner mines)
    (is-alive miner)

    ;; Bosses
    (enemy-at armored-boss boss-chamber)
    (is-alive armored-boss)
    (has-active-boss boss-chamber)

    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; HP ladder
    (hp-next hp0 hp1)     (hp-next hp1 hp2)     (hp-next hp2 hp3)     (hp-next hp3 hp4)
    (hp-zero hp0)
    (hp-leq hp0 hp0)     (hp-leq hp0 hp1)     (hp-leq hp0 hp2)     (hp-leq hp0 hp3)     (hp-leq hp0 hp4)
    (hp-leq hp1 hp1)     (hp-leq hp1 hp2)     (hp-leq hp1 hp3)     (hp-leq hp1 hp4)
    (hp-leq hp2 hp2)     (hp-leq hp2 hp3)     (hp-leq hp2 hp4)
    (hp-leq hp3 hp3)     (hp-leq hp3 hp4)
    (hp-leq hp4 hp4)    (player-max-hp hp4)
    (player-hp hp4)
    (player-current-level pl0)
    (player-level-next pl0 pl1)
    (player-weapon-level w0)
    (wlevel-next w0 w1)

    ;; Boss phases
    (boss-phase-zero bp0)
    (boss-phase-next bp6 bp5)
    (boss-phase-next bp5 bp4)
    (boss-phase-next bp4 bp3)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase armored-boss bp6)
    (boss-current-phase armored-boss bp6)

    ;; Estus (leave e4 locked for boss to unlock)
    (estus-unlocked e1) (estus-full e1)
    (estus-unlocked e2) (estus-full e2)
    (estus-unlocked e3) (estus-full e3)

    ;; Souls ladder
    (soul-next s0 s1)     (soul-next s1 s2)     (soul-next s2 s3)     (soul-next s3 s4)
    (soul-next s4 s5)     (soul-next s5 s6)     (soul-next s6 s7)     (soul-next s7 s8)
    (player-max-souls s8)
    (player-souls s0)

    ;; Combat damage tables
    (hp-after-attack miner hp4 hp3)
    (hp-after-attack miner hp3 hp2)
    (hp-after-attack miner hp2 hp1)
    (hp-after-attack miner hp1 hp0)
    (hp-after-attack armored-boss hp4 hp3)
    (hp-after-attack armored-boss hp3 hp2)
    (hp-after-attack armored-boss hp2 hp1)
    (hp-after-attack armored-boss hp1 hp0)

    ;; Soul drops (saturating)
    (soul-after-drop miner s0 s2)
    (soul-after-drop miner s1 s3)
    (soul-after-drop miner s2 s4)
    (soul-after-drop miner s3 s5)
    (soul-after-drop miner s4 s6)
    (soul-after-drop miner s5 s7)
    (soul-after-drop miner s6 s8)
    (soul-after-drop miner s7 s8)
    (soul-after-drop miner s8 s8)
    (soul-after-drop armored-boss s0 s3)
    (soul-after-drop armored-boss s1 s4)
    (soul-after-drop armored-boss s2 s5)
    (soul-after-drop armored-boss s3 s6)
    (soul-after-drop armored-boss s4 s7)
    (soul-after-drop armored-boss s5 s8)
    (soul-after-drop armored-boss s6 s8)
    (soul-after-drop armored-boss s7 s8)
    (soul-after-drop armored-boss s8 s8)

    ;; Level up costs
    (soul-spend-for-level pl0 pl1 s2 s0)
    (soul-spend-for-level pl0 pl1 s3 s1)
    (soul-spend-for-level pl0 pl1 s4 s2)
    (soul-spend-for-level pl0 pl1 s5 s3)
    (soul-spend-for-level pl0 pl1 s6 s4)
    (soul-spend-for-level pl0 pl1 s7 s5)
    (soul-spend-for-level pl0 pl1 s8 s6)

    ;; Boss weapon requirements
    (can-damage-boss armored-boss w1)

    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul armored-boss)
  ))
  (:metric minimize (total-cost))
)

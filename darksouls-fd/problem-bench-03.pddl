;; ===================================================================
;; BENCHMARK PROBLEM 03 - FD Version: Resource Management
;; Difficulty: Easy-Medium
;; ===================================================================
(define (problem bench-03-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink area1 area2 boss-room - location
    soldier1 soldier2 - minor-enemy
    area-boss - boss

    hp0 hp1 hp2 hp3 hp4 hp5 hp6 hp7 hp8 hp9 hp10 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    ;; Map
    (connected firelink area1)
    (connected area1 firelink)
    (connected area1 area2)
    (connected area2 area1)
    (connected area2 boss-room)
    (connected boss-room area2)
    (is-firelink firelink)
    (has-bonfire firelink)

    ;; Minor enemies
    (enemy-at soldier1 area1)
    (is-alive soldier1)
    (enemy-at soldier2 area2)
    (is-alive soldier2)

    ;; Bosses
    (enemy-at area-boss boss-room)
    (is-alive area-boss)
    (has-active-boss boss-room)

    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; HP ladder
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5) (hp-next hp5 hp6) (hp-next hp6 hp7) (hp-next hp7 hp8) (hp-next hp8 hp9) (hp-next hp9 hp10)
    (hp-zero hp0)
    ;; HP-HEAL table: Estus heals +5, capped by max-hp ?m
    ;; (hp-heal ?m ?h_before ?h_after)
    ;; ---------------------------------------------
    ;; max = hp0
    (hp-heal hp0 hp0 hp0) (hp-heal hp0 hp1 hp0) (hp-heal hp0 hp2 hp0) (hp-heal hp0 hp3 hp0) (hp-heal hp0 hp4 hp0)
    (hp-heal hp0 hp5 hp0) (hp-heal hp0 hp6 hp0) (hp-heal hp0 hp7 hp0) (hp-heal hp0 hp8 hp0) (hp-heal hp0 hp9 hp0)
    (hp-heal hp0 hp10 hp0)
    ;; max = hp1
    (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1) (hp-heal hp1 hp2 hp1) (hp-heal hp1 hp3 hp1) (hp-heal hp1 hp4 hp1)
    (hp-heal hp1 hp5 hp1) (hp-heal hp1 hp6 hp1) (hp-heal hp1 hp7 hp1) (hp-heal hp1 hp8 hp1) (hp-heal hp1 hp9 hp1)
    (hp-heal hp1 hp10 hp1)
    ;; max = hp2
    (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2) (hp-heal hp2 hp3 hp2) (hp-heal hp2 hp4 hp2)
    (hp-heal hp2 hp5 hp2) (hp-heal hp2 hp6 hp2) (hp-heal hp2 hp7 hp2) (hp-heal hp2 hp8 hp2) (hp-heal hp2 hp9 hp2)
    (hp-heal hp2 hp10 hp2)
    ;; max = hp3
    (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3) (hp-heal hp3 hp4 hp3)
    (hp-heal hp3 hp5 hp3) (hp-heal hp3 hp6 hp3) (hp-heal hp3 hp7 hp3) (hp-heal hp3 hp8 hp3) (hp-heal hp3 hp9 hp3)
    (hp-heal hp3 hp10 hp3)
    ;; max = hp4
    (hp-heal hp4 hp0 hp4) (hp-heal hp4 hp1 hp4) (hp-heal hp4 hp2 hp4) (hp-heal hp4 hp3 hp4) (hp-heal hp4 hp4 hp4)
    (hp-heal hp4 hp5 hp4) (hp-heal hp4 hp6 hp4) (hp-heal hp4 hp7 hp4) (hp-heal hp4 hp8 hp4) (hp-heal hp4 hp9 hp4)
    (hp-heal hp4 hp10 hp4)
    ;; max = hp5
    (hp-heal hp5 hp0 hp5) (hp-heal hp5 hp1 hp5) (hp-heal hp5 hp2 hp5) (hp-heal hp5 hp3 hp5) (hp-heal hp5 hp4 hp5)
    (hp-heal hp5 hp5 hp5) (hp-heal hp5 hp6 hp5) (hp-heal hp5 hp7 hp5) (hp-heal hp5 hp8 hp5) (hp-heal hp5 hp9 hp5)
    (hp-heal hp5 hp10 hp5)
    ;; max = hp6
    (hp-heal hp6 hp0 hp5) (hp-heal hp6 hp1 hp6) (hp-heal hp6 hp2 hp6) (hp-heal hp6 hp3 hp6) (hp-heal hp6 hp4 hp6)
    (hp-heal hp6 hp5 hp6) (hp-heal hp6 hp6 hp6) (hp-heal hp6 hp7 hp6) (hp-heal hp6 hp8 hp6) (hp-heal hp6 hp9 hp6)
    (hp-heal hp6 hp10 hp6)
    ;; max = hp7
    (hp-heal hp7 hp0 hp5) (hp-heal hp7 hp1 hp6) (hp-heal hp7 hp2 hp7) (hp-heal hp7 hp3 hp7) (hp-heal hp7 hp4 hp7)
    (hp-heal hp7 hp5 hp7) (hp-heal hp7 hp6 hp7) (hp-heal hp7 hp7 hp7) (hp-heal hp7 hp8 hp7) (hp-heal hp7 hp9 hp7)
    (hp-heal hp7 hp10 hp7)
    ;; max = hp8
    (hp-heal hp8 hp0 hp5) (hp-heal hp8 hp1 hp6) (hp-heal hp8 hp2 hp7) (hp-heal hp8 hp3 hp8) (hp-heal hp8 hp4 hp8)
    (hp-heal hp8 hp5 hp8) (hp-heal hp8 hp6 hp8) (hp-heal hp8 hp7 hp8) (hp-heal hp8 hp8 hp8) (hp-heal hp8 hp9 hp8)
    (hp-heal hp8 hp10 hp8)
    ;; max = hp9
    (hp-heal hp9 hp0 hp5) (hp-heal hp9 hp1 hp6) (hp-heal hp9 hp2 hp7) (hp-heal hp9 hp3 hp8) (hp-heal hp9 hp4 hp9)
    (hp-heal hp9 hp5 hp9) (hp-heal hp9 hp6 hp9) (hp-heal hp9 hp7 hp9) (hp-heal hp9 hp8 hp9) (hp-heal hp9 hp9 hp9)
    (hp-heal hp9 hp10 hp9)
    ;; max = hp10
    (hp-heal hp10 hp0 hp5) (hp-heal hp10 hp1 hp6) (hp-heal hp10 hp2 hp7) (hp-heal hp10 hp3 hp8) (hp-heal hp10 hp4 hp9)
    (hp-heal hp10 hp5 hp10) (hp-heal hp10 hp6 hp10) (hp-heal hp10 hp7 hp10) (hp-heal hp10 hp8 hp10) (hp-heal hp10 hp9 hp10)
    (hp-heal hp10 hp10 hp10)
    ;; HP-HEAL table: Estus heals +5, capped by max-hp ?m
    ;; ---------------------------------------------
    ;; max = hp10
    (player-max-hp hp5)
    (player-hp hp5)
    (player-current-level pl0)
    (player-level-next pl0 pl1) (player-level-next pl1 pl2) (player-level-next pl2 pl3) (player-level-next pl3 pl4) (player-level-next pl4 pl5)
    (player-weapon-level w0)

    ;; Boss phases
    (boss-phase-zero bp0)
    (boss-phase-next bp5 bp4)
    (boss-phase-next bp4 bp3)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase area-boss bp5)
    (boss-current-phase area-boss bp5)

    ;; Estus (leave e3 locked for boss to unlock)
    (estus-unlocked e1) (estus-full e1)
    (estus-unlocked e2) (estus-full e2)

    (hp-after-attack area-boss hp10 hp9)
    (hp-after-attack area-boss hp9 hp8)
    (hp-after-attack area-boss hp8 hp7)
    (hp-after-attack area-boss hp7 hp6)
    (hp-after-attack area-boss hp6 hp5)
    (hp-after-attack area-boss hp5 hp4)
    (hp-after-attack area-boss hp4 hp3)
    (hp-after-attack area-boss hp3 hp2)
    (hp-after-attack area-boss hp2 hp1)
    (hp-after-attack area-boss hp1 hp0)
    (hp-after-attack soldier1 hp10 hp9)
    (hp-after-attack soldier1 hp9 hp8)
    (hp-after-attack soldier1 hp8 hp7)
    (hp-after-attack soldier1 hp7 hp6)
    (hp-after-attack soldier1 hp6 hp5)
    (hp-after-attack soldier1 hp5 hp4)
    (hp-after-attack soldier1 hp4 hp3)
    (hp-after-attack soldier1 hp3 hp2)
    (hp-after-attack soldier1 hp2 hp1)
    (hp-after-attack soldier1 hp1 hp0)
    (hp-after-attack soldier2 hp10 hp9)
    (hp-after-attack soldier2 hp9 hp8)
    (hp-after-attack soldier2 hp8 hp7)
    (hp-after-attack soldier2 hp7 hp6)
    (hp-after-attack soldier2 hp6 hp5)
    (hp-after-attack soldier2 hp5 hp4)
    (hp-after-attack soldier2 hp4 hp3)
    (hp-after-attack soldier2 hp3 hp2)
    (hp-after-attack soldier2 hp2 hp1)
    (hp-after-attack soldier2 hp1 hp0)
    ;; Souls ladder
    (soul-next s0 s1)     (soul-next s1 s2)     (soul-next s2 s3)     (soul-next s3 s4)
    (soul-next s4 s5)     (soul-next s5 s6)     (soul-next s6 s7)     (soul-next s7 s8)
    (soul-next s8 s9)
    (player-max-souls s9)
    (soul-min s0)
    (player-souls s0)

    ;; Combat damage tables

    ;; Soul drops (saturating)
    (soul-after-drop soldier1 s0 s2)
    (soul-after-drop soldier1 s1 s3)
    (soul-after-drop soldier1 s2 s4)
    (soul-after-drop soldier1 s3 s5)
    (soul-after-drop soldier1 s4 s6)
    (soul-after-drop soldier1 s5 s7)
    (soul-after-drop soldier1 s6 s8)
    (soul-after-drop soldier1 s7 s9)
    (soul-after-drop soldier1 s8 s9)
    (soul-after-drop soldier1 s9 s9)
    (soul-after-drop soldier2 s0 s2)
    (soul-after-drop soldier2 s1 s3)
    (soul-after-drop soldier2 s2 s4)
    (soul-after-drop soldier2 s3 s5)
    (soul-after-drop soldier2 s4 s6)
    (soul-after-drop soldier2 s5 s7)
    (soul-after-drop soldier2 s6 s8)
    (soul-after-drop soldier2 s7 s9)
    (soul-after-drop soldier2 s8 s9)
    (soul-after-drop soldier2 s9 s9)
    (soul-after-drop area-boss s0 s3)
    (soul-after-drop area-boss s1 s4)
    (soul-after-drop area-boss s2 s5)
    (soul-after-drop area-boss s3 s6)
    (soul-after-drop area-boss s4 s7)
    (soul-after-drop area-boss s5 s8)
    (soul-after-drop area-boss s6 s9)
    (soul-after-drop area-boss s7 s9)
    (soul-after-drop area-boss s8 s9)
    (soul-after-drop area-boss s9 s9)

    ;; Level up costs
    (soul-spend-for-level pl0 pl1 s2 s0) (soul-spend-for-level pl0 pl1 s3 s1) (soul-spend-for-level pl0 pl1 s4 s2) (soul-spend-for-level pl0 pl1 s5 s3) (soul-spend-for-level pl0 pl1 s6 s4) (soul-spend-for-level pl0 pl1 s7 s5) (soul-spend-for-level pl0 pl1 s8 s6) (soul-spend-for-level pl0 pl1 s9 s7)
    (soul-spend-for-level pl1 pl2 s2 s0) (soul-spend-for-level pl1 pl2 s3 s1) (soul-spend-for-level pl1 pl2 s4 s2) (soul-spend-for-level pl1 pl2 s5 s3) (soul-spend-for-level pl1 pl2 s6 s4) (soul-spend-for-level pl1 pl2 s7 s5) (soul-spend-for-level pl1 pl2 s8 s6) (soul-spend-for-level pl1 pl2 s9 s7)
    (soul-spend-for-level pl2 pl3 s2 s0) (soul-spend-for-level pl2 pl3 s3 s1) (soul-spend-for-level pl2 pl3 s4 s2) (soul-spend-for-level pl2 pl3 s5 s3) (soul-spend-for-level pl2 pl3 s6 s4) (soul-spend-for-level pl2 pl3 s7 s5) (soul-spend-for-level pl2 pl3 s8 s6) (soul-spend-for-level pl2 pl3 s9 s7)
    (soul-spend-for-level pl3 pl4 s2 s0) (soul-spend-for-level pl3 pl4 s3 s1) (soul-spend-for-level pl3 pl4 s4 s2) (soul-spend-for-level pl3 pl4 s5 s3) (soul-spend-for-level pl3 pl4 s6 s4) (soul-spend-for-level pl3 pl4 s7 s5) (soul-spend-for-level pl3 pl4 s8 s6) (soul-spend-for-level pl3 pl4 s9 s7)
    (soul-spend-for-level pl4 pl5 s2 s0) (soul-spend-for-level pl4 pl5 s3 s1) (soul-spend-for-level pl4 pl5 s4 s2) (soul-spend-for-level pl4 pl5 s5 s3) (soul-spend-for-level pl4 pl5 s6 s4) (soul-spend-for-level pl4 pl5 s7 s5) (soul-spend-for-level pl4 pl5 s8 s6) (soul-spend-for-level pl4 pl5 s9 s7)

    ;; Boss weapon requirements
    (can-damage-boss area-boss w0)

    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul area-boss)
  ))
  (:metric minimize (total-cost))
)

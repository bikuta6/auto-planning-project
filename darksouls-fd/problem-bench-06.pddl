;; ===================================================================
;; BENCHMARK PROBLEM 06 - FD Version: Two Bosses
;; Difficulty: Medium-Hard
;; ===================================================================
(define (problem bench-06-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink tower crypt - location
    knight thief - minor-enemy
    tower-boss crypt-boss - boss
    
    hp0 hp1 hp2 hp3 hp4 hp5 hp6 hp7 hp8 hp9 hp10 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink tower)
    (connected tower firelink)
    (connected firelink crypt)
    (connected crypt firelink)
    
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire tower)
    
    (enemy-at knight tower)
    (enemy-at thief crypt)
    (is-alive knight)
    (is-alive thief)
    
    (enemy-at tower-boss tower)
    (enemy-at crypt-boss crypt)
    (is-alive tower-boss)
    (is-alive crypt-boss)
    (has-active-boss tower)
    (has-active-boss crypt)
    
    (at-player firelink)
    (last-rested-bonfire firelink)
    
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
    
    (boss-phase-zero bp0)
    (boss-phase-next bp5 bp4) (boss-phase-next bp4 bp3) (boss-phase-next bp3 bp2) (boss-phase-next bp2 bp1) (boss-phase-next bp1 bp0)
    (boss-max-phase tower-boss bp5)
    (boss-current-phase tower-boss bp5)
    (boss-max-phase crypt-boss bp5)
    (boss-current-phase crypt-boss bp5)
    
    (estus-unlocked e1) (estus-full e1)
    (estus-unlocked e2) (estus-full e2)
    
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4)
    (soul-next s4 s5) (soul-next s5 s6) (soul-next s6 s7) (soul-next s7 s8) (soul-next s8 s9)
    (player-max-souls s9)
    (soul-min s0)
    (player-souls s0)
    
    ;; Combat tables
    
    (hp-after-attack crypt-boss hp10 hp9)
    (hp-after-attack crypt-boss hp9 hp8)
    (hp-after-attack crypt-boss hp8 hp7)
    (hp-after-attack crypt-boss hp7 hp6)
    (hp-after-attack crypt-boss hp6 hp5)
    (hp-after-attack crypt-boss hp5 hp4)
    (hp-after-attack crypt-boss hp4 hp3)
    (hp-after-attack crypt-boss hp3 hp2)
    (hp-after-attack crypt-boss hp2 hp1)
    (hp-after-attack crypt-boss hp1 hp0)
    (hp-after-attack knight hp10 hp9)
    (hp-after-attack knight hp9 hp8)
    (hp-after-attack knight hp8 hp7)
    (hp-after-attack knight hp7 hp6)
    (hp-after-attack knight hp6 hp5)
    (hp-after-attack knight hp5 hp4)
    (hp-after-attack knight hp4 hp3)
    (hp-after-attack knight hp3 hp2)
    (hp-after-attack knight hp2 hp1)
    (hp-after-attack knight hp1 hp0)
    (hp-after-attack thief hp10 hp9)
    (hp-after-attack thief hp9 hp8)
    (hp-after-attack thief hp8 hp7)
    (hp-after-attack thief hp7 hp6)
    (hp-after-attack thief hp6 hp5)
    (hp-after-attack thief hp5 hp4)
    (hp-after-attack thief hp4 hp3)
    (hp-after-attack thief hp3 hp2)
    (hp-after-attack thief hp2 hp1)
    (hp-after-attack thief hp1 hp0)
    (hp-after-attack tower-boss hp10 hp9)
    (hp-after-attack tower-boss hp9 hp8)
    (hp-after-attack tower-boss hp8 hp7)
    (hp-after-attack tower-boss hp7 hp6)
    (hp-after-attack tower-boss hp6 hp5)
    (hp-after-attack tower-boss hp5 hp4)
    (hp-after-attack tower-boss hp4 hp3)
    (hp-after-attack tower-boss hp3 hp2)
    (hp-after-attack tower-boss hp2 hp1)
    (hp-after-attack tower-boss hp1 hp0)
    ;; Soul drops
    (soul-after-drop knight s0 s2) (soul-after-drop knight s1 s3) (soul-after-drop knight s2 s4)
    (soul-after-drop knight s3 s5) (soul-after-drop knight s4 s6) (soul-after-drop knight s5 s7)
    (soul-after-drop knight s6 s8) (soul-after-drop knight s7 s9) (soul-after-drop knight s8 s9) (soul-after-drop knight s9 s9)
    (soul-after-drop thief s0 s2) (soul-after-drop thief s1 s3) (soul-after-drop thief s2 s4)
    (soul-after-drop thief s3 s5) (soul-after-drop thief s4 s6) (soul-after-drop thief s5 s7)
    (soul-after-drop thief s6 s8) (soul-after-drop thief s7 s9) (soul-after-drop thief s8 s9) (soul-after-drop thief s9 s9)
    (soul-after-drop tower-boss s0 s3) (soul-after-drop tower-boss s1 s4) (soul-after-drop tower-boss s2 s5)
    (soul-after-drop tower-boss s3 s6) (soul-after-drop tower-boss s4 s7) (soul-after-drop tower-boss s5 s8)
    (soul-after-drop tower-boss s6 s9) (soul-after-drop tower-boss s7 s9) (soul-after-drop tower-boss s8 s9) (soul-after-drop tower-boss s9 s9)
    (soul-after-drop crypt-boss s0 s3) (soul-after-drop crypt-boss s1 s4) (soul-after-drop crypt-boss s2 s5)
    (soul-after-drop crypt-boss s3 s6) (soul-after-drop crypt-boss s4 s7) (soul-after-drop crypt-boss s5 s8)
    (soul-after-drop crypt-boss s6 s9) (soul-after-drop crypt-boss s7 s9) (soul-after-drop crypt-boss s8 s9) (soul-after-drop crypt-boss s9 s9)
    
    (soul-spend-for-level pl0 pl1 s2 s0) (soul-spend-for-level pl0 pl1 s3 s1) (soul-spend-for-level pl0 pl1 s4 s2) (soul-spend-for-level pl0 pl1 s5 s3) (soul-spend-for-level pl0 pl1 s6 s4) (soul-spend-for-level pl0 pl1 s7 s5) (soul-spend-for-level pl0 pl1 s8 s6) (soul-spend-for-level pl0 pl1 s9 s7)
    (soul-spend-for-level pl1 pl2 s2 s0) (soul-spend-for-level pl1 pl2 s3 s1) (soul-spend-for-level pl1 pl2 s4 s2) (soul-spend-for-level pl1 pl2 s5 s3) (soul-spend-for-level pl1 pl2 s6 s4) (soul-spend-for-level pl1 pl2 s7 s5) (soul-spend-for-level pl1 pl2 s8 s6) (soul-spend-for-level pl1 pl2 s9 s7)
    (soul-spend-for-level pl2 pl3 s2 s0) (soul-spend-for-level pl2 pl3 s3 s1) (soul-spend-for-level pl2 pl3 s4 s2) (soul-spend-for-level pl2 pl3 s5 s3) (soul-spend-for-level pl2 pl3 s6 s4) (soul-spend-for-level pl2 pl3 s7 s5) (soul-spend-for-level pl2 pl3 s8 s6) (soul-spend-for-level pl2 pl3 s9 s7)
    (soul-spend-for-level pl3 pl4 s2 s0) (soul-spend-for-level pl3 pl4 s3 s1) (soul-spend-for-level pl3 pl4 s4 s2) (soul-spend-for-level pl3 pl4 s5 s3) (soul-spend-for-level pl3 pl4 s6 s4) (soul-spend-for-level pl3 pl4 s7 s5) (soul-spend-for-level pl3 pl4 s8 s6) (soul-spend-for-level pl3 pl4 s9 s7)
    (soul-spend-for-level pl4 pl5 s2 s0) (soul-spend-for-level pl4 pl5 s3 s1) (soul-spend-for-level pl4 pl5 s4 s2) (soul-spend-for-level pl4 pl5 s5 s3) (soul-spend-for-level pl4 pl5 s6 s4) (soul-spend-for-level pl4 pl5 s7 s5) (soul-spend-for-level pl4 pl5 s8 s6) (soul-spend-for-level pl4 pl5 s9 s7)
    
    (can-damage-boss tower-boss w0)
    (can-damage-boss crypt-boss w0)
    
    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul tower-boss)
    (deposited-soul crypt-boss)
  ))
  (:metric minimize (total-cost))
)

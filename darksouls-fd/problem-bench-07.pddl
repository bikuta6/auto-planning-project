;; BENCHMARK 07-FD: Complex Navigation
(define (problem bench-07-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink plaza upper lower shortcut-dest boss-arena - location
    grunt1 grunt2 grunt3 - minor-enemy
    plaza-boss - boss
    hp0 hp1 hp2 hp3 hp4 hp5 hp6 hp7 hp8 hp9 hp10 - hp-level
    w0 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink plaza) (connected plaza firelink)
    (connected plaza upper) (connected upper plaza)
    (connected upper lower) (connected lower upper)
    (connected lower boss-arena) (connected boss-arena lower)
    (can-open-shortcut lower firelink)
    (is-firelink firelink) (has-bonfire firelink) (has-bonfire lower)
    (enemy-at grunt1 plaza) (enemy-at grunt2 upper) (enemy-at grunt3 lower)
    (is-alive grunt1) (is-alive grunt2) (is-alive grunt3)
    (enemy-at plaza-boss boss-arena) (is-alive plaza-boss) (has-active-boss boss-arena)
    (at-player firelink) (last-rested-bonfire firelink)
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
    (player-max-hp hp5) (player-hp hp5)
    (player-level-next pl0 pl1) (player-level-next pl1 pl2) (player-level-next pl2 pl3) (player-level-next pl3 pl4) (player-level-next pl4 pl5)
    (player-weapon-level w0)
    (boss-phase-zero bp0)
    (boss-phase-next bp5 bp4) (boss-phase-next bp4 bp3) (boss-phase-next bp3 bp2) (boss-phase-next bp2 bp1) (boss-phase-next bp1 bp0)
    (boss-max-phase plaza-boss bp5) (boss-current-phase plaza-boss bp5)
    (estus-unlocked e1) (estus-full e1) (estus-unlocked e2) (estus-full e2)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4)
    (soul-next s4 s5) (soul-next s5 s6) (soul-next s6 s7) (soul-next s7 s8) (soul-next s8 s9)
    (hp-after-attack grunt1 hp10 hp9)
    (hp-after-attack grunt1 hp9 hp8)
    (hp-after-attack grunt1 hp8 hp7)
    (hp-after-attack grunt1 hp7 hp6)
    (hp-after-attack grunt1 hp6 hp5)
    (hp-after-attack grunt1 hp5 hp4)
    (hp-after-attack grunt1 hp4 hp3)
    (hp-after-attack grunt1 hp3 hp2)
    (hp-after-attack grunt1 hp2 hp1)
    (hp-after-attack grunt1 hp1 hp0)
    (hp-after-attack grunt2 hp10 hp9)
    (hp-after-attack grunt2 hp9 hp8)
    (hp-after-attack grunt2 hp8 hp7)
    (hp-after-attack grunt2 hp7 hp6)
    (hp-after-attack grunt2 hp6 hp5)
    (hp-after-attack grunt2 hp5 hp4)
    (hp-after-attack grunt2 hp4 hp3)
    (hp-after-attack grunt2 hp3 hp2)
    (hp-after-attack grunt2 hp2 hp1)
    (hp-after-attack grunt2 hp1 hp0)
    (hp-after-attack grunt3 hp10 hp9)
    (hp-after-attack grunt3 hp9 hp8)
    (hp-after-attack grunt3 hp8 hp7)
    (hp-after-attack grunt3 hp7 hp6)
    (hp-after-attack grunt3 hp6 hp5)
    (hp-after-attack grunt3 hp5 hp4)
    (hp-after-attack grunt3 hp4 hp3)
    (hp-after-attack grunt3 hp3 hp2)
    (hp-after-attack grunt3 hp2 hp1)
    (hp-after-attack grunt3 hp1 hp0)
    (hp-after-attack plaza-boss hp10 hp9)
    (hp-after-attack plaza-boss hp9 hp8)
    (hp-after-attack plaza-boss hp8 hp7)
    (hp-after-attack plaza-boss hp7 hp6)
    (hp-after-attack plaza-boss hp6 hp5)
    (hp-after-attack plaza-boss hp5 hp4)
    (hp-after-attack plaza-boss hp4 hp3)
    (hp-after-attack plaza-boss hp3 hp2)
    (hp-after-attack plaza-boss hp2 hp1)
    (hp-after-attack plaza-boss hp1 hp0)
    ;; Souls lader 
    (player-max-souls s9) 
    (player-souls s0)
    (soul-min s0)
    (soul-after-drop grunt1 s0 s2) (soul-after-drop grunt1 s1 s3) (soul-after-drop grunt1 s2 s4) (soul-after-drop grunt1 s3 s5) (soul-after-drop grunt1 s4 s6) (soul-after-drop grunt1 s5 s7) (soul-after-drop grunt1 s6 s8) (soul-after-drop grunt1 s7 s9) (soul-after-drop grunt1 s8 s9) (soul-after-drop grunt1 s9 s9)
    (soul-after-drop grunt2 s0 s2) (soul-after-drop grunt2 s1 s3) (soul-after-drop grunt2 s2 s4) (soul-after-drop grunt2 s3 s5) (soul-after-drop grunt2 s4 s6) (soul-after-drop grunt2 s5 s7) (soul-after-drop grunt2 s6 s8) (soul-after-drop grunt2 s7 s9) (soul-after-drop grunt2 s8 s9) (soul-after-drop grunt2 s9 s9)
    (soul-after-drop grunt3 s0 s2) (soul-after-drop grunt3 s1 s3) (soul-after-drop grunt3 s2 s4) (soul-after-drop grunt3 s3 s5) (soul-after-drop grunt3 s4 s6) (soul-after-drop grunt3 s5 s7) (soul-after-drop grunt3 s6 s8) (soul-after-drop grunt3 s7 s9) (soul-after-drop grunt3 s8 s9) (soul-after-drop grunt3 s9 s9)
    (soul-after-drop plaza-boss s0 s3) (soul-after-drop plaza-boss s1 s4) (soul-after-drop plaza-boss s2 s5) (soul-after-drop plaza-boss s3 s6) (soul-after-drop plaza-boss s4 s7) (soul-after-drop plaza-boss s5 s8) (soul-after-drop plaza-boss s6 s9) (soul-after-drop plaza-boss s7 s9) (soul-after-drop plaza-boss s8 s9) (soul-after-drop plaza-boss s9 s9)
    (soul-spend-for-level pl0 pl1 s2 s0) (soul-spend-for-level pl0 pl1 s3 s1) (soul-spend-for-level pl0 pl1 s4 s2) (soul-spend-for-level pl0 pl1 s5 s3) (soul-spend-for-level pl0 pl1 s6 s4) (soul-spend-for-level pl0 pl1 s7 s5) (soul-spend-for-level pl0 pl1 s8 s6) (soul-spend-for-level pl0 pl1 s9 s7)
    (soul-spend-for-level pl1 pl2 s2 s0) (soul-spend-for-level pl1 pl2 s3 s1) (soul-spend-for-level pl1 pl2 s4 s2) (soul-spend-for-level pl1 pl2 s5 s3) (soul-spend-for-level pl1 pl2 s6 s4) (soul-spend-for-level pl1 pl2 s7 s5) (soul-spend-for-level pl1 pl2 s8 s6) (soul-spend-for-level pl1 pl2 s9 s7)
    (soul-spend-for-level pl2 pl3 s2 s0) (soul-spend-for-level pl2 pl3 s3 s1) (soul-spend-for-level pl2 pl3 s4 s2) (soul-spend-for-level pl2 pl3 s5 s3) (soul-spend-for-level pl2 pl3 s6 s4) (soul-spend-for-level pl2 pl3 s7 s5) (soul-spend-for-level pl2 pl3 s8 s6) (soul-spend-for-level pl2 pl3 s9 s7)
    (soul-spend-for-level pl3 pl4 s2 s0) (soul-spend-for-level pl3 pl4 s3 s1) (soul-spend-for-level pl3 pl4 s4 s2) (soul-spend-for-level pl3 pl4 s5 s3) (soul-spend-for-level pl3 pl4 s6 s4) (soul-spend-for-level pl3 pl4 s7 s5) (soul-spend-for-level pl3 pl4 s8 s6) (soul-spend-for-level pl3 pl4 s9 s7)
    (soul-spend-for-level pl4 pl5 s2 s0) (soul-spend-for-level pl4 pl5 s3 s1) (soul-spend-for-level pl4 pl5 s4 s2) (soul-spend-for-level pl4 pl5 s5 s3) (soul-spend-for-level pl4 pl5 s6 s4) (soul-spend-for-level pl4 pl5 s7 s5) (soul-spend-for-level pl4 pl5 s8 s6) (soul-spend-for-level pl4 pl5 s9 s7)
    (can-damage-boss plaza-boss w0)
    (= (total-cost) 0)
  )
  (:goal (deposited-soul plaza-boss))
  (:metric minimize (total-cost))
)

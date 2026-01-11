(define (problem dark-souls-game-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink burg parish darkroot boss-arena roof - location
    crest-of-artorias - key
    balder-knight hollow-soldier - minor-enemy
    sif gargoyles - boss

    hp0 hp1 hp2 hp3 hp4 hp5 hp6 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 bp6 - boss-phase
    e1 e2 e3 e4 e5 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 - soul-level
  )
  (:init
    (connected firelink burg)
    (connected burg firelink)
    (connected burg parish)
    (connected parish burg)
    (connected parish darkroot)
    (connected darkroot parish)
    (connected darkroot boss-arena)
    (connected boss-arena darkroot)
    (connected parish roof)
    (connected roof parish)
    (locked darkroot boss-arena)
    (locked boss-arena darkroot)
    (matches crest-of-artorias darkroot boss-arena)
    (key-at crest-of-artorias parish)
    (can-open-shortcut parish firelink)
    (has-active-boss boss-arena)
    (has-active-boss roof)
    (at-player firelink)
    (last-rested-bonfire firelink)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire parish)
    (is-blacksmith parish)
    (titanite-at darkroot)
    (enemy-at hollow-soldier burg)
    (is-alive hollow-soldier)
    (enemy-at balder-knight parish)
    (is-alive balder-knight)
    (enemy-at gargoyles roof)
    (is-alive gargoyles)
    (enemy-at sif boss-arena)
    (is-alive sif)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5) (hp-next hp5 hp6)
    (hp-zero hp0)
    ;; HP-HEAL table: Estus heals +5, capped by max-hp ?m
    ;; (hp-heal ?m ?h_before ?h_after)
    ;; ---------------------------------------------
    ;; max = hp0
    (hp-heal hp0 hp0 hp0) (hp-heal hp0 hp1 hp0) (hp-heal hp0 hp2 hp0) (hp-heal hp0 hp3 hp0) (hp-heal hp0 hp4 hp0)
    (hp-heal hp0 hp5 hp0) (hp-heal hp0 hp6 hp0)
    ;; max = hp1
    (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1) (hp-heal hp1 hp2 hp1) (hp-heal hp1 hp3 hp1) (hp-heal hp1 hp4 hp1)
    (hp-heal hp1 hp5 hp1) (hp-heal hp1 hp6 hp1)
    ;; max = hp2
    (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2) (hp-heal hp2 hp3 hp2) (hp-heal hp2 hp4 hp2)
    (hp-heal hp2 hp5 hp2) (hp-heal hp2 hp6 hp2)
    ;; max = hp3
    (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3) (hp-heal hp3 hp4 hp3)
    (hp-heal hp3 hp5 hp3) (hp-heal hp3 hp6 hp3)
    ;; max = hp4
    (hp-heal hp4 hp0 hp4) (hp-heal hp4 hp1 hp4) (hp-heal hp4 hp2 hp4) (hp-heal hp4 hp3 hp4) (hp-heal hp4 hp4 hp4)
    (hp-heal hp4 hp5 hp4) (hp-heal hp4 hp6 hp4)
    ;; max = hp5
    (hp-heal hp5 hp0 hp5) (hp-heal hp5 hp1 hp5) (hp-heal hp5 hp2 hp5) (hp-heal hp5 hp3 hp5) (hp-heal hp5 hp4 hp5)
    (hp-heal hp5 hp5 hp5) (hp-heal hp5 hp6 hp5)
    ;; max = hp6
    (hp-heal hp6 hp0 hp5) (hp-heal hp6 hp1 hp6) (hp-heal hp6 hp2 hp6) (hp-heal hp6 hp3 hp6) (hp-heal hp6 hp4 hp6)
    (hp-heal hp6 hp5 hp6) (hp-heal hp6 hp6 hp6)
    ;; HP-HEAL table: Estus heals +5, capped by max-hp ?m
    ;; ---------------------------------------------
    ;; max = hp6

    ;; hp ordering (<=)

    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1)  (player-level-next pl1 pl2) (player-level-next pl2 pl3)
    (player-weapon-level w0)
    (wlevel-next w0 w1)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp6 bp5)
    (boss-phase-next bp5 bp4)
    (boss-phase-next bp4 bp3)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)

    (boss-max-phase sif bp6)
    (boss-current-phase sif bp6)

    (boss-max-phase gargoyles bp2)
    (boss-current-phase gargoyles bp2)

    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack balder-knight hp6 hp5)
    (hp-after-attack balder-knight hp5 hp4)
    (hp-after-attack balder-knight hp4 hp3)
    (hp-after-attack balder-knight hp3 hp2)
    (hp-after-attack balder-knight hp2 hp1)
    (hp-after-attack balder-knight hp1 hp0)
    
    (hp-after-attack gargoyles hp6 hp5)
    (hp-after-attack gargoyles hp5 hp4)
    (hp-after-attack gargoyles hp4 hp3)
    (hp-after-attack gargoyles hp3 hp2)
    (hp-after-attack gargoyles hp2 hp1)
    (hp-after-attack gargoyles hp1 hp0)
    
    (hp-after-attack hollow-soldier hp6 hp5)
    (hp-after-attack hollow-soldier hp5 hp4)
    (hp-after-attack hollow-soldier hp4 hp3)
    (hp-after-attack hollow-soldier hp3 hp2)
    (hp-after-attack hollow-soldier hp2 hp1)
    (hp-after-attack hollow-soldier hp1 hp0)
    
    (hp-after-attack sif hp6 hp5)
    (hp-after-attack sif hp5 hp4)
    (hp-after-attack sif hp4 hp3)
    (hp-after-attack sif hp3 hp2)
    (hp-after-attack sif hp2 hp1)
    (hp-after-attack sif hp1 hp0)

    ;; souls gain from minor enemies (saturating)
    (soul-after-drop balder-knight s0 s1) (soul-after-drop balder-knight s1 s2) (soul-after-drop balder-knight s2 s3) (soul-after-drop balder-knight s3 s4) (soul-after-drop balder-knight s4 s5) (soul-after-drop balder-knight s5 s6) (soul-after-drop balder-knight s6 s6)
    (soul-after-drop hollow-soldier s0 s1) (soul-after-drop hollow-soldier s1 s2) (soul-after-drop hollow-soldier s2 s3) (soul-after-drop hollow-soldier s3 s4) (soul-after-drop hollow-soldier s4 s5) (soul-after-drop hollow-soldier s5 s6) (soul-after-drop hollow-soldier s6 s6)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)
    (soul-spend-for-level pl1 pl2 s2 s0) (soul-spend-for-level pl1 pl2 s3 s1) (soul-spend-for-level pl1 pl2 s4 s2) (soul-spend-for-level pl1 pl2 s5 s3) (soul-spend-for-level pl1 pl2 s6 s4)
    (soul-spend-for-level pl2 pl3 s3 s0) (soul-spend-for-level pl2 pl3 s4 s1) (soul-spend-for-level pl2 pl3 s5 s2) (soul-spend-for-level pl2 pl3 s6 s3)

    ;; boss weapon requirements
    (can-damage-boss sif w1)
    (can-damage-boss gargoyles w0)
    (can-damage-boss gargoyles w1)
    (= (total-cost) 0)
  )
  (:goal 
        (and
            (deposited-soul gargoyles)               
            (deposited-soul sif)                     
        )
    )
    (:metric minimize (total-cost))
)

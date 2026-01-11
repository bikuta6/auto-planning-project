(define (problem p05-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink swamp-entrance blighttown quelaag-arena - location
    dummy-key - key
    mob1 mob2 mob3 - minor-enemy
    quelaag - boss

    hp0 hp1 hp2 hp3 hp4 hp5 hp6 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 - player-level
    bp0 bp1 bp2 bp3 bp4 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink swamp-entrance)
    (connected swamp-entrance firelink)
    (connected swamp-entrance blighttown)
    (connected blighttown swamp-entrance)
    (connected blighttown quelaag-arena)
    (connected quelaag-arena blighttown)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire blighttown)
    (is-blacksmith firelink)
    (enemy-at mob1 swamp-entrance)
    (enemy-at mob2 swamp-entrance)
    (enemy-at mob3 blighttown)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)
    (enemy-at quelaag quelaag-arena)
    (is-alive quelaag)
    (has-active-boss quelaag-arena)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5) (hp-next hp5 hp6)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal swamp-entrance (:objects swamp-entrance) (hp-heal swamp-entrance firelink swamp-entrance) (hp-heal swamp-entrance swamp-entrance swamp-entrance)
    (hp-heal blighttown (:objects blighttown) (hp-heal blighttown firelink blighttown) (hp-heal blighttown swamp-entrance blighttown) (hp-heal blighttown blighttown blighttown)
    (hp-heal quelaag-arena (:objects quelaag-arena) (hp-heal quelaag-arena firelink quelaag-arena) (hp-heal quelaag-arena swamp-entrance quelaag-arena) (hp-heal quelaag-arena blighttown quelaag-arena) (hp-heal quelaag-arena quelaag-arena quelaag-arena)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - swamp-entrance -) (hp-heal - blighttown -) (hp-heal - quelaag-arena -) (hp-heal - - -)
    (hp-heal location (:objects -) (hp-heal location firelink location) (hp-heal location swamp-entrance location) (hp-heal location blighttown location) (hp-heal location quelaag-arena location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal dummy-key (:objects -) (hp-heal dummy-key firelink location) (hp-heal dummy-key swamp-entrance dummy-key) (hp-heal dummy-key blighttown dummy-key) (hp-heal dummy-key quelaag-arena dummy-key) (hp-heal dummy-key - dummy-key) (hp-heal dummy-key location dummy-key) (hp-heal dummy-key dummy-key dummy-key)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - swamp-entrance dummy-key) (hp-heal - blighttown -) (hp-heal - quelaag-arena -) (hp-heal - - -) (hp-heal - location -) (hp-heal - dummy-key -) (hp-heal - - -)
    (hp-heal key (:objects -) (hp-heal key firelink location) (hp-heal key swamp-entrance dummy-key) (hp-heal key blighttown -) (hp-heal key quelaag-arena key) (hp-heal key - key) (hp-heal key location key) (hp-heal key dummy-key key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal mob1 (:objects -) (hp-heal mob1 firelink location) (hp-heal mob1 swamp-entrance dummy-key) (hp-heal mob1 blighttown -) (hp-heal mob1 quelaag-arena key) (hp-heal mob1 - mob1) (hp-heal mob1 location mob1) (hp-heal mob1 dummy-key mob1) (hp-heal mob1 - mob1) (hp-heal mob1 key mob1) (hp-heal mob1 mob1 mob1)
    (hp-heal mob2 (:objects -) (hp-heal mob2 firelink location) (hp-heal mob2 swamp-entrance dummy-key) (hp-heal mob2 blighttown -) (hp-heal mob2 quelaag-arena key) (hp-heal mob2 - mob1) (hp-heal mob2 location mob2) (hp-heal mob2 dummy-key mob2) (hp-heal mob2 - mob2) (hp-heal mob2 key mob2) (hp-heal mob2 mob1 mob2) (hp-heal mob2 mob2 mob2)
    (hp-heal mob3 (:objects -) (hp-heal mob3 firelink location) (hp-heal mob3 swamp-entrance dummy-key) (hp-heal mob3 blighttown -) (hp-heal mob3 quelaag-arena key) (hp-heal mob3 - mob1) (hp-heal mob3 location mob2) (hp-heal mob3 dummy-key mob3) (hp-heal mob3 - mob3) (hp-heal mob3 key mob3) (hp-heal mob3 mob1 mob3) (hp-heal mob3 mob2 mob3) (hp-heal mob3 mob3 mob3)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - swamp-entrance dummy-key) (hp-heal - blighttown -) (hp-heal - quelaag-arena key) (hp-heal - - mob1) (hp-heal - location mob2) (hp-heal - dummy-key mob3) (hp-heal - - -) (hp-heal - key -) (hp-heal - mob1 -) (hp-heal - mob2 -) (hp-heal - mob3 -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects -) (hp-heal minor-enemy firelink location) (hp-heal minor-enemy swamp-entrance dummy-key) (hp-heal minor-enemy blighttown -) (hp-heal minor-enemy quelaag-arena key) (hp-heal minor-enemy - mob1) (hp-heal minor-enemy location mob2) (hp-heal minor-enemy dummy-key mob3) (hp-heal minor-enemy - -) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy mob1 minor-enemy) (hp-heal minor-enemy mob2 minor-enemy) (hp-heal minor-enemy mob3 minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal quelaag (:objects -) (hp-heal quelaag firelink location) (hp-heal quelaag swamp-entrance dummy-key) (hp-heal quelaag blighttown -) (hp-heal quelaag quelaag-arena key) (hp-heal quelaag - mob1) (hp-heal quelaag location mob2) (hp-heal quelaag dummy-key mob3) (hp-heal quelaag - -) (hp-heal quelaag key minor-enemy) (hp-heal quelaag mob1 quelaag) (hp-heal quelaag mob2 quelaag) (hp-heal quelaag mob3 quelaag) (hp-heal quelaag - quelaag) (hp-heal quelaag minor-enemy quelaag) (hp-heal quelaag quelaag quelaag)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - swamp-entrance dummy-key) (hp-heal - blighttown -) (hp-heal - quelaag-arena key) (hp-heal - - mob1) (hp-heal - location mob2) (hp-heal - dummy-key mob3) (hp-heal - - -) (hp-heal - key minor-enemy) (hp-heal - mob1 quelaag) (hp-heal - mob2 -) (hp-heal - mob3 -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - quelaag -) (hp-heal - - -)
    (hp-heal boss (:objects -) (hp-heal boss firelink location) (hp-heal boss swamp-entrance dummy-key) (hp-heal boss blighttown -) (hp-heal boss quelaag-arena key) (hp-heal boss - mob1) (hp-heal boss location mob2) (hp-heal boss dummy-key mob3) (hp-heal boss - -) (hp-heal boss key minor-enemy) (hp-heal boss mob1 quelaag) (hp-heal boss mob2 -) (hp-heal boss mob3 boss) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss quelaag boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects -) (hp-heal hp0 firelink location) (hp-heal hp0 swamp-entrance dummy-key) (hp-heal hp0 blighttown -) (hp-heal hp0 quelaag-arena key) (hp-heal hp0 - mob1) (hp-heal hp0 location mob2) (hp-heal hp0 dummy-key mob3) (hp-heal hp0 - -) (hp-heal hp0 key minor-enemy) (hp-heal hp0 mob1 quelaag) (hp-heal hp0 mob2 -) (hp-heal hp0 mob3 boss) (hp-heal hp0 - hp0) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 quelaag hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects -) (hp-heal hp1 firelink location) (hp-heal hp1 swamp-entrance dummy-key) (hp-heal hp1 blighttown -) (hp-heal hp1 quelaag-arena key) (hp-heal hp1 - mob1) (hp-heal hp1 location mob2) (hp-heal hp1 dummy-key mob3) (hp-heal hp1 - -) (hp-heal hp1 key minor-enemy) (hp-heal hp1 mob1 quelaag) (hp-heal hp1 mob2 -) (hp-heal hp1 mob3 boss) (hp-heal hp1 - hp0) (hp-heal hp1 minor-enemy hp1) (hp-heal hp1 quelaag hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects -) (hp-heal hp2 firelink location) (hp-heal hp2 swamp-entrance dummy-key) (hp-heal hp2 blighttown -) (hp-heal hp2 quelaag-arena key) (hp-heal hp2 - mob1) (hp-heal hp2 location mob2) (hp-heal hp2 dummy-key mob3) (hp-heal hp2 - -) (hp-heal hp2 key minor-enemy) (hp-heal hp2 mob1 quelaag) (hp-heal hp2 mob2 -) (hp-heal hp2 mob3 boss) (hp-heal hp2 - hp0) (hp-heal hp2 minor-enemy hp1) (hp-heal hp2 quelaag hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects -) (hp-heal hp3 firelink location) (hp-heal hp3 swamp-entrance dummy-key) (hp-heal hp3 blighttown -) (hp-heal hp3 quelaag-arena key) (hp-heal hp3 - mob1) (hp-heal hp3 location mob2) (hp-heal hp3 dummy-key mob3) (hp-heal hp3 - -) (hp-heal hp3 key minor-enemy) (hp-heal hp3 mob1 quelaag) (hp-heal hp3 mob2 -) (hp-heal hp3 mob3 boss) (hp-heal hp3 - hp0) (hp-heal hp3 minor-enemy hp1) (hp-heal hp3 quelaag hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
    (hp-heal hp4 (:objects -) (hp-heal hp4 firelink location) (hp-heal hp4 swamp-entrance dummy-key) (hp-heal hp4 blighttown -) (hp-heal hp4 quelaag-arena key) (hp-heal hp4 - mob1) (hp-heal hp4 location mob2) (hp-heal hp4 dummy-key mob3) (hp-heal hp4 - -) (hp-heal hp4 key minor-enemy) (hp-heal hp4 mob1 quelaag) (hp-heal hp4 mob2 -) (hp-heal hp4 mob3 boss) (hp-heal hp4 - hp0) (hp-heal hp4 minor-enemy hp1) (hp-heal hp4 quelaag hp2) (hp-heal hp4 - hp3) (hp-heal hp4 boss hp4) (hp-heal hp4 hp0 hp4) (hp-heal hp4 hp1 hp4) (hp-heal hp4 hp2 hp4) (hp-heal hp4 hp3 hp4) (hp-heal hp4 hp4 hp4)
    (hp-heal hp5 (:objects -) (hp-heal hp5 firelink location) (hp-heal hp5 swamp-entrance dummy-key) (hp-heal hp5 blighttown -) (hp-heal hp5 quelaag-arena key) (hp-heal hp5 - mob1) (hp-heal hp5 location mob2) (hp-heal hp5 dummy-key mob3) (hp-heal hp5 - -) (hp-heal hp5 key minor-enemy) (hp-heal hp5 mob1 quelaag) (hp-heal hp5 mob2 -) (hp-heal hp5 mob3 boss) (hp-heal hp5 - hp0) (hp-heal hp5 minor-enemy hp1) (hp-heal hp5 quelaag hp2) (hp-heal hp5 - hp3) (hp-heal hp5 boss hp4) (hp-heal hp5 hp0 hp5) (hp-heal hp5 hp1 hp5) (hp-heal hp5 hp2 hp5) (hp-heal hp5 hp3 hp5) (hp-heal hp5 hp4 hp5) (hp-heal hp5 hp5 hp5)
    (hp-heal hp6 (:objects -) (hp-heal hp6 firelink location) (hp-heal hp6 swamp-entrance dummy-key) (hp-heal hp6 blighttown -) (hp-heal hp6 quelaag-arena key) (hp-heal hp6 - mob1) (hp-heal hp6 location mob2) (hp-heal hp6 dummy-key mob3) (hp-heal hp6 - -) (hp-heal hp6 key minor-enemy) (hp-heal hp6 mob1 quelaag) (hp-heal hp6 mob2 -) (hp-heal hp6 mob3 boss) (hp-heal hp6 - hp0) (hp-heal hp6 minor-enemy hp1) (hp-heal hp6 quelaag hp2) (hp-heal hp6 - hp3) (hp-heal hp6 boss hp4) (hp-heal hp6 hp0 hp5) (hp-heal hp6 hp1 hp6) (hp-heal hp6 hp2 hp6) (hp-heal hp6 hp3 hp6) (hp-heal hp6 hp4 hp6) (hp-heal hp6 hp5 hp6) (hp-heal hp6 hp6 hp6)
    ;; hp ordering (<=)

    (player-max-hp hp4)
    (player-hp hp4)
    (player-current-level pl0) (player-level-next pl0 pl1) (player-level-next pl1 pl2) (player-level-next pl2 pl3)
    (player-weapon-level w0)
    (wlevel-next w0 w1)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp4 bp3)
    (boss-max-phase quelaag bp4)
    (boss-current-phase quelaag bp4)
    (estus-unlocked e1)
    (estus-full e1)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack mob1 hp6 hp5)
    (hp-after-attack mob1 hp5 hp4)
    (hp-after-attack mob1 hp4 hp3)
    (hp-after-attack mob1 hp3 hp2)
    (hp-after-attack mob1 hp2 hp1)
    (hp-after-attack mob1 hp1 hp0)
    (hp-after-attack mob2 hp6 hp5)
    (hp-after-attack mob2 hp5 hp4)
    (hp-after-attack mob2 hp4 hp3)
    (hp-after-attack mob2 hp3 hp2)
    (hp-after-attack mob2 hp2 hp1)
    (hp-after-attack mob2 hp1 hp0)
    (hp-after-attack mob3 hp6 hp5)
    (hp-after-attack mob3 hp5 hp4)
    (hp-after-attack mob3 hp4 hp3)
    (hp-after-attack mob3 hp3 hp2)
    (hp-after-attack mob3 hp2 hp1)
    (hp-after-attack mob3 hp1 hp0)
    (hp-after-attack quelaag hp6 hp5)
    (hp-after-attack quelaag hp5 hp4)
    (hp-after-attack quelaag hp4 hp3)
    (hp-after-attack quelaag hp3 hp2)
    (hp-after-attack quelaag hp2 hp1)
    (hp-after-attack quelaag hp1 hp0)

    ;; souls gain from minor enemies (saturating at s9)
    (soul-after-drop mob1 s0 s1) (soul-after-drop mob1 s1 s2) (soul-after-drop mob1 s2 s3)
    (soul-after-drop mob1 s3 s4) (soul-after-drop mob1 s4 s5) (soul-after-drop mob1 s5 s6)
    (soul-after-drop mob1 s6 s7) (soul-after-drop mob1 s7 s8) (soul-after-drop mob1 s8 s9)
    (soul-after-drop mob1 s9 s9)

    (soul-after-drop mob2 s0 s1) (soul-after-drop mob2 s1 s2) (soul-after-drop mob2 s2 s3)
    (soul-after-drop mob2 s3 s4) (soul-after-drop mob2 s4 s5) (soul-after-drop mob2 s5 s6)
    (soul-after-drop mob2 s6 s7) (soul-after-drop mob2 s7 s8) (soul-after-drop mob2 s8 s9)
    (soul-after-drop mob2 s9 s9)

    (soul-after-drop mob3 s0 s1) (soul-after-drop mob3 s1 s2) (soul-after-drop mob3 s2 s3)
    (soul-after-drop mob3 s3 s4) (soul-after-drop mob3 s4 s5) (soul-after-drop mob3 s5 s6)
    (soul-after-drop mob3 s6 s7) (soul-after-drop mob3 s7 s8) (soul-after-drop mob3 s8 s9)
    (soul-after-drop mob3 s9 s9)


    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)
    (soul-spend-for-level pl1 pl2 s2 s0) (soul-spend-for-level pl1 pl2 s3 s1) (soul-spend-for-level pl1 pl2 s4 s2) (soul-spend-for-level pl1 pl2 s5 s3) (soul-spend-for-level pl1 pl2 s6 s4)
    (soul-spend-for-level pl2 pl3 s3 s0) (soul-spend-for-level pl2 pl3 s4 s1) (soul-spend-for-level pl2 pl3 s5 s2) (soul-spend-for-level pl2 pl3 s6 s3)

    (titanite-at blighttown)

    ;; boss weapon requirements
    (can-damage-boss quelaag w1)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (is-alive quelaag))
    (deposited-soul quelaag)
  ))
    (:metric minimize (total-cost))
)

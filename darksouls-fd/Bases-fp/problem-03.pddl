(define (problem p03-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink parish bell-tower - location
    key-bell - key
    bell-tower-guard - minor-enemy
    dummmy-boss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink parish)
    (connected parish firelink)
    (connected parish bell-tower)
    (locked parish bell-tower)
    (locked bell-tower parish)
    (key-at key-bell firelink)
    (matches key-bell parish bell-tower)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire parish)
    (is-blacksmith firelink)
    (enemy-at bell-tower-guard bell-tower)
    (is-alive bell-tower-guard)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal parish (:objects parish) (hp-heal parish firelink parish) (hp-heal parish parish parish)
    (hp-heal bell-tower (:objects bell-tower) (hp-heal bell-tower firelink bell-tower) (hp-heal bell-tower parish bell-tower) (hp-heal bell-tower bell-tower bell-tower)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - parish -) (hp-heal - bell-tower -) (hp-heal - - -)
    (hp-heal location (:objects location) (hp-heal location firelink location) (hp-heal location parish location) (hp-heal location bell-tower location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal key-bell (:objects location) (hp-heal key-bell firelink key-bell) (hp-heal key-bell parish key-bell) (hp-heal key-bell bell-tower key-bell) (hp-heal key-bell - key-bell) (hp-heal key-bell location key-bell) (hp-heal key-bell key-bell key-bell)
    (hp-heal - (:objects location) (hp-heal - firelink key-bell) (hp-heal - parish -) (hp-heal - bell-tower -) (hp-heal - - -) (hp-heal - location -) (hp-heal - key-bell -) (hp-heal - - -)
    (hp-heal key (:objects location) (hp-heal key firelink key-bell) (hp-heal key parish -) (hp-heal key bell-tower key) (hp-heal key - key) (hp-heal key location key) (hp-heal key key-bell key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal bell-tower-guard (:objects location) (hp-heal bell-tower-guard firelink key-bell) (hp-heal bell-tower-guard parish -) (hp-heal bell-tower-guard bell-tower key) (hp-heal bell-tower-guard - bell-tower-guard) (hp-heal bell-tower-guard location bell-tower-guard) (hp-heal bell-tower-guard key-bell bell-tower-guard) (hp-heal bell-tower-guard - bell-tower-guard) (hp-heal bell-tower-guard key bell-tower-guard) (hp-heal bell-tower-guard bell-tower-guard bell-tower-guard)
    (hp-heal - (:objects location) (hp-heal - firelink key-bell) (hp-heal - parish -) (hp-heal - bell-tower key) (hp-heal - - bell-tower-guard) (hp-heal - location -) (hp-heal - key-bell -) (hp-heal - - -) (hp-heal - key -) (hp-heal - bell-tower-guard -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects location) (hp-heal minor-enemy firelink key-bell) (hp-heal minor-enemy parish -) (hp-heal minor-enemy bell-tower key) (hp-heal minor-enemy - bell-tower-guard) (hp-heal minor-enemy location -) (hp-heal minor-enemy key-bell minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy bell-tower-guard minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal dummmy-boss (:objects location) (hp-heal dummmy-boss firelink key-bell) (hp-heal dummmy-boss parish -) (hp-heal dummmy-boss bell-tower key) (hp-heal dummmy-boss - bell-tower-guard) (hp-heal dummmy-boss location -) (hp-heal dummmy-boss key-bell minor-enemy) (hp-heal dummmy-boss - dummmy-boss) (hp-heal dummmy-boss key dummmy-boss) (hp-heal dummmy-boss bell-tower-guard dummmy-boss) (hp-heal dummmy-boss - dummmy-boss) (hp-heal dummmy-boss minor-enemy dummmy-boss) (hp-heal dummmy-boss dummmy-boss dummmy-boss)
    (hp-heal - (:objects location) (hp-heal - firelink key-bell) (hp-heal - parish -) (hp-heal - bell-tower key) (hp-heal - - bell-tower-guard) (hp-heal - location -) (hp-heal - key-bell minor-enemy) (hp-heal - - dummmy-boss) (hp-heal - key -) (hp-heal - bell-tower-guard -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - dummmy-boss -) (hp-heal - - -)
    (hp-heal boss (:objects location) (hp-heal boss firelink key-bell) (hp-heal boss parish -) (hp-heal boss bell-tower key) (hp-heal boss - bell-tower-guard) (hp-heal boss location -) (hp-heal boss key-bell minor-enemy) (hp-heal boss - dummmy-boss) (hp-heal boss key -) (hp-heal boss bell-tower-guard boss) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss dummmy-boss boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects location) (hp-heal hp0 firelink key-bell) (hp-heal hp0 parish -) (hp-heal hp0 bell-tower key) (hp-heal hp0 - bell-tower-guard) (hp-heal hp0 location -) (hp-heal hp0 key-bell minor-enemy) (hp-heal hp0 - dummmy-boss) (hp-heal hp0 key -) (hp-heal hp0 bell-tower-guard boss) (hp-heal hp0 - hp0) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 dummmy-boss hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects location) (hp-heal hp1 firelink key-bell) (hp-heal hp1 parish -) (hp-heal hp1 bell-tower key) (hp-heal hp1 - bell-tower-guard) (hp-heal hp1 location -) (hp-heal hp1 key-bell minor-enemy) (hp-heal hp1 - dummmy-boss) (hp-heal hp1 key -) (hp-heal hp1 bell-tower-guard boss) (hp-heal hp1 - hp0) (hp-heal hp1 minor-enemy hp1) (hp-heal hp1 dummmy-boss hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects location) (hp-heal hp2 firelink key-bell) (hp-heal hp2 parish -) (hp-heal hp2 bell-tower key) (hp-heal hp2 - bell-tower-guard) (hp-heal hp2 location -) (hp-heal hp2 key-bell minor-enemy) (hp-heal hp2 - dummmy-boss) (hp-heal hp2 key -) (hp-heal hp2 bell-tower-guard boss) (hp-heal hp2 - hp0) (hp-heal hp2 minor-enemy hp1) (hp-heal hp2 dummmy-boss hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects location) (hp-heal hp3 firelink key-bell) (hp-heal hp3 parish -) (hp-heal hp3 bell-tower key) (hp-heal hp3 - bell-tower-guard) (hp-heal hp3 location -) (hp-heal hp3 key-bell minor-enemy) (hp-heal hp3 - dummmy-boss) (hp-heal hp3 key -) (hp-heal hp3 bell-tower-guard boss) (hp-heal hp3 - hp0) (hp-heal hp3 minor-enemy hp1) (hp-heal hp3 dummmy-boss hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
    ;; hp ordering (<=)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1)
    (player-weapon-level w0)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase dummmy-boss bp2)
    (boss-current-phase dummmy-boss bp2)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack bell-tower-guard hp3 hp2)
    (hp-after-attack bell-tower-guard hp2 hp1)
    (hp-after-attack bell-tower-guard hp1 hp0)
    (hp-after-attack dummmy-boss hp3 hp2)
    (hp-after-attack dummmy-boss hp2 hp1)
    (hp-after-attack dummmy-boss hp1 hp0)

    ;; souls gain from minor enemies ( Max s9)  
    (soul-after-drop mob1 s0 s1) (soul-after-drop mob1 s1 s2) (soul-after-drop mob1 s2 s3)
    (soul-after-drop mob1 s3 s4) (soul-after-drop mob1 s4 s5) (soul-after-drop mob1 s5 s6)
    (soul-after-drop mob1 s6 s7) (soul-after-drop mob1 s7 s8) (soul-after-drop mob1 s8 s9)
    (soul-after-drop mob1 s9 s9)

    (soul-after-drop mob2 s0 s1) (soul-after-drop mob2 s1 s2) (soul-after-drop mob2 s2 s3)
    (soul-after-drop mob2 s3 s4) (soul-after-drop mob2 s4 s5) (soul-after-drop mob2 s5 s6)
    (soul-after-drop mob2 s6 s7) (soul-after-drop mob2 s7 s8) (soul-after-drop mob2 s8 s9)
    (soul-after-drop mob2 s9 s9)
    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss dummmy-boss w0)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (locked parish bell-tower))
))
    (:metric minimize (total-cost))
)

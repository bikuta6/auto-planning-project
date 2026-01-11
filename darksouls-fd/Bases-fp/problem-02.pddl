(define (problem p02-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink burg-square gargoyle-rooftop - location
    dummy-key - key
    mob1 mob2 - minor-enemy
    gargoyle1 gargoyle2 - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 e4 e5 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink burg-square)
    (connected burg-square firelink)
    (connected burg-square gargoyle-rooftop)
    (connected gargoyle-rooftop burg-square)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire burg-square)
    (is-blacksmith firelink)
    (enemy-at mob1 burg-square)
    (enemy-at mob2 burg-square)
    (enemy-at gargoyle1 gargoyle-rooftop)
    (enemy-at gargoyle2 gargoyle-rooftop)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive gargoyle1)
    (is-alive gargoyle2)
    (has-active-boss gargoyle-rooftop)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal burg-square (:objects burg-square) (hp-heal burg-square firelink burg-square) (hp-heal burg-square burg-square burg-square)
    (hp-heal gargoyle-rooftop (:objects gargoyle-rooftop) (hp-heal gargoyle-rooftop firelink gargoyle-rooftop) (hp-heal gargoyle-rooftop burg-square gargoyle-rooftop) (hp-heal gargoyle-rooftop gargoyle-rooftop gargoyle-rooftop)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - burg-square -) (hp-heal - gargoyle-rooftop -) (hp-heal - - -)
    (hp-heal location (:objects location) (hp-heal location firelink location) (hp-heal location burg-square location) (hp-heal location gargoyle-rooftop location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal dummy-key (:objects location) (hp-heal dummy-key firelink dummy-key) (hp-heal dummy-key burg-square dummy-key) (hp-heal dummy-key gargoyle-rooftop dummy-key) (hp-heal dummy-key - dummy-key) (hp-heal dummy-key location dummy-key) (hp-heal dummy-key dummy-key dummy-key)
    (hp-heal - (:objects location) (hp-heal - firelink dummy-key) (hp-heal - burg-square -) (hp-heal - gargoyle-rooftop -) (hp-heal - - -) (hp-heal - location -) (hp-heal - dummy-key -) (hp-heal - - -)
    (hp-heal key (:objects location) (hp-heal key firelink dummy-key) (hp-heal key burg-square -) (hp-heal key gargoyle-rooftop key) (hp-heal key - key) (hp-heal key location key) (hp-heal key dummy-key key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal mob1 (:objects location) (hp-heal mob1 firelink dummy-key) (hp-heal mob1 burg-square -) (hp-heal mob1 gargoyle-rooftop key) (hp-heal mob1 - mob1) (hp-heal mob1 location mob1) (hp-heal mob1 dummy-key mob1) (hp-heal mob1 - mob1) (hp-heal mob1 key mob1) (hp-heal mob1 mob1 mob1)
    (hp-heal mob2 (:objects location) (hp-heal mob2 firelink dummy-key) (hp-heal mob2 burg-square -) (hp-heal mob2 gargoyle-rooftop key) (hp-heal mob2 - mob1) (hp-heal mob2 location mob2) (hp-heal mob2 dummy-key mob2) (hp-heal mob2 - mob2) (hp-heal mob2 key mob2) (hp-heal mob2 mob1 mob2) (hp-heal mob2 mob2 mob2)
    (hp-heal - (:objects location) (hp-heal - firelink dummy-key) (hp-heal - burg-square -) (hp-heal - gargoyle-rooftop key) (hp-heal - - mob1) (hp-heal - location mob2) (hp-heal - dummy-key -) (hp-heal - - -) (hp-heal - key -) (hp-heal - mob1 -) (hp-heal - mob2 -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects location) (hp-heal minor-enemy firelink dummy-key) (hp-heal minor-enemy burg-square -) (hp-heal minor-enemy gargoyle-rooftop key) (hp-heal minor-enemy - mob1) (hp-heal minor-enemy location mob2) (hp-heal minor-enemy dummy-key -) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy mob1 minor-enemy) (hp-heal minor-enemy mob2 minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal gargoyle1 (:objects location) (hp-heal gargoyle1 firelink dummy-key) (hp-heal gargoyle1 burg-square -) (hp-heal gargoyle1 gargoyle-rooftop key) (hp-heal gargoyle1 - mob1) (hp-heal gargoyle1 location mob2) (hp-heal gargoyle1 dummy-key -) (hp-heal gargoyle1 - minor-enemy) (hp-heal gargoyle1 key gargoyle1) (hp-heal gargoyle1 mob1 gargoyle1) (hp-heal gargoyle1 mob2 gargoyle1) (hp-heal gargoyle1 - gargoyle1) (hp-heal gargoyle1 minor-enemy gargoyle1) (hp-heal gargoyle1 gargoyle1 gargoyle1)
    (hp-heal gargoyle2 (:objects location) (hp-heal gargoyle2 firelink dummy-key) (hp-heal gargoyle2 burg-square -) (hp-heal gargoyle2 gargoyle-rooftop key) (hp-heal gargoyle2 - mob1) (hp-heal gargoyle2 location mob2) (hp-heal gargoyle2 dummy-key -) (hp-heal gargoyle2 - minor-enemy) (hp-heal gargoyle2 key gargoyle1) (hp-heal gargoyle2 mob1 gargoyle2) (hp-heal gargoyle2 mob2 gargoyle2) (hp-heal gargoyle2 - gargoyle2) (hp-heal gargoyle2 minor-enemy gargoyle2) (hp-heal gargoyle2 gargoyle1 gargoyle2) (hp-heal gargoyle2 gargoyle2 gargoyle2)
    (hp-heal - (:objects location) (hp-heal - firelink dummy-key) (hp-heal - burg-square -) (hp-heal - gargoyle-rooftop key) (hp-heal - - mob1) (hp-heal - location mob2) (hp-heal - dummy-key -) (hp-heal - - minor-enemy) (hp-heal - key gargoyle1) (hp-heal - mob1 gargoyle2) (hp-heal - mob2 -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - gargoyle1 -) (hp-heal - gargoyle2 -) (hp-heal - - -)
    (hp-heal boss (:objects location) (hp-heal boss firelink dummy-key) (hp-heal boss burg-square -) (hp-heal boss gargoyle-rooftop key) (hp-heal boss - mob1) (hp-heal boss location mob2) (hp-heal boss dummy-key -) (hp-heal boss - minor-enemy) (hp-heal boss key gargoyle1) (hp-heal boss mob1 gargoyle2) (hp-heal boss mob2 -) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss gargoyle1 boss) (hp-heal boss gargoyle2 boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects location) (hp-heal hp0 firelink dummy-key) (hp-heal hp0 burg-square -) (hp-heal hp0 gargoyle-rooftop key) (hp-heal hp0 - mob1) (hp-heal hp0 location mob2) (hp-heal hp0 dummy-key -) (hp-heal hp0 - minor-enemy) (hp-heal hp0 key gargoyle1) (hp-heal hp0 mob1 gargoyle2) (hp-heal hp0 mob2 -) (hp-heal hp0 - boss) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 gargoyle1 hp0) (hp-heal hp0 gargoyle2 hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects location) (hp-heal hp1 firelink dummy-key) (hp-heal hp1 burg-square -) (hp-heal hp1 gargoyle-rooftop key) (hp-heal hp1 - mob1) (hp-heal hp1 location mob2) (hp-heal hp1 dummy-key -) (hp-heal hp1 - minor-enemy) (hp-heal hp1 key gargoyle1) (hp-heal hp1 mob1 gargoyle2) (hp-heal hp1 mob2 -) (hp-heal hp1 - boss) (hp-heal hp1 minor-enemy hp0) (hp-heal hp1 gargoyle1 hp1) (hp-heal hp1 gargoyle2 hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects location) (hp-heal hp2 firelink dummy-key) (hp-heal hp2 burg-square -) (hp-heal hp2 gargoyle-rooftop key) (hp-heal hp2 - mob1) (hp-heal hp2 location mob2) (hp-heal hp2 dummy-key -) (hp-heal hp2 - minor-enemy) (hp-heal hp2 key gargoyle1) (hp-heal hp2 mob1 gargoyle2) (hp-heal hp2 mob2 -) (hp-heal hp2 - boss) (hp-heal hp2 minor-enemy hp0) (hp-heal hp2 gargoyle1 hp1) (hp-heal hp2 gargoyle2 hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects location) (hp-heal hp3 firelink dummy-key) (hp-heal hp3 burg-square -) (hp-heal hp3 gargoyle-rooftop key) (hp-heal hp3 - mob1) (hp-heal hp3 location mob2) (hp-heal hp3 dummy-key -) (hp-heal hp3 - minor-enemy) (hp-heal hp3 key gargoyle1) (hp-heal hp3 mob1 gargoyle2) (hp-heal hp3 mob2 -) (hp-heal hp3 - boss) (hp-heal hp3 minor-enemy hp0) (hp-heal hp3 gargoyle1 hp1) (hp-heal hp3 gargoyle2 hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
    ;; hp ordering (<=)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1) (player-level-next pl1 pl2) (player-level-next pl2 pl3) (player-level-next pl3 pl4) (player-level-next pl4 pl5)

    (player-weapon-level w0)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6) (soul-next s6 s7) (soul-next s7 s8) (soul-next s8 s9)
    (player-max-souls s9)
    (soul-min s0)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase gargoyle1 bp2)
    (boss-current-phase gargoyle1 bp2)
    (boss-max-phase gargoyle2 bp2)
    (boss-current-phase gargoyle2 bp2)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack gargoyle1 hp3 hp2)
    (hp-after-attack gargoyle1 hp2 hp1)
    (hp-after-attack gargoyle1 hp1 hp0)
    (hp-after-attack gargoyle2 hp3 hp2)
    (hp-after-attack gargoyle2 hp2 hp1)
    (hp-after-attack gargoyle2 hp1 hp0)
    (hp-after-attack mob1 hp3 hp2)
    (hp-after-attack mob1 hp2 hp1)
    (hp-after-attack mob1 hp1 hp0)
    (hp-after-attack mob2 hp3 hp2)
    (hp-after-attack mob2 hp2 hp1)
    (hp-after-attack mob2 hp1 hp0)

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
    ;; =========================================================
    ;; soul-spend-for-level: pl0->pl1 cuesta 1
    ;; (requiere tener al menos s1)
    ;; =========================================================
    (soul-spend-for-level pl0 pl1 s1 s0)
    (soul-spend-for-level pl0 pl1 s2 s1)
    (soul-spend-for-level pl0 pl1 s3 s2)
    (soul-spend-for-level pl0 pl1 s4 s3)
    (soul-spend-for-level pl0 pl1 s5 s4)
    (soul-spend-for-level pl0 pl1 s6 s5)
    (soul-spend-for-level pl0 pl1 s7 s6)
    (soul-spend-for-level pl0 pl1 s8 s7)
    (soul-spend-for-level pl0 pl1 s9 s8)

    ;; =========================================================
    ;; pl1->pl2 cuesta 2 (requiere al menos s2)
    ;; =========================================================
    (soul-spend-for-level pl1 pl2 s2 s0)
    (soul-spend-for-level pl1 pl2 s3 s1)
    (soul-spend-for-level pl1 pl2 s4 s2)
    (soul-spend-for-level pl1 pl2 s5 s3)
    (soul-spend-for-level pl1 pl2 s6 s4)
    (soul-spend-for-level pl1 pl2 s7 s5)
    (soul-spend-for-level pl1 pl2 s8 s6)
    (soul-spend-for-level pl1 pl2 s9 s7)

    ;; =========================================================
    ;; pl2->pl3 cuesta 4 (requiere al menos s4)
    ;; =========================================================
    (soul-spend-for-level pl2 pl3 s4 s0)
    (soul-spend-for-level pl2 pl3 s5 s1)
    (soul-spend-for-level pl2 pl3 s6 s2)
    (soul-spend-for-level pl2 pl3 s7 s3)
    (soul-spend-for-level pl2 pl3 s8 s4)
    (soul-spend-for-level pl2 pl3 s9 s5)

    ;; =========================================================
    ;; pl3->pl4 cuesta 6 (requiere al menos s6)
    ;; =========================================================
    (soul-spend-for-level pl3 pl4 s6 s0)
    (soul-spend-for-level pl3 pl4 s7 s1)
    (soul-spend-for-level pl3 pl4 s8 s2)
    (soul-spend-for-level pl3 pl4 s9 s3)

    ;; =========================================================
    ;; pl4->pl5 cuesta 9 (requiere s9 exacto, en este rango)
    ;; =========================================================
    (soul-spend-for-level pl4 pl5 s9 s0)


    ;; boss weapon requirements
    (can-damage-boss gargoyle1 w0)
    (can-damage-boss gargoyle2 w0)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul gargoyle1)
    (deposited-soul gargoyle2)
  ))
  (:metric minimize (total-cost))
)

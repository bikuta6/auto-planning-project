(define (problem p08-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink valley gatehouse inner-valley - location
    key-valley key-gate - key
    mob1 mob2 mob3 - minor-enemy
    dummy-boss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink valley)
    (connected valley firelink)
    (connected valley gatehouse)
    (connected gatehouse valley)
    (connected gatehouse inner-valley)
    (connected inner-valley gatehouse)
    (locked gatehouse inner-valley)
    (locked inner-valley gatehouse)
    (key-at key-valley valley)
    (matches key-valley gatehouse inner-valley)
    (can-open-shortcut firelink valley)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire gatehouse)
    (is-blacksmith firelink)
    (enemy-at mob1 valley)
    (enemy-at mob2 gatehouse)
    (enemy-at mob3 inner-valley)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal valley (:objects valley) (hp-heal valley firelink valley) (hp-heal valley valley valley)
    (hp-heal gatehouse (:objects gatehouse) (hp-heal gatehouse firelink gatehouse) (hp-heal gatehouse valley gatehouse) (hp-heal gatehouse gatehouse gatehouse)
    (hp-heal inner-valley (:objects inner-valley) (hp-heal inner-valley firelink inner-valley) (hp-heal inner-valley valley inner-valley) (hp-heal inner-valley gatehouse inner-valley) (hp-heal inner-valley inner-valley inner-valley)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - valley -) (hp-heal - gatehouse -) (hp-heal - inner-valley -) (hp-heal - - -)
    (hp-heal location (:objects -) (hp-heal location firelink location) (hp-heal location valley location) (hp-heal location gatehouse location) (hp-heal location inner-valley location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal key-valley (:objects -) (hp-heal key-valley firelink location) (hp-heal key-valley valley key-valley) (hp-heal key-valley gatehouse key-valley) (hp-heal key-valley inner-valley key-valley) (hp-heal key-valley - key-valley) (hp-heal key-valley location key-valley) (hp-heal key-valley key-valley key-valley)
    (hp-heal key-gate (:objects -) (hp-heal key-gate firelink location) (hp-heal key-gate valley key-valley) (hp-heal key-gate gatehouse key-gate) (hp-heal key-gate inner-valley key-gate) (hp-heal key-gate - key-gate) (hp-heal key-gate location key-gate) (hp-heal key-gate key-valley key-gate) (hp-heal key-gate key-gate key-gate)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - valley key-valley) (hp-heal - gatehouse key-gate) (hp-heal - inner-valley -) (hp-heal - - -) (hp-heal - location -) (hp-heal - key-valley -) (hp-heal - key-gate -) (hp-heal - - -)
    (hp-heal key (:objects -) (hp-heal key firelink location) (hp-heal key valley key-valley) (hp-heal key gatehouse key-gate) (hp-heal key inner-valley -) (hp-heal key - key) (hp-heal key location key) (hp-heal key key-valley key) (hp-heal key key-gate key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal mob1 (:objects -) (hp-heal mob1 firelink location) (hp-heal mob1 valley key-valley) (hp-heal mob1 gatehouse key-gate) (hp-heal mob1 inner-valley -) (hp-heal mob1 - key) (hp-heal mob1 location mob1) (hp-heal mob1 key-valley mob1) (hp-heal mob1 key-gate mob1) (hp-heal mob1 - mob1) (hp-heal mob1 key mob1) (hp-heal mob1 mob1 mob1)
    (hp-heal mob2 (:objects -) (hp-heal mob2 firelink location) (hp-heal mob2 valley key-valley) (hp-heal mob2 gatehouse key-gate) (hp-heal mob2 inner-valley -) (hp-heal mob2 - key) (hp-heal mob2 location mob1) (hp-heal mob2 key-valley mob2) (hp-heal mob2 key-gate mob2) (hp-heal mob2 - mob2) (hp-heal mob2 key mob2) (hp-heal mob2 mob1 mob2) (hp-heal mob2 mob2 mob2)
    (hp-heal mob3 (:objects -) (hp-heal mob3 firelink location) (hp-heal mob3 valley key-valley) (hp-heal mob3 gatehouse key-gate) (hp-heal mob3 inner-valley -) (hp-heal mob3 - key) (hp-heal mob3 location mob1) (hp-heal mob3 key-valley mob2) (hp-heal mob3 key-gate mob3) (hp-heal mob3 - mob3) (hp-heal mob3 key mob3) (hp-heal mob3 mob1 mob3) (hp-heal mob3 mob2 mob3) (hp-heal mob3 mob3 mob3)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - valley key-valley) (hp-heal - gatehouse key-gate) (hp-heal - inner-valley -) (hp-heal - - key) (hp-heal - location mob1) (hp-heal - key-valley mob2) (hp-heal - key-gate mob3) (hp-heal - - -) (hp-heal - key -) (hp-heal - mob1 -) (hp-heal - mob2 -) (hp-heal - mob3 -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects -) (hp-heal minor-enemy firelink location) (hp-heal minor-enemy valley key-valley) (hp-heal minor-enemy gatehouse key-gate) (hp-heal minor-enemy inner-valley -) (hp-heal minor-enemy - key) (hp-heal minor-enemy location mob1) (hp-heal minor-enemy key-valley mob2) (hp-heal minor-enemy key-gate mob3) (hp-heal minor-enemy - -) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy mob1 minor-enemy) (hp-heal minor-enemy mob2 minor-enemy) (hp-heal minor-enemy mob3 minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal dummy-boss (:objects -) (hp-heal dummy-boss firelink location) (hp-heal dummy-boss valley key-valley) (hp-heal dummy-boss gatehouse key-gate) (hp-heal dummy-boss inner-valley -) (hp-heal dummy-boss - key) (hp-heal dummy-boss location mob1) (hp-heal dummy-boss key-valley mob2) (hp-heal dummy-boss key-gate mob3) (hp-heal dummy-boss - -) (hp-heal dummy-boss key minor-enemy) (hp-heal dummy-boss mob1 dummy-boss) (hp-heal dummy-boss mob2 dummy-boss) (hp-heal dummy-boss mob3 dummy-boss) (hp-heal dummy-boss - dummy-boss) (hp-heal dummy-boss minor-enemy dummy-boss) (hp-heal dummy-boss dummy-boss dummy-boss)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - valley key-valley) (hp-heal - gatehouse key-gate) (hp-heal - inner-valley -) (hp-heal - - key) (hp-heal - location mob1) (hp-heal - key-valley mob2) (hp-heal - key-gate mob3) (hp-heal - - -) (hp-heal - key minor-enemy) (hp-heal - mob1 dummy-boss) (hp-heal - mob2 -) (hp-heal - mob3 -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - dummy-boss -) (hp-heal - - -)
    (hp-heal boss (:objects -) (hp-heal boss firelink location) (hp-heal boss valley key-valley) (hp-heal boss gatehouse key-gate) (hp-heal boss inner-valley -) (hp-heal boss - key) (hp-heal boss location mob1) (hp-heal boss key-valley mob2) (hp-heal boss key-gate mob3) (hp-heal boss - -) (hp-heal boss key minor-enemy) (hp-heal boss mob1 dummy-boss) (hp-heal boss mob2 -) (hp-heal boss mob3 boss) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss dummy-boss boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects -) (hp-heal hp0 firelink location) (hp-heal hp0 valley key-valley) (hp-heal hp0 gatehouse key-gate) (hp-heal hp0 inner-valley -) (hp-heal hp0 - key) (hp-heal hp0 location mob1) (hp-heal hp0 key-valley mob2) (hp-heal hp0 key-gate mob3) (hp-heal hp0 - -) (hp-heal hp0 key minor-enemy) (hp-heal hp0 mob1 dummy-boss) (hp-heal hp0 mob2 -) (hp-heal hp0 mob3 boss) (hp-heal hp0 - hp0) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 dummy-boss hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects -) (hp-heal hp1 firelink location) (hp-heal hp1 valley key-valley) (hp-heal hp1 gatehouse key-gate) (hp-heal hp1 inner-valley -) (hp-heal hp1 - key) (hp-heal hp1 location mob1) (hp-heal hp1 key-valley mob2) (hp-heal hp1 key-gate mob3) (hp-heal hp1 - -) (hp-heal hp1 key minor-enemy) (hp-heal hp1 mob1 dummy-boss) (hp-heal hp1 mob2 -) (hp-heal hp1 mob3 boss) (hp-heal hp1 - hp0) (hp-heal hp1 minor-enemy hp1) (hp-heal hp1 dummy-boss hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects -) (hp-heal hp2 firelink location) (hp-heal hp2 valley key-valley) (hp-heal hp2 gatehouse key-gate) (hp-heal hp2 inner-valley -) (hp-heal hp2 - key) (hp-heal hp2 location mob1) (hp-heal hp2 key-valley mob2) (hp-heal hp2 key-gate mob3) (hp-heal hp2 - -) (hp-heal hp2 key minor-enemy) (hp-heal hp2 mob1 dummy-boss) (hp-heal hp2 mob2 -) (hp-heal hp2 mob3 boss) (hp-heal hp2 - hp0) (hp-heal hp2 minor-enemy hp1) (hp-heal hp2 dummy-boss hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects -) (hp-heal hp3 firelink location) (hp-heal hp3 valley key-valley) (hp-heal hp3 gatehouse key-gate) (hp-heal hp3 inner-valley -) (hp-heal hp3 - key) (hp-heal hp3 location mob1) (hp-heal hp3 key-valley mob2) (hp-heal hp3 key-gate mob3) (hp-heal hp3 - -) (hp-heal hp3 key minor-enemy) (hp-heal hp3 mob1 dummy-boss) (hp-heal hp3 mob2 -) (hp-heal hp3 mob3 boss) (hp-heal hp3 - hp0) (hp-heal hp3 minor-enemy hp1) (hp-heal hp3 dummy-boss hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
    ;; hp ordering (<=)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1)
    (player-weapon-level w1)
    (wlevel-next w0 w1)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase dummy-boss bp2)
    (boss-current-phase dummy-boss bp2)
    (estus-unlocked e1)
    (estus-full e1)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack dummy-boss hp3 hp2)
    (hp-after-attack dummy-boss hp2 hp1)
    (hp-after-attack dummy-boss hp1 hp0)
    (hp-after-attack mob1 hp3 hp2)
    (hp-after-attack mob1 hp2 hp1)
    (hp-after-attack mob1 hp1 hp0)
    (hp-after-attack mob2 hp3 hp2)
    (hp-after-attack mob2 hp2 hp1)
    (hp-after-attack mob2 hp1 hp0)
    (hp-after-attack mob3 hp3 hp2)
    (hp-after-attack mob3 hp2 hp1)
    (hp-after-attack mob3 hp1 hp0)

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

    ;; boss weapon requirements
    (can-damage-boss dummy-boss w0)
    (can-damage-boss dummy-boss w1)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (locked gatehouse inner-valley))
    (at-player inner-valley)
  ))
    (:metric minimize (total-cost))
)

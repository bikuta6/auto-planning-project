(define (problem p10-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink long-road mid-camp boss-lair - location
    dummmy-key - key
    mob1 mob2 mob3 - minor-enemy
    lair-boss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink long-road)
    (connected long-road firelink)
    (connected long-road mid-camp)
    (connected mid-camp long-road)
    (connected mid-camp boss-lair)
    (connected boss-lair mid-camp)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire mid-camp)
    (is-blacksmith firelink)
    (enemy-at mob1 long-road)
    (enemy-at mob2 mid-camp)
    (enemy-at mob3 mid-camp)
    (enemy-at lair-boss boss-lair)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)
    (is-alive lair-boss)
    (has-active-boss boss-lair)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal long-road (:objects long-road) (hp-heal long-road firelink long-road) (hp-heal long-road long-road long-road)
    (hp-heal mid-camp (:objects mid-camp) (hp-heal mid-camp firelink mid-camp) (hp-heal mid-camp long-road mid-camp) (hp-heal mid-camp mid-camp mid-camp)
    (hp-heal boss-lair (:objects boss-lair) (hp-heal boss-lair firelink boss-lair) (hp-heal boss-lair long-road boss-lair) (hp-heal boss-lair mid-camp boss-lair) (hp-heal boss-lair boss-lair boss-lair)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - long-road -) (hp-heal - mid-camp -) (hp-heal - boss-lair -) (hp-heal - - -)
    (hp-heal location (:objects -) (hp-heal location firelink location) (hp-heal location long-road location) (hp-heal location mid-camp location) (hp-heal location boss-lair location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal dummmy-key (:objects -) (hp-heal dummmy-key firelink location) (hp-heal dummmy-key long-road dummmy-key) (hp-heal dummmy-key mid-camp dummmy-key) (hp-heal dummmy-key boss-lair dummmy-key) (hp-heal dummmy-key - dummmy-key) (hp-heal dummmy-key location dummmy-key) (hp-heal dummmy-key dummmy-key dummmy-key)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - long-road dummmy-key) (hp-heal - mid-camp -) (hp-heal - boss-lair -) (hp-heal - - -) (hp-heal - location -) (hp-heal - dummmy-key -) (hp-heal - - -)
    (hp-heal key (:objects -) (hp-heal key firelink location) (hp-heal key long-road dummmy-key) (hp-heal key mid-camp -) (hp-heal key boss-lair key) (hp-heal key - key) (hp-heal key location key) (hp-heal key dummmy-key key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal mob1 (:objects -) (hp-heal mob1 firelink location) (hp-heal mob1 long-road dummmy-key) (hp-heal mob1 mid-camp -) (hp-heal mob1 boss-lair key) (hp-heal mob1 - mob1) (hp-heal mob1 location mob1) (hp-heal mob1 dummmy-key mob1) (hp-heal mob1 - mob1) (hp-heal mob1 key mob1) (hp-heal mob1 mob1 mob1)
    (hp-heal mob2 (:objects -) (hp-heal mob2 firelink location) (hp-heal mob2 long-road dummmy-key) (hp-heal mob2 mid-camp -) (hp-heal mob2 boss-lair key) (hp-heal mob2 - mob1) (hp-heal mob2 location mob2) (hp-heal mob2 dummmy-key mob2) (hp-heal mob2 - mob2) (hp-heal mob2 key mob2) (hp-heal mob2 mob1 mob2) (hp-heal mob2 mob2 mob2)
    (hp-heal mob3 (:objects -) (hp-heal mob3 firelink location) (hp-heal mob3 long-road dummmy-key) (hp-heal mob3 mid-camp -) (hp-heal mob3 boss-lair key) (hp-heal mob3 - mob1) (hp-heal mob3 location mob2) (hp-heal mob3 dummmy-key mob3) (hp-heal mob3 - mob3) (hp-heal mob3 key mob3) (hp-heal mob3 mob1 mob3) (hp-heal mob3 mob2 mob3) (hp-heal mob3 mob3 mob3)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - long-road dummmy-key) (hp-heal - mid-camp -) (hp-heal - boss-lair key) (hp-heal - - mob1) (hp-heal - location mob2) (hp-heal - dummmy-key mob3) (hp-heal - - -) (hp-heal - key -) (hp-heal - mob1 -) (hp-heal - mob2 -) (hp-heal - mob3 -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects -) (hp-heal minor-enemy firelink location) (hp-heal minor-enemy long-road dummmy-key) (hp-heal minor-enemy mid-camp -) (hp-heal minor-enemy boss-lair key) (hp-heal minor-enemy - mob1) (hp-heal minor-enemy location mob2) (hp-heal minor-enemy dummmy-key mob3) (hp-heal minor-enemy - -) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy mob1 minor-enemy) (hp-heal minor-enemy mob2 minor-enemy) (hp-heal minor-enemy mob3 minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal lair-boss (:objects -) (hp-heal lair-boss firelink location) (hp-heal lair-boss long-road dummmy-key) (hp-heal lair-boss mid-camp -) (hp-heal lair-boss boss-lair key) (hp-heal lair-boss - mob1) (hp-heal lair-boss location mob2) (hp-heal lair-boss dummmy-key mob3) (hp-heal lair-boss - -) (hp-heal lair-boss key minor-enemy) (hp-heal lair-boss mob1 lair-boss) (hp-heal lair-boss mob2 lair-boss) (hp-heal lair-boss mob3 lair-boss) (hp-heal lair-boss - lair-boss) (hp-heal lair-boss minor-enemy lair-boss) (hp-heal lair-boss lair-boss lair-boss)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - long-road dummmy-key) (hp-heal - mid-camp -) (hp-heal - boss-lair key) (hp-heal - - mob1) (hp-heal - location mob2) (hp-heal - dummmy-key mob3) (hp-heal - - -) (hp-heal - key minor-enemy) (hp-heal - mob1 lair-boss) (hp-heal - mob2 -) (hp-heal - mob3 -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - lair-boss -) (hp-heal - - -)
    (hp-heal boss (:objects -) (hp-heal boss firelink location) (hp-heal boss long-road dummmy-key) (hp-heal boss mid-camp -) (hp-heal boss boss-lair key) (hp-heal boss - mob1) (hp-heal boss location mob2) (hp-heal boss dummmy-key mob3) (hp-heal boss - -) (hp-heal boss key minor-enemy) (hp-heal boss mob1 lair-boss) (hp-heal boss mob2 -) (hp-heal boss mob3 boss) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss lair-boss boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects -) (hp-heal hp0 firelink location) (hp-heal hp0 long-road dummmy-key) (hp-heal hp0 mid-camp -) (hp-heal hp0 boss-lair key) (hp-heal hp0 - mob1) (hp-heal hp0 location mob2) (hp-heal hp0 dummmy-key mob3) (hp-heal hp0 - -) (hp-heal hp0 key minor-enemy) (hp-heal hp0 mob1 lair-boss) (hp-heal hp0 mob2 -) (hp-heal hp0 mob3 boss) (hp-heal hp0 - hp0) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 lair-boss hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects -) (hp-heal hp1 firelink location) (hp-heal hp1 long-road dummmy-key) (hp-heal hp1 mid-camp -) (hp-heal hp1 boss-lair key) (hp-heal hp1 - mob1) (hp-heal hp1 location mob2) (hp-heal hp1 dummmy-key mob3) (hp-heal hp1 - -) (hp-heal hp1 key minor-enemy) (hp-heal hp1 mob1 lair-boss) (hp-heal hp1 mob2 -) (hp-heal hp1 mob3 boss) (hp-heal hp1 - hp0) (hp-heal hp1 minor-enemy hp1) (hp-heal hp1 lair-boss hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects -) (hp-heal hp2 firelink location) (hp-heal hp2 long-road dummmy-key) (hp-heal hp2 mid-camp -) (hp-heal hp2 boss-lair key) (hp-heal hp2 - mob1) (hp-heal hp2 location mob2) (hp-heal hp2 dummmy-key mob3) (hp-heal hp2 - -) (hp-heal hp2 key minor-enemy) (hp-heal hp2 mob1 lair-boss) (hp-heal hp2 mob2 -) (hp-heal hp2 mob3 boss) (hp-heal hp2 - hp0) (hp-heal hp2 minor-enemy hp1) (hp-heal hp2 lair-boss hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects -) (hp-heal hp3 firelink location) (hp-heal hp3 long-road dummmy-key) (hp-heal hp3 mid-camp -) (hp-heal hp3 boss-lair key) (hp-heal hp3 - mob1) (hp-heal hp3 location mob2) (hp-heal hp3 dummmy-key mob3) (hp-heal hp3 - -) (hp-heal hp3 key minor-enemy) (hp-heal hp3 mob1 lair-boss) (hp-heal hp3 mob2 -) (hp-heal hp3 mob3 boss) (hp-heal hp3 - hp0) (hp-heal hp3 minor-enemy hp1) (hp-heal hp3 lair-boss hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
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
    (boss-max-phase lair-boss bp2)
    (boss-current-phase lair-boss bp2)
    (estus-unlocked e1)
    (estus-full e1)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack lair-boss hp3 hp2)
    (hp-after-attack lair-boss hp2 hp1)
    (hp-after-attack lair-boss hp1 hp0)
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
    (can-damage-boss lair-boss w1)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (is-alive lair-boss))
    (deposited-soul lair-boss)
  ))
    (:metric minimize (total-cost))
)

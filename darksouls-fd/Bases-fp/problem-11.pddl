(define (problem p11-forced-levelup-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink undead-burg lower-burg boss-arena - location
    gate-key - key
    hollow1 hollow2 - minor-enemy
    taurus-demon - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink undead-burg)
    (connected undead-burg firelink)
    (connected undead-burg lower-burg)
    (connected lower-burg undead-burg)
    (connected lower-burg boss-arena)
    (connected boss-arena lower-burg)
    (locked lower-burg boss-arena)
    (locked boss-arena lower-burg)
    (key-at gate-key undead-burg)
    (matches gate-key lower-burg boss-arena)
    (titanite-at undead-burg)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire undead-burg)
    (is-blacksmith firelink)
    (enemy-at hollow1 undead-burg)
    (enemy-at hollow2 lower-burg)
    (enemy-at taurus-demon boss-arena)
    (is-alive hollow1)
    (is-alive hollow2)
    (is-alive taurus-demon)
    (has-active-boss boss-arena)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal undead-burg (:objects undead-burg) (hp-heal undead-burg firelink undead-burg) (hp-heal undead-burg undead-burg undead-burg)
    (hp-heal lower-burg (:objects lower-burg) (hp-heal lower-burg firelink lower-burg) (hp-heal lower-burg undead-burg lower-burg) (hp-heal lower-burg lower-burg lower-burg)
    (hp-heal boss-arena (:objects boss-arena) (hp-heal boss-arena firelink boss-arena) (hp-heal boss-arena undead-burg boss-arena) (hp-heal boss-arena lower-burg boss-arena) (hp-heal boss-arena boss-arena boss-arena)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - undead-burg -) (hp-heal - lower-burg -) (hp-heal - boss-arena -) (hp-heal - - -)
    (hp-heal location (:objects -) (hp-heal location firelink location) (hp-heal location undead-burg location) (hp-heal location lower-burg location) (hp-heal location boss-arena location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal gate-key (:objects -) (hp-heal gate-key firelink location) (hp-heal gate-key undead-burg gate-key) (hp-heal gate-key lower-burg gate-key) (hp-heal gate-key boss-arena gate-key) (hp-heal gate-key - gate-key) (hp-heal gate-key location gate-key) (hp-heal gate-key gate-key gate-key)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - undead-burg gate-key) (hp-heal - lower-burg -) (hp-heal - boss-arena -) (hp-heal - - -) (hp-heal - location -) (hp-heal - gate-key -) (hp-heal - - -)
    (hp-heal key (:objects -) (hp-heal key firelink location) (hp-heal key undead-burg gate-key) (hp-heal key lower-burg -) (hp-heal key boss-arena key) (hp-heal key - key) (hp-heal key location key) (hp-heal key gate-key key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal hollow1 (:objects -) (hp-heal hollow1 firelink location) (hp-heal hollow1 undead-burg gate-key) (hp-heal hollow1 lower-burg -) (hp-heal hollow1 boss-arena key) (hp-heal hollow1 - hollow1) (hp-heal hollow1 location hollow1) (hp-heal hollow1 gate-key hollow1) (hp-heal hollow1 - hollow1) (hp-heal hollow1 key hollow1) (hp-heal hollow1 hollow1 hollow1)
    (hp-heal hollow2 (:objects -) (hp-heal hollow2 firelink location) (hp-heal hollow2 undead-burg gate-key) (hp-heal hollow2 lower-burg -) (hp-heal hollow2 boss-arena key) (hp-heal hollow2 - hollow1) (hp-heal hollow2 location hollow2) (hp-heal hollow2 gate-key hollow2) (hp-heal hollow2 - hollow2) (hp-heal hollow2 key hollow2) (hp-heal hollow2 hollow1 hollow2) (hp-heal hollow2 hollow2 hollow2)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - undead-burg gate-key) (hp-heal - lower-burg -) (hp-heal - boss-arena key) (hp-heal - - hollow1) (hp-heal - location hollow2) (hp-heal - gate-key -) (hp-heal - - -) (hp-heal - key -) (hp-heal - hollow1 -) (hp-heal - hollow2 -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects -) (hp-heal minor-enemy firelink location) (hp-heal minor-enemy undead-burg gate-key) (hp-heal minor-enemy lower-burg -) (hp-heal minor-enemy boss-arena key) (hp-heal minor-enemy - hollow1) (hp-heal minor-enemy location hollow2) (hp-heal minor-enemy gate-key -) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy hollow1 minor-enemy) (hp-heal minor-enemy hollow2 minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal taurus-demon (:objects -) (hp-heal taurus-demon firelink location) (hp-heal taurus-demon undead-burg gate-key) (hp-heal taurus-demon lower-burg -) (hp-heal taurus-demon boss-arena key) (hp-heal taurus-demon - hollow1) (hp-heal taurus-demon location hollow2) (hp-heal taurus-demon gate-key -) (hp-heal taurus-demon - minor-enemy) (hp-heal taurus-demon key taurus-demon) (hp-heal taurus-demon hollow1 taurus-demon) (hp-heal taurus-demon hollow2 taurus-demon) (hp-heal taurus-demon - taurus-demon) (hp-heal taurus-demon minor-enemy taurus-demon) (hp-heal taurus-demon taurus-demon taurus-demon)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - undead-burg gate-key) (hp-heal - lower-burg -) (hp-heal - boss-arena key) (hp-heal - - hollow1) (hp-heal - location hollow2) (hp-heal - gate-key -) (hp-heal - - minor-enemy) (hp-heal - key taurus-demon) (hp-heal - hollow1 -) (hp-heal - hollow2 -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - taurus-demon -) (hp-heal - - -)
    (hp-heal boss (:objects -) (hp-heal boss firelink location) (hp-heal boss undead-burg gate-key) (hp-heal boss lower-burg -) (hp-heal boss boss-arena key) (hp-heal boss - hollow1) (hp-heal boss location hollow2) (hp-heal boss gate-key -) (hp-heal boss - minor-enemy) (hp-heal boss key taurus-demon) (hp-heal boss hollow1 -) (hp-heal boss hollow2 boss) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss taurus-demon boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects -) (hp-heal hp0 firelink location) (hp-heal hp0 undead-burg gate-key) (hp-heal hp0 lower-burg -) (hp-heal hp0 boss-arena key) (hp-heal hp0 - hollow1) (hp-heal hp0 location hollow2) (hp-heal hp0 gate-key -) (hp-heal hp0 - minor-enemy) (hp-heal hp0 key taurus-demon) (hp-heal hp0 hollow1 -) (hp-heal hp0 hollow2 boss) (hp-heal hp0 - hp0) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 taurus-demon hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects -) (hp-heal hp1 firelink location) (hp-heal hp1 undead-burg gate-key) (hp-heal hp1 lower-burg -) (hp-heal hp1 boss-arena key) (hp-heal hp1 - hollow1) (hp-heal hp1 location hollow2) (hp-heal hp1 gate-key -) (hp-heal hp1 - minor-enemy) (hp-heal hp1 key taurus-demon) (hp-heal hp1 hollow1 -) (hp-heal hp1 hollow2 boss) (hp-heal hp1 - hp0) (hp-heal hp1 minor-enemy hp1) (hp-heal hp1 taurus-demon hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects -) (hp-heal hp2 firelink location) (hp-heal hp2 undead-burg gate-key) (hp-heal hp2 lower-burg -) (hp-heal hp2 boss-arena key) (hp-heal hp2 - hollow1) (hp-heal hp2 location hollow2) (hp-heal hp2 gate-key -) (hp-heal hp2 - minor-enemy) (hp-heal hp2 key taurus-demon) (hp-heal hp2 hollow1 -) (hp-heal hp2 hollow2 boss) (hp-heal hp2 - hp0) (hp-heal hp2 minor-enemy hp1) (hp-heal hp2 taurus-demon hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects -) (hp-heal hp3 firelink location) (hp-heal hp3 undead-burg gate-key) (hp-heal hp3 lower-burg -) (hp-heal hp3 boss-arena key) (hp-heal hp3 - hollow1) (hp-heal hp3 location hollow2) (hp-heal hp3 gate-key -) (hp-heal hp3 - minor-enemy) (hp-heal hp3 key taurus-demon) (hp-heal hp3 hollow1 -) (hp-heal hp3 hollow2 boss) (hp-heal hp3 - hp0) (hp-heal hp3 minor-enemy hp1) (hp-heal hp3 taurus-demon hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
    ;; hp ordering (<=)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1)
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
    (boss-max-phase taurus-demon bp2)
    (boss-current-phase taurus-demon bp2)
    (estus-unlocked e1)
    (estus-full e1)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack hollow1 hp3 hp2)
    (hp-after-attack hollow1 hp2 hp1)
    (hp-after-attack hollow1 hp1 hp0)
    (hp-after-attack hollow2 hp3 hp2)
    (hp-after-attack hollow2 hp2 hp1)
    (hp-after-attack hollow2 hp1 hp0)
    (hp-after-attack taurus-demon hp3 hp2)
    (hp-after-attack taurus-demon hp2 hp1)
    (hp-after-attack taurus-demon hp1 hp0)

    ;; souls gain from minor enemies (saturating at s9)
    (soul-after-drop hollow1 s0 s1) (soul-after-drop hollow1 s1 s2) (soul-after-drop hollow1 s2 s3)
    (soul-after-drop hollow1 s3 s4) (soul-after-drop hollow1 s4 s5) (soul-after-drop hollow1 s5 s6)
    (soul-after-drop hollow1 s6 s7) (soul-after-drop hollow1 s7 s8) (soul-after-drop hollow1 s8 s9)
    (soul-after-drop hollow1 s9 s9)

    (soul-after-drop hollow2 s0 s1) (soul-after-drop hollow2 s1 s2) (soul-after-drop hollow2 s2 s3)
    (soul-after-drop hollow2 s3 s4) (soul-after-drop hollow2 s4 s5) (soul-after-drop hollow2 s5 s6)
    (soul-after-drop hollow2 s6 s7) (soul-after-drop hollow2 s7 s8) (soul-after-drop hollow2 s8 s9)
    (soul-after-drop hollow2 s9 s9)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss taurus-demon w1)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (is-alive taurus-demon))
    (deposited-soul taurus-demon)
  ))
    (:metric minimize (total-cost))
)

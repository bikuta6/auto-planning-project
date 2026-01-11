(define (problem p01-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink undead-burg taurus-arena - location
    dummy-key - key
    dummy-minor-enemy - minor-enemy
    taurus - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 - wlevel
    bp0 bp1 bp2 - boss-phase
    ;; 4 estus paraa poder aumentarlos
    e1 e2 e3 e4 - estus-slot
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink undead-burg)
    (connected undead-burg firelink)
    (connected undead-burg taurus-arena)
    (connected taurus-arena undead-burg)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire undead-burg)
    (is-blacksmith firelink)
    (enemy-at taurus taurus-arena)
    (is-alive taurus)
    (has-active-boss taurus-arena)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal undead-burg (:objects undead-burg) (hp-heal undead-burg firelink undead-burg) (hp-heal undead-burg undead-burg undead-burg)
    (hp-heal taurus-arena (:objects taurus-arena) (hp-heal taurus-arena firelink taurus-arena) (hp-heal taurus-arena undead-burg taurus-arena) (hp-heal taurus-arena taurus-arena taurus-arena)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - undead-burg -) (hp-heal - taurus-arena -) (hp-heal - - -)
    (hp-heal location (:objects location) (hp-heal location firelink location) (hp-heal location undead-burg location) (hp-heal location taurus-arena location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal dummy-key (:objects location) (hp-heal dummy-key firelink dummy-key) (hp-heal dummy-key undead-burg dummy-key) (hp-heal dummy-key taurus-arena dummy-key) (hp-heal dummy-key - dummy-key) (hp-heal dummy-key location dummy-key) (hp-heal dummy-key dummy-key dummy-key)
    (hp-heal - (:objects location) (hp-heal - firelink dummy-key) (hp-heal - undead-burg -) (hp-heal - taurus-arena -) (hp-heal - - -) (hp-heal - location -) (hp-heal - dummy-key -) (hp-heal - - -)
    (hp-heal key (:objects location) (hp-heal key firelink dummy-key) (hp-heal key undead-burg -) (hp-heal key taurus-arena key) (hp-heal key - key) (hp-heal key location key) (hp-heal key dummy-key key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal dummy-minor-enemy (:objects location) (hp-heal dummy-minor-enemy firelink dummy-key) (hp-heal dummy-minor-enemy undead-burg -) (hp-heal dummy-minor-enemy taurus-arena key) (hp-heal dummy-minor-enemy - dummy-minor-enemy) (hp-heal dummy-minor-enemy location dummy-minor-enemy) (hp-heal dummy-minor-enemy dummy-key dummy-minor-enemy) (hp-heal dummy-minor-enemy - dummy-minor-enemy) (hp-heal dummy-minor-enemy key dummy-minor-enemy) (hp-heal dummy-minor-enemy dummy-minor-enemy dummy-minor-enemy)
    (hp-heal - (:objects location) (hp-heal - firelink dummy-key) (hp-heal - undead-burg -) (hp-heal - taurus-arena key) (hp-heal - - dummy-minor-enemy) (hp-heal - location -) (hp-heal - dummy-key -) (hp-heal - - -) (hp-heal - key -) (hp-heal - dummy-minor-enemy -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects location) (hp-heal minor-enemy firelink dummy-key) (hp-heal minor-enemy undead-burg -) (hp-heal minor-enemy taurus-arena key) (hp-heal minor-enemy - dummy-minor-enemy) (hp-heal minor-enemy location -) (hp-heal minor-enemy dummy-key minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy dummy-minor-enemy minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal taurus (:objects location) (hp-heal taurus firelink dummy-key) (hp-heal taurus undead-burg -) (hp-heal taurus taurus-arena key) (hp-heal taurus - dummy-minor-enemy) (hp-heal taurus location -) (hp-heal taurus dummy-key minor-enemy) (hp-heal taurus - taurus) (hp-heal taurus key taurus) (hp-heal taurus dummy-minor-enemy taurus) (hp-heal taurus - taurus) (hp-heal taurus minor-enemy taurus) (hp-heal taurus taurus taurus)
    (hp-heal - (:objects location) (hp-heal - firelink dummy-key) (hp-heal - undead-burg -) (hp-heal - taurus-arena key) (hp-heal - - dummy-minor-enemy) (hp-heal - location -) (hp-heal - dummy-key minor-enemy) (hp-heal - - taurus) (hp-heal - key -) (hp-heal - dummy-minor-enemy -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - taurus -) (hp-heal - - -)
    (hp-heal boss (:objects location) (hp-heal boss firelink dummy-key) (hp-heal boss undead-burg -) (hp-heal boss taurus-arena key) (hp-heal boss - dummy-minor-enemy) (hp-heal boss location -) (hp-heal boss dummy-key minor-enemy) (hp-heal boss - taurus) (hp-heal boss key -) (hp-heal boss dummy-minor-enemy boss) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss taurus boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects location) (hp-heal hp0 firelink dummy-key) (hp-heal hp0 undead-burg -) (hp-heal hp0 taurus-arena key) (hp-heal hp0 - dummy-minor-enemy) (hp-heal hp0 location -) (hp-heal hp0 dummy-key minor-enemy) (hp-heal hp0 - taurus) (hp-heal hp0 key -) (hp-heal hp0 dummy-minor-enemy boss) (hp-heal hp0 - hp0) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 taurus hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects location) (hp-heal hp1 firelink dummy-key) (hp-heal hp1 undead-burg -) (hp-heal hp1 taurus-arena key) (hp-heal hp1 - dummy-minor-enemy) (hp-heal hp1 location -) (hp-heal hp1 dummy-key minor-enemy) (hp-heal hp1 - taurus) (hp-heal hp1 key -) (hp-heal hp1 dummy-minor-enemy boss) (hp-heal hp1 - hp0) (hp-heal hp1 minor-enemy hp1) (hp-heal hp1 taurus hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects location) (hp-heal hp2 firelink dummy-key) (hp-heal hp2 undead-burg -) (hp-heal hp2 taurus-arena key) (hp-heal hp2 - dummy-minor-enemy) (hp-heal hp2 location -) (hp-heal hp2 dummy-key minor-enemy) (hp-heal hp2 - taurus) (hp-heal hp2 key -) (hp-heal hp2 dummy-minor-enemy boss) (hp-heal hp2 - hp0) (hp-heal hp2 minor-enemy hp1) (hp-heal hp2 taurus hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects location) (hp-heal hp3 firelink dummy-key) (hp-heal hp3 undead-burg -) (hp-heal hp3 taurus-arena key) (hp-heal hp3 - dummy-minor-enemy) (hp-heal hp3 location -) (hp-heal hp3 dummy-key minor-enemy) (hp-heal hp3 - taurus) (hp-heal hp3 key -) (hp-heal hp3 dummy-minor-enemy boss) (hp-heal hp3 - hp0) (hp-heal hp3 minor-enemy hp1) (hp-heal hp3 taurus hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
    ;; hp ordering (<=)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1)
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
    (boss-max-phase taurus bp2)
    (boss-current-phase taurus bp2)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack dummy-minor-enemy hp3 hp2)
    (hp-after-attack dummy-minor-enemy hp2 hp1)
    (hp-after-attack dummy-minor-enemy hp1 hp0)
    (hp-after-attack taurus hp3 hp2)
    (hp-after-attack taurus hp2 hp1)
    (hp-after-attack taurus hp1 hp0)

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
    (can-damage-boss taurus w0)

    ;;Discreetizacion
    (soul-min s0)
    
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul taurus)
  ))
  (:metric minimize (total-cost))
)

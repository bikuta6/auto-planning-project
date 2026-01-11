(define (problem p04-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink depths sewer-entrance depths-boss-arena titanite-node - location
    titanite1 - key
    dummy-minor-enemy - minor-enemy
    mini-boss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink sewer-entrance)
    (connected sewer-entrance firelink)
    (connected sewer-entrance depths)
    (connected depths sewer-entrance)
    (connected depths depths-boss-arena)
    (connected depths-boss-arena depths)
    (titanite-at sewer-entrance)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire depths)
    (is-blacksmith firelink)
    (enemy-at mini-boss depths-boss-arena)
    (is-alive mini-boss)
    (has-active-boss depths-boss-arena)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal depths (:objects depths) (hp-heal depths firelink depths) (hp-heal depths depths depths)
    (hp-heal sewer-entrance (:objects sewer-entrance) (hp-heal sewer-entrance firelink sewer-entrance) (hp-heal sewer-entrance depths sewer-entrance) (hp-heal sewer-entrance sewer-entrance sewer-entrance)
    (hp-heal depths-boss-arena (:objects depths-boss-arena) (hp-heal depths-boss-arena firelink depths-boss-arena) (hp-heal depths-boss-arena depths depths-boss-arena) (hp-heal depths-boss-arena sewer-entrance depths-boss-arena) (hp-heal depths-boss-arena depths-boss-arena depths-boss-arena)
    (hp-heal titanite-node (:objects titanite-node) (hp-heal titanite-node firelink titanite-node) (hp-heal titanite-node depths titanite-node) (hp-heal titanite-node sewer-entrance titanite-node) (hp-heal titanite-node depths-boss-arena titanite-node) (hp-heal titanite-node titanite-node titanite-node)
    (hp-heal - (:objects titanite-node) (hp-heal - firelink -) (hp-heal - depths -) (hp-heal - sewer-entrance -) (hp-heal - depths-boss-arena -) (hp-heal - titanite-node -) (hp-heal - - -)
    (hp-heal location (:objects titanite-node) (hp-heal location firelink -) (hp-heal location depths location) (hp-heal location sewer-entrance location) (hp-heal location depths-boss-arena location) (hp-heal location titanite-node location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal titanite1 (:objects titanite-node) (hp-heal titanite1 firelink -) (hp-heal titanite1 depths location) (hp-heal titanite1 sewer-entrance titanite1) (hp-heal titanite1 depths-boss-arena titanite1) (hp-heal titanite1 titanite-node titanite1) (hp-heal titanite1 - titanite1) (hp-heal titanite1 location titanite1) (hp-heal titanite1 titanite1 titanite1)
    (hp-heal - (:objects titanite-node) (hp-heal - firelink -) (hp-heal - depths location) (hp-heal - sewer-entrance titanite1) (hp-heal - depths-boss-arena -) (hp-heal - titanite-node -) (hp-heal - - -) (hp-heal - location -) (hp-heal - titanite1 -) (hp-heal - - -)
    (hp-heal key (:objects titanite-node) (hp-heal key firelink -) (hp-heal key depths location) (hp-heal key sewer-entrance titanite1) (hp-heal key depths-boss-arena -) (hp-heal key titanite-node key) (hp-heal key - key) (hp-heal key location key) (hp-heal key titanite1 key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal dummy-minor-enemy (:objects titanite-node) (hp-heal dummy-minor-enemy firelink -) (hp-heal dummy-minor-enemy depths location) (hp-heal dummy-minor-enemy sewer-entrance titanite1) (hp-heal dummy-minor-enemy depths-boss-arena -) (hp-heal dummy-minor-enemy titanite-node key) (hp-heal dummy-minor-enemy - dummy-minor-enemy) (hp-heal dummy-minor-enemy location dummy-minor-enemy) (hp-heal dummy-minor-enemy titanite1 dummy-minor-enemy) (hp-heal dummy-minor-enemy - dummy-minor-enemy) (hp-heal dummy-minor-enemy key dummy-minor-enemy) (hp-heal dummy-minor-enemy dummy-minor-enemy dummy-minor-enemy)
    (hp-heal - (:objects titanite-node) (hp-heal - firelink -) (hp-heal - depths location) (hp-heal - sewer-entrance titanite1) (hp-heal - depths-boss-arena -) (hp-heal - titanite-node key) (hp-heal - - dummy-minor-enemy) (hp-heal - location -) (hp-heal - titanite1 -) (hp-heal - - -) (hp-heal - key -) (hp-heal - dummy-minor-enemy -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects titanite-node) (hp-heal minor-enemy firelink -) (hp-heal minor-enemy depths location) (hp-heal minor-enemy sewer-entrance titanite1) (hp-heal minor-enemy depths-boss-arena -) (hp-heal minor-enemy titanite-node key) (hp-heal minor-enemy - dummy-minor-enemy) (hp-heal minor-enemy location -) (hp-heal minor-enemy titanite1 minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy dummy-minor-enemy minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal mini-boss (:objects titanite-node) (hp-heal mini-boss firelink -) (hp-heal mini-boss depths location) (hp-heal mini-boss sewer-entrance titanite1) (hp-heal mini-boss depths-boss-arena -) (hp-heal mini-boss titanite-node key) (hp-heal mini-boss - dummy-minor-enemy) (hp-heal mini-boss location -) (hp-heal mini-boss titanite1 minor-enemy) (hp-heal mini-boss - mini-boss) (hp-heal mini-boss key mini-boss) (hp-heal mini-boss dummy-minor-enemy mini-boss) (hp-heal mini-boss - mini-boss) (hp-heal mini-boss minor-enemy mini-boss) (hp-heal mini-boss mini-boss mini-boss)
    (hp-heal - (:objects titanite-node) (hp-heal - firelink -) (hp-heal - depths location) (hp-heal - sewer-entrance titanite1) (hp-heal - depths-boss-arena -) (hp-heal - titanite-node key) (hp-heal - - dummy-minor-enemy) (hp-heal - location -) (hp-heal - titanite1 minor-enemy) (hp-heal - - mini-boss) (hp-heal - key -) (hp-heal - dummy-minor-enemy -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - mini-boss -) (hp-heal - - -)
    (hp-heal boss (:objects titanite-node) (hp-heal boss firelink -) (hp-heal boss depths location) (hp-heal boss sewer-entrance titanite1) (hp-heal boss depths-boss-arena -) (hp-heal boss titanite-node key) (hp-heal boss - dummy-minor-enemy) (hp-heal boss location -) (hp-heal boss titanite1 minor-enemy) (hp-heal boss - mini-boss) (hp-heal boss key -) (hp-heal boss dummy-minor-enemy boss) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss mini-boss boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects titanite-node) (hp-heal hp0 firelink -) (hp-heal hp0 depths location) (hp-heal hp0 sewer-entrance titanite1) (hp-heal hp0 depths-boss-arena -) (hp-heal hp0 titanite-node key) (hp-heal hp0 - dummy-minor-enemy) (hp-heal hp0 location -) (hp-heal hp0 titanite1 minor-enemy) (hp-heal hp0 - mini-boss) (hp-heal hp0 key -) (hp-heal hp0 dummy-minor-enemy boss) (hp-heal hp0 - hp0) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 mini-boss hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects titanite-node) (hp-heal hp1 firelink -) (hp-heal hp1 depths location) (hp-heal hp1 sewer-entrance titanite1) (hp-heal hp1 depths-boss-arena -) (hp-heal hp1 titanite-node key) (hp-heal hp1 - dummy-minor-enemy) (hp-heal hp1 location -) (hp-heal hp1 titanite1 minor-enemy) (hp-heal hp1 - mini-boss) (hp-heal hp1 key -) (hp-heal hp1 dummy-minor-enemy boss) (hp-heal hp1 - hp0) (hp-heal hp1 minor-enemy hp1) (hp-heal hp1 mini-boss hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects titanite-node) (hp-heal hp2 firelink -) (hp-heal hp2 depths location) (hp-heal hp2 sewer-entrance titanite1) (hp-heal hp2 depths-boss-arena -) (hp-heal hp2 titanite-node key) (hp-heal hp2 - dummy-minor-enemy) (hp-heal hp2 location -) (hp-heal hp2 titanite1 minor-enemy) (hp-heal hp2 - mini-boss) (hp-heal hp2 key -) (hp-heal hp2 dummy-minor-enemy boss) (hp-heal hp2 - hp0) (hp-heal hp2 minor-enemy hp1) (hp-heal hp2 mini-boss hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects titanite-node) (hp-heal hp3 firelink -) (hp-heal hp3 depths location) (hp-heal hp3 sewer-entrance titanite1) (hp-heal hp3 depths-boss-arena -) (hp-heal hp3 titanite-node key) (hp-heal hp3 - dummy-minor-enemy) (hp-heal hp3 location -) (hp-heal hp3 titanite1 minor-enemy) (hp-heal hp3 - mini-boss) (hp-heal hp3 key -) (hp-heal hp3 dummy-minor-enemy boss) (hp-heal hp3 - hp0) (hp-heal hp3 minor-enemy hp1) (hp-heal hp3 mini-boss hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
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
    (boss-max-phase mini-boss bp2)
    (boss-current-phase mini-boss bp2)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack dummy-minor-enemy hp3 hp2)
    (hp-after-attack dummy-minor-enemy hp2 hp1)
    (hp-after-attack dummy-minor-enemy hp1 hp0)
    (hp-after-attack mini-boss hp3 hp2)
    (hp-after-attack mini-boss hp2 hp1)
    (hp-after-attack mini-boss hp1 hp0)

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
    (can-damage-boss mini-boss w1)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul mini-boss)
  ))
  (:metric minimize (total-cost))
)

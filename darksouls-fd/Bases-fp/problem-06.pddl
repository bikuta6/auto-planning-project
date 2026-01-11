(define (problem p06-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink sen-entrance sen-inner anor-entrance - location
    shortcut-key - key
    sen-guard1 sen-guard2 - minor-enemy
    iron-golem - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 w2 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 bp3 bp4 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink sen-entrance)
    (connected sen-entrance firelink)
    (connected sen-entrance sen-inner)
    (connected sen-inner sen-entrance)
    (connected sen-inner anor-entrance)
    (connected anor-entrance sen-inner)
    (locked sen-inner anor-entrance)
    (locked anor-entrance sen-inner)
    (key-at shortcut-key sen-entrance)
    (matches shortcut-key sen-inner anor-entrance)
    (can-open-shortcut sen-entrance sen-inner)
    (titanite-at sen-entrance)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire sen-entrance)
    (is-blacksmith firelink)
    (enemy-at sen-guard1 sen-entrance)
    (enemy-at sen-guard2 sen-inner)
    (enemy-at iron-golem anor-entrance)
    (is-alive sen-guard1)
    (is-alive sen-guard2)
    (is-alive iron-golem)
    (has-active-boss anor-entrance)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal sen-entrance (:objects sen-entrance) (hp-heal sen-entrance firelink sen-entrance) (hp-heal sen-entrance sen-entrance sen-entrance)
    (hp-heal sen-inner (:objects sen-inner) (hp-heal sen-inner firelink sen-inner) (hp-heal sen-inner sen-entrance sen-inner) (hp-heal sen-inner sen-inner sen-inner)
    (hp-heal anor-entrance (:objects anor-entrance) (hp-heal anor-entrance firelink anor-entrance) (hp-heal anor-entrance sen-entrance anor-entrance) (hp-heal anor-entrance sen-inner anor-entrance) (hp-heal anor-entrance anor-entrance anor-entrance)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - sen-entrance -) (hp-heal - sen-inner -) (hp-heal - anor-entrance -) (hp-heal - - -)
    (hp-heal location (:objects -) (hp-heal location firelink location) (hp-heal location sen-entrance location) (hp-heal location sen-inner location) (hp-heal location anor-entrance location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal shortcut-key (:objects -) (hp-heal shortcut-key firelink location) (hp-heal shortcut-key sen-entrance shortcut-key) (hp-heal shortcut-key sen-inner shortcut-key) (hp-heal shortcut-key anor-entrance shortcut-key) (hp-heal shortcut-key - shortcut-key) (hp-heal shortcut-key location shortcut-key) (hp-heal shortcut-key shortcut-key shortcut-key)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - sen-entrance shortcut-key) (hp-heal - sen-inner -) (hp-heal - anor-entrance -) (hp-heal - - -) (hp-heal - location -) (hp-heal - shortcut-key -) (hp-heal - - -)
    (hp-heal key (:objects -) (hp-heal key firelink location) (hp-heal key sen-entrance shortcut-key) (hp-heal key sen-inner -) (hp-heal key anor-entrance key) (hp-heal key - key) (hp-heal key location key) (hp-heal key shortcut-key key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal sen-guard1 (:objects -) (hp-heal sen-guard1 firelink location) (hp-heal sen-guard1 sen-entrance shortcut-key) (hp-heal sen-guard1 sen-inner -) (hp-heal sen-guard1 anor-entrance key) (hp-heal sen-guard1 - sen-guard1) (hp-heal sen-guard1 location sen-guard1) (hp-heal sen-guard1 shortcut-key sen-guard1) (hp-heal sen-guard1 - sen-guard1) (hp-heal sen-guard1 key sen-guard1) (hp-heal sen-guard1 sen-guard1 sen-guard1)
    (hp-heal sen-guard2 (:objects -) (hp-heal sen-guard2 firelink location) (hp-heal sen-guard2 sen-entrance shortcut-key) (hp-heal sen-guard2 sen-inner -) (hp-heal sen-guard2 anor-entrance key) (hp-heal sen-guard2 - sen-guard1) (hp-heal sen-guard2 location sen-guard2) (hp-heal sen-guard2 shortcut-key sen-guard2) (hp-heal sen-guard2 - sen-guard2) (hp-heal sen-guard2 key sen-guard2) (hp-heal sen-guard2 sen-guard1 sen-guard2) (hp-heal sen-guard2 sen-guard2 sen-guard2)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - sen-entrance shortcut-key) (hp-heal - sen-inner -) (hp-heal - anor-entrance key) (hp-heal - - sen-guard1) (hp-heal - location sen-guard2) (hp-heal - shortcut-key -) (hp-heal - - -) (hp-heal - key -) (hp-heal - sen-guard1 -) (hp-heal - sen-guard2 -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects -) (hp-heal minor-enemy firelink location) (hp-heal minor-enemy sen-entrance shortcut-key) (hp-heal minor-enemy sen-inner -) (hp-heal minor-enemy anor-entrance key) (hp-heal minor-enemy - sen-guard1) (hp-heal minor-enemy location sen-guard2) (hp-heal minor-enemy shortcut-key -) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy sen-guard1 minor-enemy) (hp-heal minor-enemy sen-guard2 minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal iron-golem (:objects -) (hp-heal iron-golem firelink location) (hp-heal iron-golem sen-entrance shortcut-key) (hp-heal iron-golem sen-inner -) (hp-heal iron-golem anor-entrance key) (hp-heal iron-golem - sen-guard1) (hp-heal iron-golem location sen-guard2) (hp-heal iron-golem shortcut-key -) (hp-heal iron-golem - minor-enemy) (hp-heal iron-golem key iron-golem) (hp-heal iron-golem sen-guard1 iron-golem) (hp-heal iron-golem sen-guard2 iron-golem) (hp-heal iron-golem - iron-golem) (hp-heal iron-golem minor-enemy iron-golem) (hp-heal iron-golem iron-golem iron-golem)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - sen-entrance shortcut-key) (hp-heal - sen-inner -) (hp-heal - anor-entrance key) (hp-heal - - sen-guard1) (hp-heal - location sen-guard2) (hp-heal - shortcut-key -) (hp-heal - - minor-enemy) (hp-heal - key iron-golem) (hp-heal - sen-guard1 -) (hp-heal - sen-guard2 -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - iron-golem -) (hp-heal - - -)
    (hp-heal boss (:objects -) (hp-heal boss firelink location) (hp-heal boss sen-entrance shortcut-key) (hp-heal boss sen-inner -) (hp-heal boss anor-entrance key) (hp-heal boss - sen-guard1) (hp-heal boss location sen-guard2) (hp-heal boss shortcut-key -) (hp-heal boss - minor-enemy) (hp-heal boss key iron-golem) (hp-heal boss sen-guard1 -) (hp-heal boss sen-guard2 boss) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss iron-golem boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects -) (hp-heal hp0 firelink location) (hp-heal hp0 sen-entrance shortcut-key) (hp-heal hp0 sen-inner -) (hp-heal hp0 anor-entrance key) (hp-heal hp0 - sen-guard1) (hp-heal hp0 location sen-guard2) (hp-heal hp0 shortcut-key -) (hp-heal hp0 - minor-enemy) (hp-heal hp0 key iron-golem) (hp-heal hp0 sen-guard1 -) (hp-heal hp0 sen-guard2 boss) (hp-heal hp0 - hp0) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 iron-golem hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects -) (hp-heal hp1 firelink location) (hp-heal hp1 sen-entrance shortcut-key) (hp-heal hp1 sen-inner -) (hp-heal hp1 anor-entrance key) (hp-heal hp1 - sen-guard1) (hp-heal hp1 location sen-guard2) (hp-heal hp1 shortcut-key -) (hp-heal hp1 - minor-enemy) (hp-heal hp1 key iron-golem) (hp-heal hp1 sen-guard1 -) (hp-heal hp1 sen-guard2 boss) (hp-heal hp1 - hp0) (hp-heal hp1 minor-enemy hp1) (hp-heal hp1 iron-golem hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects -) (hp-heal hp2 firelink location) (hp-heal hp2 sen-entrance shortcut-key) (hp-heal hp2 sen-inner -) (hp-heal hp2 anor-entrance key) (hp-heal hp2 - sen-guard1) (hp-heal hp2 location sen-guard2) (hp-heal hp2 shortcut-key -) (hp-heal hp2 - minor-enemy) (hp-heal hp2 key iron-golem) (hp-heal hp2 sen-guard1 -) (hp-heal hp2 sen-guard2 boss) (hp-heal hp2 - hp0) (hp-heal hp2 minor-enemy hp1) (hp-heal hp2 iron-golem hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects -) (hp-heal hp3 firelink location) (hp-heal hp3 sen-entrance shortcut-key) (hp-heal hp3 sen-inner -) (hp-heal hp3 anor-entrance key) (hp-heal hp3 - sen-guard1) (hp-heal hp3 location sen-guard2) (hp-heal hp3 shortcut-key -) (hp-heal hp3 - minor-enemy) (hp-heal hp3 key iron-golem) (hp-heal hp3 sen-guard1 -) (hp-heal hp3 sen-guard2 boss) (hp-heal hp3 - hp0) (hp-heal hp3 minor-enemy hp1) (hp-heal hp3 iron-golem hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
    ;; hp ordering (<=)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1)
    (player-weapon-level w1)
    (wlevel-next w0 w1)
    (wlevel-next w1 w2)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp4 bp3)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase iron-golem bp4)
    (boss-current-phase iron-golem bp4)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack iron-golem hp3 hp2)
    (hp-after-attack iron-golem hp2 hp1)
    (hp-after-attack iron-golem hp1 hp0)
    (hp-after-attack sen-guard1 hp3 hp2)
    (hp-after-attack sen-guard1 hp2 hp1)
    (hp-after-attack sen-guard1 hp1 hp0)
    (hp-after-attack sen-guard2 hp3 hp2)
    (hp-after-attack sen-guard2 hp2 hp1)
    (hp-after-attack sen-guard2 hp1 hp0)

    ;; souls gain from minor enemies (saturating at s9)
    (soul-after-drop sen-guard1 s0 s1) (soul-after-drop sen-guard1 s1 s2) (soul-after-drop sen-guard1 s2 s3)
    (soul-after-drop sen-guard1 s3 s4) (soul-after-drop sen-guard1 s4 s5) (soul-after-drop sen-guard1 s5 s6)
    (soul-after-drop sen-guard1 s6 s7) (soul-after-drop sen-guard1 s7 s8) (soul-after-drop sen-guard1 s8 s9)
    (soul-after-drop sen-guard1 s9 s9)

    (soul-after-drop sen-guard2 s0 s1) (soul-after-drop sen-guard2 s1 s2) (soul-after-drop sen-guard2 s2 s3)
    (soul-after-drop sen-guard2 s3 s4) (soul-after-drop sen-guard2 s4 s5) (soul-after-drop sen-guard2 s5 s6)
    (soul-after-drop sen-guard2 s6 s7) (soul-after-drop sen-guard2 s7 s8) (soul-after-drop sen-guard2 s8 s9)
    (soul-after-drop sen-guard2 s9 s9)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss iron-golem w2)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (is-alive iron-golem))
    (deposited-soul iron-golem)
  ))
    (:metric minimize (total-cost))
)

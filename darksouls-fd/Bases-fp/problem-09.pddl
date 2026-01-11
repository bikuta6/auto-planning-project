(define (problem p09-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink ruins smith-hut valley - location
    titanite1 titanite2 - key
    dummy-minor-enemy - minor-enemy
    miniboss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 w2 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink ruins)
    (connected ruins firelink)
    (connected ruins smith-hut)
    (connected smith-hut ruins)
    (connected smith-hut valley)
    (connected valley smith-hut)
    (titanite-at ruins)
    (titanite-at smith-hut)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire smith-hut)
    (is-blacksmith smith-hut)
    (enemy-at miniboss valley)
    (is-alive miniboss)
    (has-active-boss valley)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal ruins (:objects ruins) (hp-heal ruins firelink ruins) (hp-heal ruins ruins ruins)
    (hp-heal smith-hut (:objects smith-hut) (hp-heal smith-hut firelink smith-hut) (hp-heal smith-hut ruins smith-hut) (hp-heal smith-hut smith-hut smith-hut)
    (hp-heal valley (:objects valley) (hp-heal valley firelink valley) (hp-heal valley ruins valley) (hp-heal valley smith-hut valley) (hp-heal valley valley valley)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - ruins -) (hp-heal - smith-hut -) (hp-heal - valley -) (hp-heal - - -)
    (hp-heal location (:objects -) (hp-heal location firelink location) (hp-heal location ruins location) (hp-heal location smith-hut location) (hp-heal location valley location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal titanite1 (:objects -) (hp-heal titanite1 firelink location) (hp-heal titanite1 ruins titanite1) (hp-heal titanite1 smith-hut titanite1) (hp-heal titanite1 valley titanite1) (hp-heal titanite1 - titanite1) (hp-heal titanite1 location titanite1) (hp-heal titanite1 titanite1 titanite1)
    (hp-heal titanite2 (:objects -) (hp-heal titanite2 firelink location) (hp-heal titanite2 ruins titanite1) (hp-heal titanite2 smith-hut titanite2) (hp-heal titanite2 valley titanite2) (hp-heal titanite2 - titanite2) (hp-heal titanite2 location titanite2) (hp-heal titanite2 titanite1 titanite2) (hp-heal titanite2 titanite2 titanite2)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - ruins titanite1) (hp-heal - smith-hut titanite2) (hp-heal - valley -) (hp-heal - - -) (hp-heal - location -) (hp-heal - titanite1 -) (hp-heal - titanite2 -) (hp-heal - - -)
    (hp-heal key (:objects -) (hp-heal key firelink location) (hp-heal key ruins titanite1) (hp-heal key smith-hut titanite2) (hp-heal key valley -) (hp-heal key - key) (hp-heal key location key) (hp-heal key titanite1 key) (hp-heal key titanite2 key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal dummy-minor-enemy (:objects -) (hp-heal dummy-minor-enemy firelink location) (hp-heal dummy-minor-enemy ruins titanite1) (hp-heal dummy-minor-enemy smith-hut titanite2) (hp-heal dummy-minor-enemy valley -) (hp-heal dummy-minor-enemy - key) (hp-heal dummy-minor-enemy location dummy-minor-enemy) (hp-heal dummy-minor-enemy titanite1 dummy-minor-enemy) (hp-heal dummy-minor-enemy titanite2 dummy-minor-enemy) (hp-heal dummy-minor-enemy - dummy-minor-enemy) (hp-heal dummy-minor-enemy key dummy-minor-enemy) (hp-heal dummy-minor-enemy dummy-minor-enemy dummy-minor-enemy)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - ruins titanite1) (hp-heal - smith-hut titanite2) (hp-heal - valley -) (hp-heal - - key) (hp-heal - location dummy-minor-enemy) (hp-heal - titanite1 -) (hp-heal - titanite2 -) (hp-heal - - -) (hp-heal - key -) (hp-heal - dummy-minor-enemy -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects -) (hp-heal minor-enemy firelink location) (hp-heal minor-enemy ruins titanite1) (hp-heal minor-enemy smith-hut titanite2) (hp-heal minor-enemy valley -) (hp-heal minor-enemy - key) (hp-heal minor-enemy location dummy-minor-enemy) (hp-heal minor-enemy titanite1 -) (hp-heal minor-enemy titanite2 minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy dummy-minor-enemy minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal miniboss (:objects -) (hp-heal miniboss firelink location) (hp-heal miniboss ruins titanite1) (hp-heal miniboss smith-hut titanite2) (hp-heal miniboss valley -) (hp-heal miniboss - key) (hp-heal miniboss location dummy-minor-enemy) (hp-heal miniboss titanite1 -) (hp-heal miniboss titanite2 minor-enemy) (hp-heal miniboss - miniboss) (hp-heal miniboss key miniboss) (hp-heal miniboss dummy-minor-enemy miniboss) (hp-heal miniboss - miniboss) (hp-heal miniboss minor-enemy miniboss) (hp-heal miniboss miniboss miniboss)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - ruins titanite1) (hp-heal - smith-hut titanite2) (hp-heal - valley -) (hp-heal - - key) (hp-heal - location dummy-minor-enemy) (hp-heal - titanite1 -) (hp-heal - titanite2 minor-enemy) (hp-heal - - miniboss) (hp-heal - key -) (hp-heal - dummy-minor-enemy -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - miniboss -) (hp-heal - - -)
    (hp-heal boss (:objects -) (hp-heal boss firelink location) (hp-heal boss ruins titanite1) (hp-heal boss smith-hut titanite2) (hp-heal boss valley -) (hp-heal boss - key) (hp-heal boss location dummy-minor-enemy) (hp-heal boss titanite1 -) (hp-heal boss titanite2 minor-enemy) (hp-heal boss - miniboss) (hp-heal boss key -) (hp-heal boss dummy-minor-enemy boss) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss miniboss boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects -) (hp-heal hp0 firelink location) (hp-heal hp0 ruins titanite1) (hp-heal hp0 smith-hut titanite2) (hp-heal hp0 valley -) (hp-heal hp0 - key) (hp-heal hp0 location dummy-minor-enemy) (hp-heal hp0 titanite1 -) (hp-heal hp0 titanite2 minor-enemy) (hp-heal hp0 - miniboss) (hp-heal hp0 key -) (hp-heal hp0 dummy-minor-enemy boss) (hp-heal hp0 - hp0) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 miniboss hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects -) (hp-heal hp1 firelink location) (hp-heal hp1 ruins titanite1) (hp-heal hp1 smith-hut titanite2) (hp-heal hp1 valley -) (hp-heal hp1 - key) (hp-heal hp1 location dummy-minor-enemy) (hp-heal hp1 titanite1 -) (hp-heal hp1 titanite2 minor-enemy) (hp-heal hp1 - miniboss) (hp-heal hp1 key -) (hp-heal hp1 dummy-minor-enemy boss) (hp-heal hp1 - hp0) (hp-heal hp1 minor-enemy hp1) (hp-heal hp1 miniboss hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects -) (hp-heal hp2 firelink location) (hp-heal hp2 ruins titanite1) (hp-heal hp2 smith-hut titanite2) (hp-heal hp2 valley -) (hp-heal hp2 - key) (hp-heal hp2 location dummy-minor-enemy) (hp-heal hp2 titanite1 -) (hp-heal hp2 titanite2 minor-enemy) (hp-heal hp2 - miniboss) (hp-heal hp2 key -) (hp-heal hp2 dummy-minor-enemy boss) (hp-heal hp2 - hp0) (hp-heal hp2 minor-enemy hp1) (hp-heal hp2 miniboss hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects -) (hp-heal hp3 firelink location) (hp-heal hp3 ruins titanite1) (hp-heal hp3 smith-hut titanite2) (hp-heal hp3 valley -) (hp-heal hp3 - key) (hp-heal hp3 location dummy-minor-enemy) (hp-heal hp3 titanite1 -) (hp-heal hp3 titanite2 minor-enemy) (hp-heal hp3 - miniboss) (hp-heal hp3 key -) (hp-heal hp3 dummy-minor-enemy boss) (hp-heal hp3 - hp0) (hp-heal hp3 minor-enemy hp1) (hp-heal hp3 miniboss hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
    ;; hp ordering (<=)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1)
    (player-weapon-level w0)
    (wlevel-next w0 w1)
    (wlevel-next w1 w2)

    ;; souls ladder (discrete, with max)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6)
    (player-max-souls s6)
    (player-souls s0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase miniboss bp2)
    (boss-current-phase miniboss bp2)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack dummy-minor-enemy hp3 hp2)
    (hp-after-attack dummy-minor-enemy hp2 hp1)
    (hp-after-attack dummy-minor-enemy hp1 hp0)
    (hp-after-attack miniboss hp3 hp2)
    (hp-after-attack miniboss hp2 hp1)
    (hp-after-attack miniboss hp1 hp0)

    ;; souls gain from dummy-minor-enemy (saturating at s9)
    (soul-after-drop dummy-minor-enemy s0 s1) (soul-after-drop dummy-minor-enemy s1 s2) (soul-after-drop dummy-minor-enemy s2 s3)
    (soul-after-drop dummy-minor-enemy s3 s4) (soul-after-drop dummy-minor-enemy s4 s5) (soul-after-drop dummy-minor-enemy s5 s6)
    (soul-after-drop dummy-minor-enemy s6 s7) (soul-after-drop dummy-minor-enemy s7 s8) (soul-after-drop dummy-minor-enemy s8 s9)
    (soul-after-drop dummy-minor-enemy s9 s9)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss miniboss w2)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (is-alive miniboss))
    (deposited-soul miniboss)
  ))
    (:metric minimize (total-cost))
)

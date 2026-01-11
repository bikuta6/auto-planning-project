(define (problem p07-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink anor-entrance anor-hall ornstein-smough-approach - location
    dummy-key - key
    minib1 minib2 minib3 - minor-enemy
    ornstein smough - boss

    hp0 hp1 hp2 hp3 hp4 hp5 - hp-level
    w0 w1 w2 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 bp3 bp4 - boss-phase
    e1 e2 e3 e4 e5 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink anor-entrance)
    (connected anor-entrance firelink)
    (connected anor-entrance anor-hall)
    (connected anor-hall anor-entrance)
    (connected anor-hall ornstein-smough-approach)
    (connected ornstein-smough-approach anor-hall)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire anor-hall)
    (is-blacksmith firelink)
    (enemy-at minib1 anor-entrance)
    (enemy-at minib2 anor-hall)
    (enemy-at minib3 anor-hall)
    (enemy-at ornstein ornstein-smough-approach)
    (enemy-at smough ornstein-smough-approach)
    (is-alive minib1)
    (is-alive minib2)
    (is-alive minib3)
    (is-alive ornstein)
    (is-alive smough)
    (has-active-boss ornstein-smough-approach)
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5)
    (hp-zero hp0)
    (hp-heal (:objects (:objects (:objects)
    (hp-heal firelink (:objects firelink) (hp-heal firelink firelink firelink)
    (hp-heal anor-entrance (:objects anor-entrance) (hp-heal anor-entrance firelink anor-entrance) (hp-heal anor-entrance anor-entrance anor-entrance)
    (hp-heal anor-hall (:objects anor-hall) (hp-heal anor-hall firelink anor-hall) (hp-heal anor-hall anor-entrance anor-hall) (hp-heal anor-hall anor-hall anor-hall)
    (hp-heal ornstein-smough-approach (:objects ornstein-smough-approach) (hp-heal ornstein-smough-approach firelink ornstein-smough-approach) (hp-heal ornstein-smough-approach anor-entrance ornstein-smough-approach) (hp-heal ornstein-smough-approach anor-hall ornstein-smough-approach) (hp-heal ornstein-smough-approach ornstein-smough-approach ornstein-smough-approach)
    (hp-heal - (:objects -) (hp-heal - firelink -) (hp-heal - anor-entrance -) (hp-heal - anor-hall -) (hp-heal - ornstein-smough-approach -) (hp-heal - - -)
    (hp-heal location (:objects -) (hp-heal location firelink location) (hp-heal location anor-entrance location) (hp-heal location anor-hall location) (hp-heal location ornstein-smough-approach location) (hp-heal location - location) (hp-heal location location location)
    (hp-heal dummy-key (:objects -) (hp-heal dummy-key firelink location) (hp-heal dummy-key anor-entrance dummy-key) (hp-heal dummy-key anor-hall dummy-key) (hp-heal dummy-key ornstein-smough-approach dummy-key) (hp-heal dummy-key - dummy-key) (hp-heal dummy-key location dummy-key) (hp-heal dummy-key dummy-key dummy-key)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - anor-entrance dummy-key) (hp-heal - anor-hall -) (hp-heal - ornstein-smough-approach -) (hp-heal - - -) (hp-heal - location -) (hp-heal - dummy-key -) (hp-heal - - -)
    (hp-heal key (:objects -) (hp-heal key firelink location) (hp-heal key anor-entrance dummy-key) (hp-heal key anor-hall -) (hp-heal key ornstein-smough-approach key) (hp-heal key - key) (hp-heal key location key) (hp-heal key dummy-key key) (hp-heal key - key) (hp-heal key key key)
    (hp-heal minib1 (:objects -) (hp-heal minib1 firelink location) (hp-heal minib1 anor-entrance dummy-key) (hp-heal minib1 anor-hall -) (hp-heal minib1 ornstein-smough-approach key) (hp-heal minib1 - minib1) (hp-heal minib1 location minib1) (hp-heal minib1 dummy-key minib1) (hp-heal minib1 - minib1) (hp-heal minib1 key minib1) (hp-heal minib1 minib1 minib1)
    (hp-heal minib2 (:objects -) (hp-heal minib2 firelink location) (hp-heal minib2 anor-entrance dummy-key) (hp-heal minib2 anor-hall -) (hp-heal minib2 ornstein-smough-approach key) (hp-heal minib2 - minib1) (hp-heal minib2 location minib2) (hp-heal minib2 dummy-key minib2) (hp-heal minib2 - minib2) (hp-heal minib2 key minib2) (hp-heal minib2 minib1 minib2) (hp-heal minib2 minib2 minib2)
    (hp-heal minib3 (:objects -) (hp-heal minib3 firelink location) (hp-heal minib3 anor-entrance dummy-key) (hp-heal minib3 anor-hall -) (hp-heal minib3 ornstein-smough-approach key) (hp-heal minib3 - minib1) (hp-heal minib3 location minib2) (hp-heal minib3 dummy-key minib3) (hp-heal minib3 - minib3) (hp-heal minib3 key minib3) (hp-heal minib3 minib1 minib3) (hp-heal minib3 minib2 minib3) (hp-heal minib3 minib3 minib3)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - anor-entrance dummy-key) (hp-heal - anor-hall -) (hp-heal - ornstein-smough-approach key) (hp-heal - - minib1) (hp-heal - location minib2) (hp-heal - dummy-key minib3) (hp-heal - - -) (hp-heal - key -) (hp-heal - minib1 -) (hp-heal - minib2 -) (hp-heal - minib3 -) (hp-heal - - -)
    (hp-heal minor-enemy (:objects -) (hp-heal minor-enemy firelink location) (hp-heal minor-enemy anor-entrance dummy-key) (hp-heal minor-enemy anor-hall -) (hp-heal minor-enemy ornstein-smough-approach key) (hp-heal minor-enemy - minib1) (hp-heal minor-enemy location minib2) (hp-heal minor-enemy dummy-key minib3) (hp-heal minor-enemy - -) (hp-heal minor-enemy key minor-enemy) (hp-heal minor-enemy minib1 minor-enemy) (hp-heal minor-enemy minib2 minor-enemy) (hp-heal minor-enemy minib3 minor-enemy) (hp-heal minor-enemy - minor-enemy) (hp-heal minor-enemy minor-enemy minor-enemy)
    (hp-heal ornstein (:objects -) (hp-heal ornstein firelink location) (hp-heal ornstein anor-entrance dummy-key) (hp-heal ornstein anor-hall -) (hp-heal ornstein ornstein-smough-approach key) (hp-heal ornstein - minib1) (hp-heal ornstein location minib2) (hp-heal ornstein dummy-key minib3) (hp-heal ornstein - -) (hp-heal ornstein key minor-enemy) (hp-heal ornstein minib1 ornstein) (hp-heal ornstein minib2 ornstein) (hp-heal ornstein minib3 ornstein) (hp-heal ornstein - ornstein) (hp-heal ornstein minor-enemy ornstein) (hp-heal ornstein ornstein ornstein)
    (hp-heal smough (:objects -) (hp-heal smough firelink location) (hp-heal smough anor-entrance dummy-key) (hp-heal smough anor-hall -) (hp-heal smough ornstein-smough-approach key) (hp-heal smough - minib1) (hp-heal smough location minib2) (hp-heal smough dummy-key minib3) (hp-heal smough - -) (hp-heal smough key minor-enemy) (hp-heal smough minib1 ornstein) (hp-heal smough minib2 smough) (hp-heal smough minib3 smough) (hp-heal smough - smough) (hp-heal smough minor-enemy smough) (hp-heal smough ornstein smough) (hp-heal smough smough smough)
    (hp-heal - (:objects -) (hp-heal - firelink location) (hp-heal - anor-entrance dummy-key) (hp-heal - anor-hall -) (hp-heal - ornstein-smough-approach key) (hp-heal - - minib1) (hp-heal - location minib2) (hp-heal - dummy-key minib3) (hp-heal - - -) (hp-heal - key minor-enemy) (hp-heal - minib1 ornstein) (hp-heal - minib2 smough) (hp-heal - minib3 -) (hp-heal - - -) (hp-heal - minor-enemy -) (hp-heal - ornstein -) (hp-heal - smough -) (hp-heal - - -)
    (hp-heal boss (:objects -) (hp-heal boss firelink location) (hp-heal boss anor-entrance dummy-key) (hp-heal boss anor-hall -) (hp-heal boss ornstein-smough-approach key) (hp-heal boss - minib1) (hp-heal boss location minib2) (hp-heal boss dummy-key minib3) (hp-heal boss - -) (hp-heal boss key minor-enemy) (hp-heal boss minib1 ornstein) (hp-heal boss minib2 smough) (hp-heal boss minib3 -) (hp-heal boss - boss) (hp-heal boss minor-enemy boss) (hp-heal boss ornstein boss) (hp-heal boss smough boss) (hp-heal boss - boss) (hp-heal boss boss boss)
    (hp-heal hp0 (:objects -) (hp-heal hp0 firelink location) (hp-heal hp0 anor-entrance dummy-key) (hp-heal hp0 anor-hall -) (hp-heal hp0 ornstein-smough-approach key) (hp-heal hp0 - minib1) (hp-heal hp0 location minib2) (hp-heal hp0 dummy-key minib3) (hp-heal hp0 - -) (hp-heal hp0 key minor-enemy) (hp-heal hp0 minib1 ornstein) (hp-heal hp0 minib2 smough) (hp-heal hp0 minib3 -) (hp-heal hp0 - boss) (hp-heal hp0 minor-enemy hp0) (hp-heal hp0 ornstein hp0) (hp-heal hp0 smough hp0) (hp-heal hp0 - hp0) (hp-heal hp0 boss hp0) (hp-heal hp0 hp0 hp0)
    (hp-heal hp1 (:objects -) (hp-heal hp1 firelink location) (hp-heal hp1 anor-entrance dummy-key) (hp-heal hp1 anor-hall -) (hp-heal hp1 ornstein-smough-approach key) (hp-heal hp1 - minib1) (hp-heal hp1 location minib2) (hp-heal hp1 dummy-key minib3) (hp-heal hp1 - -) (hp-heal hp1 key minor-enemy) (hp-heal hp1 minib1 ornstein) (hp-heal hp1 minib2 smough) (hp-heal hp1 minib3 -) (hp-heal hp1 - boss) (hp-heal hp1 minor-enemy hp0) (hp-heal hp1 ornstein hp1) (hp-heal hp1 smough hp1) (hp-heal hp1 - hp1) (hp-heal hp1 boss hp1) (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1)
    (hp-heal hp2 (:objects -) (hp-heal hp2 firelink location) (hp-heal hp2 anor-entrance dummy-key) (hp-heal hp2 anor-hall -) (hp-heal hp2 ornstein-smough-approach key) (hp-heal hp2 - minib1) (hp-heal hp2 location minib2) (hp-heal hp2 dummy-key minib3) (hp-heal hp2 - -) (hp-heal hp2 key minor-enemy) (hp-heal hp2 minib1 ornstein) (hp-heal hp2 minib2 smough) (hp-heal hp2 minib3 -) (hp-heal hp2 - boss) (hp-heal hp2 minor-enemy hp0) (hp-heal hp2 ornstein hp1) (hp-heal hp2 smough hp2) (hp-heal hp2 - hp2) (hp-heal hp2 boss hp2) (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2)
    (hp-heal hp3 (:objects -) (hp-heal hp3 firelink location) (hp-heal hp3 anor-entrance dummy-key) (hp-heal hp3 anor-hall -) (hp-heal hp3 ornstein-smough-approach key) (hp-heal hp3 - minib1) (hp-heal hp3 location minib2) (hp-heal hp3 dummy-key minib3) (hp-heal hp3 - -) (hp-heal hp3 key minor-enemy) (hp-heal hp3 minib1 ornstein) (hp-heal hp3 minib2 smough) (hp-heal hp3 minib3 -) (hp-heal hp3 - boss) (hp-heal hp3 minor-enemy hp0) (hp-heal hp3 ornstein hp1) (hp-heal hp3 smough hp2) (hp-heal hp3 - hp3) (hp-heal hp3 boss hp3) (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3)
    (hp-heal hp4 (:objects -) (hp-heal hp4 firelink location) (hp-heal hp4 anor-entrance dummy-key) (hp-heal hp4 anor-hall -) (hp-heal hp4 ornstein-smough-approach key) (hp-heal hp4 - minib1) (hp-heal hp4 location minib2) (hp-heal hp4 dummy-key minib3) (hp-heal hp4 - -) (hp-heal hp4 key minor-enemy) (hp-heal hp4 minib1 ornstein) (hp-heal hp4 minib2 smough) (hp-heal hp4 minib3 -) (hp-heal hp4 - boss) (hp-heal hp4 minor-enemy hp0) (hp-heal hp4 ornstein hp1) (hp-heal hp4 smough hp2) (hp-heal hp4 - hp3) (hp-heal hp4 boss hp4) (hp-heal hp4 hp0 hp4) (hp-heal hp4 hp1 hp4) (hp-heal hp4 hp2 hp4) (hp-heal hp4 hp3 hp4) (hp-heal hp4 hp4 hp4)
    (hp-heal hp5 (:objects -) (hp-heal hp5 firelink location) (hp-heal hp5 anor-entrance dummy-key) (hp-heal hp5 anor-hall -) (hp-heal hp5 ornstein-smough-approach key) (hp-heal hp5 - minib1) (hp-heal hp5 location minib2) (hp-heal hp5 dummy-key minib3) (hp-heal hp5 - -) (hp-heal hp5 key minor-enemy) (hp-heal hp5 minib1 ornstein) (hp-heal hp5 minib2 smough) (hp-heal hp5 minib3 -) (hp-heal hp5 - boss) (hp-heal hp5 minor-enemy hp0) (hp-heal hp5 ornstein hp1) (hp-heal hp5 smough hp2) (hp-heal hp5 - hp3) (hp-heal hp5 boss hp4) (hp-heal hp5 hp0 hp5) (hp-heal hp5 hp1 hp5) (hp-heal hp5 hp2 hp5) (hp-heal hp5 hp3 hp5) (hp-heal hp5 hp4 hp5) (hp-heal hp5 hp5 hp5)
    ;; hp ordering (<=)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-current-level pl0) (player-level-next pl0 pl1)
    (player-weapon-level w2)
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
    (boss-max-phase ornstein bp4)
    (boss-current-phase ornstein bp4)
    (boss-max-phase smough bp4)
    (boss-current-phase smough bp4)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack minib1 hp5 hp4)
    (hp-after-attack minib1 hp4 hp3)
    (hp-after-attack minib1 hp3 hp2)
    (hp-after-attack minib1 hp2 hp1)
    (hp-after-attack minib1 hp1 hp0)

    (hp-after-attack minib2 hp5 hp4)
    (hp-after-attack minib2 hp4 hp3)
    (hp-after-attack minib2 hp3 hp2)
    (hp-after-attack minib2 hp2 hp1)
    (hp-after-attack minib2 hp1 hp0)
    
    (hp-after-attack minib3 hp5 hp4)
    (hp-after-attack minib3 hp4 hp3)
    (hp-after-attack minib3 hp3 hp2)
    (hp-after-attack minib3 hp2 hp1)
    (hp-after-attack minib3 hp1 hp0)

    (hp-after-attack ornstein hp5 hp3)
    (hp-after-attack ornstein hp3 hp1)
    (hp-after-attack ornstein hp1 hp0)
    
    (hp-after-attack smough hp5 hp4)
    (hp-after-attack smough hp4 hp3)
    (hp-after-attack smough hp3 hp2)
    (hp-after-attack smough hp2 hp1)
    (hp-after-attack smough hp1 hp0)

    ;; souls gain from minor enemies (saturating at s9)
    (soul-after-drop minib1 s0 s1) (soul-after-drop minib1 s1 s2) (soul-after-drop minib1 s2 s3)
    (soul-after-drop minib1 s3 s4) (soul-after-drop minib1 s4 s5) (soul-after-drop minib1 s5 s6)
    (soul-after-drop minib1 s6 s7) (soul-after-drop minib1 s7 s8) (soul-after-drop minib1 s8 s9)
    (soul-after-drop minib1 s9 s9)

    (soul-after-drop minib2 s0 s1) (soul-after-drop minib2 s1 s2) (soul-after-drop minib2 s2 s3)
    (soul-after-drop minib2 s3 s4) (soul-after-drop minib2 s4 s5) (soul-after-drop minib2 s5 s6)
    (soul-after-drop minib2 s6 s7) (soul-after-drop minib2 s7 s8) (soul-after-drop minib2 s8 s9)
    (soul-after-drop minib2 s9 s9)

    (soul-after-drop minib3 s0 s1) (soul-after-drop minib3 s1 s2) (soul-after-drop minib3 s2 s3)
    (soul-after-drop minib3 s3 s4) (soul-after-drop minib3 s4 s5) (soul-after-drop minib3 s5 s6)
    (soul-after-drop minib3 s6 s7) (soul-after-drop minib3 s7 s8) (soul-after-drop minib3 s8 s9)
    (soul-after-drop minib3 s9 s9)


    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss ornstein w2)
    (can-damage-boss smough w2)
  
    ;; cost tracking
    (= (total-cost) 0)
  )
  (:goal (and
    (not (is-alive ornstein))
    (not (is-alive smough))
    (deposited-soul ornstein)
    (deposited-soul smough)
  ))
    (:metric minimize (total-cost))
)

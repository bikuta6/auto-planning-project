(define (problem p07-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink anor-entrance anor-hall ornstein-smough-approach - location
    dummy-key - key
    minib1 minib2 minib3 - minor-enemy
    ornstein smough - boss

    hp0 hp1 hp2 hp3 hp4 hp5 - hp-level
    w0 w1 w2 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 bp3 bp4 - boss-phase
    e1 e2 e3 e4 e5 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 - soul-level
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

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5)
    (hp-zero hp0)
    ;; hp ordering (<=)
    (hp-leq hp0 hp0) (hp-leq hp0 hp1) (hp-leq hp0 hp2) (hp-leq hp0 hp3) (hp-leq hp0 hp4) (hp-leq hp0 hp5)
    (hp-leq hp1 hp1) (hp-leq hp1 hp2) (hp-leq hp1 hp3) (hp-leq hp1 hp4) (hp-leq hp1 hp5)
    (hp-leq hp2 hp2) (hp-leq hp2 hp3) (hp-leq hp2 hp4) (hp-leq hp2 hp5)
    (hp-leq hp3 hp3) (hp-leq hp3 hp4) (hp-leq hp3 hp5)
    (hp-leq hp4 hp4) (hp-leq hp4 hp5)
    (hp-leq hp5 hp5)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-level pl0) (player-level-next pl0 pl1)
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
    (boss-phase ornstein bp4)
    (boss-max-phase smough bp4)
    (boss-phase smough bp4)
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

    ;; souls gain from minor enemies (saturating)
    (soul-after-drop minib1 s0 s1) (soul-after-drop minib1 s1 s2) (soul-after-drop minib1 s2 s3) (soul-after-drop minib1 s3 s4) (soul-after-drop minib1 s4 s5) (soul-after-drop minib1 s5 s6) (soul-after-drop minib1 s6 s6)
    (soul-after-drop minib2 s0 s1) (soul-after-drop minib2 s1 s2) (soul-after-drop minib2 s2 s3) (soul-after-drop minib2 s3 s4) (soul-after-drop minib2 s4 s5) (soul-after-drop minib2 s5 s6) (soul-after-drop minib2 s6 s6)
    (soul-after-drop minib3 s0 s1) (soul-after-drop minib3 s1 s2) (soul-after-drop minib3 s2 s3) (soul-after-drop minib3 s3 s4) (soul-after-drop minib3 s4 s5) (soul-after-drop minib3 s5 s6) (soul-after-drop minib3 s6 s6)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss ornstein w2)
    (can-damage-boss smough w2)
  )
  (:goal (and
    (not (is-alive ornstein))
    (not (is-alive smough))
    (deposited-soul ornstein)
    (deposited-soul smough)
  ))
)

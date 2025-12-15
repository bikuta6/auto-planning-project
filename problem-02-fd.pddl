(define (problem p02-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink burg-square gargoyle-rooftop - location
    dummy-key - key
    mob1 mob2 - minor-enemy
    gargoyle1 gargoyle2 - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 e4 e5 - estus-slot
    s0 s1 - soul-token
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

    ;; discrete ladders
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3)
    (hp-zero hp0)
    ;; hp ordering (<=)
    (hp-leq hp0 hp0) (hp-leq hp0 hp1) (hp-leq hp0 hp2) (hp-leq hp0 hp3)
    (hp-leq hp1 hp1) (hp-leq hp1 hp2) (hp-leq hp1 hp3)
    (hp-leq hp2 hp2) (hp-leq hp2 hp3)
    (hp-leq hp3 hp3)
    (player-max-hp hp2)
    (player-hp hp2)
    (player-level pl0) (player-level-next pl0 pl1)
    (player-weapon-level w0)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase gargoyle1 bp2)
    (boss-phase gargoyle1 bp2)
    (boss-max-phase gargoyle2 bp2)
    (boss-phase gargoyle2 bp2)
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

    ;; soul drops from minor enemies
    (drops-soul mob1 s0)
    (drops-soul mob2 s1)

    ;; boss weapon requirements
    (can-damage-boss gargoyle1 w0)
    (can-damage-boss gargoyle2 w0)
  )
  (:goal (and
    (deposited-soul gargoyle1)
    (deposited-soul gargoyle2)
  ))
)

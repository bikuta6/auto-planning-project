(define (problem p04-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink depths sewer-entrance depths-boss-arena titanite-node - location
    titanite1 - key
    dummy-minor-enemy - minor-enemy
    mini-boss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 - soul-token
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
    (wlevel-next w0 w1)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase mini-boss bp2)
    (boss-phase mini-boss bp2)
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

    ;; soul drops from minor enemies
    (drops-soul dummy-minor-enemy s0)

    ;; boss weapon requirements
    (can-damage-boss mini-boss w1)
  )
  (:goal (and
    (deposited-soul mini-boss)
  ))
)

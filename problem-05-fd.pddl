(define (problem p05-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink swamp-entrance blighttown quelaag-arena - location
    dummy-key - key
    mob1 mob2 mob3 - minor-enemy
    quelaag - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 - soul-token
  )
  (:init
    (connected firelink swamp-entrance)
    (connected swamp-entrance firelink)
    (connected swamp-entrance blighttown)
    (connected blighttown swamp-entrance)
    (connected blighttown quelaag-arena)
    (connected quelaag-arena blighttown)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire blighttown)
    (is-blacksmith firelink)
    (enemy-at mob1 swamp-entrance)
    (enemy-at mob2 swamp-entrance)
    (enemy-at mob3 blighttown)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)
    (enemy-at quelaag quelaag-arena)
    (is-alive quelaag)
    (has-active-boss quelaag-arena)
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
    (player-weapon-level w1)
    (wlevel-next w0 w1)

    ;; boss phases (hits remaining)
    (boss-phase-zero bp0)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase quelaag bp2)
    (boss-phase quelaag bp2)
    (estus-unlocked e1)
    (estus-full e1)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack mob1 hp3 hp2)
    (hp-after-attack mob1 hp2 hp1)
    (hp-after-attack mob1 hp1 hp0)
    (hp-after-attack mob2 hp3 hp2)
    (hp-after-attack mob2 hp2 hp1)
    (hp-after-attack mob2 hp1 hp0)
    (hp-after-attack mob3 hp3 hp2)
    (hp-after-attack mob3 hp2 hp1)
    (hp-after-attack mob3 hp1 hp0)
    (hp-after-attack quelaag hp3 hp2)
    (hp-after-attack quelaag hp2 hp1)
    (hp-after-attack quelaag hp1 hp0)

    ;; soul drops from minor enemies
    (drops-soul mob1 s0)
    (drops-soul mob2 s1)
    (drops-soul mob3 s2)

    ;; boss weapon requirements
    (can-damage-boss quelaag w1)
  )
  (:goal (and
    (not (is-alive quelaag))
    (deposited-soul quelaag)
  ))
)

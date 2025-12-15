(define (problem p10-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink long-road mid-camp boss-lair - location
    dummmy-key - key
    mob1 mob2 mob3 - minor-enemy
    lair-boss - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 - estus-slot
    s0 s1 s2 - soul-token
  )
  (:init
    (connected firelink long-road)
    (connected long-road firelink)
    (connected long-road mid-camp)
    (connected mid-camp long-road)
    (connected mid-camp boss-lair)
    (connected boss-lair mid-camp)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire mid-camp)
    (is-blacksmith firelink)
    (enemy-at mob1 long-road)
    (enemy-at mob2 mid-camp)
    (enemy-at mob3 mid-camp)
    (enemy-at lair-boss boss-lair)
    (is-alive mob1)
    (is-alive mob2)
    (is-alive mob3)
    (is-alive lair-boss)
    (has-active-boss boss-lair)
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
    (boss-max-phase lair-boss bp2)
    (boss-phase lair-boss bp2)
    (estus-unlocked e1)
    (estus-full e1)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack lair-boss hp3 hp2)
    (hp-after-attack lair-boss hp2 hp1)
    (hp-after-attack lair-boss hp1 hp0)
    (hp-after-attack mob1 hp3 hp2)
    (hp-after-attack mob1 hp2 hp1)
    (hp-after-attack mob1 hp1 hp0)
    (hp-after-attack mob2 hp3 hp2)
    (hp-after-attack mob2 hp2 hp1)
    (hp-after-attack mob2 hp1 hp0)
    (hp-after-attack mob3 hp3 hp2)
    (hp-after-attack mob3 hp2 hp1)
    (hp-after-attack mob3 hp1 hp0)

    ;; soul drops from minor enemies
    (drops-soul mob1 s0)
    (drops-soul mob2 s1)
    (drops-soul mob3 s2)

    ;; boss weapon requirements
    (can-damage-boss lair-boss w1)
  )
  (:goal (and
    (not (is-alive lair-boss))
    (deposited-soul lair-boss)
  ))
)

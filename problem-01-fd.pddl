(define (problem p01-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink undead-burg taurus-arena - location
    dummy-key - key
    dummy-minor-enemy - minor-enemy
    taurus - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 - soul-token
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
    (boss-max-phase taurus bp2)
    (boss-phase taurus bp2)
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

    ;; soul drops from minor enemies
    (drops-soul dummy-minor-enemy s0)

    ;; boss weapon requirements
    (can-damage-boss taurus w0)
  )
  (:goal (and
    (deposited-soul taurus)
  ))
)

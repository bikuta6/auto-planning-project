(define (problem dark-souls-game-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink burg parish darkroot boss-arena roof - location
    crest-of-artorias - key
    balder-knight hollow-soldier - minor-enemy
    sif gargoyles - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 - boss-phase
    e1 e2 e3 e4 e5 - estus-slot
    s0 s1 - soul-token
  )
  (:init
    (connected firelink burg)
    (connected burg firelink)
    (connected burg parish)
    (connected parish burg)
    (connected parish darkroot)
    (connected darkroot parish)
    (connected darkroot boss-arena)
    (connected boss-arena darkroot)
    (connected parish roof)
    (connected roof parish)
    (locked darkroot boss-arena)
    (locked boss-arena darkroot)
    (matches crest-of-artorias darkroot boss-arena)
    (key-at crest-of-artorias parish)
    (can-open-shortcut parish firelink)
    (has-active-boss boss-arena)
    (has-active-boss roof)
    (at-player firelink)
    (is-firelink firelink)
    (has-bonfire firelink)
    (has-bonfire parish)
    (is-blacksmith parish)
    (titanite-at darkroot)
    (enemy-at hollow-soldier burg)
    (is-alive hollow-soldier)
    (enemy-at balder-knight parish)
    (is-alive balder-knight)
    (enemy-at gargoyles roof)
    (is-alive gargoyles)
    (enemy-at sif boss-arena)
    (is-alive sif)

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
    (boss-phase-next bp5 bp4)
    (boss-phase-next bp4 bp3)
    (boss-phase-next bp3 bp2)
    (boss-phase-next bp2 bp1)
    (boss-phase-next bp1 bp0)
    (boss-max-phase sif bp5)
    (boss-phase sif bp5)
    (boss-max-phase gargoyles bp2)
    (boss-phase gargoyles bp2)
    (estus-unlocked e1)
    (estus-unlocked e2)
    (estus-full e1)
    (estus-full e2)

    ;; combat consequences: each attack reduces HP by one step
    (hp-after-attack balder-knight hp3 hp2)
    (hp-after-attack balder-knight hp2 hp1)
    (hp-after-attack balder-knight hp1 hp0)
    (hp-after-attack gargoyles hp3 hp2)
    (hp-after-attack gargoyles hp2 hp1)
    (hp-after-attack gargoyles hp1 hp0)
    (hp-after-attack hollow-soldier hp3 hp2)
    (hp-after-attack hollow-soldier hp2 hp1)
    (hp-after-attack hollow-soldier hp1 hp0)
    (hp-after-attack sif hp3 hp2)
    (hp-after-attack sif hp2 hp1)
    (hp-after-attack sif hp1 hp0)

    ;; soul drops from minor enemies
    (drops-soul balder-knight s0)
    (drops-soul hollow-soldier s1)

    ;; boss weapon requirements
    (can-damage-boss sif w1)
    (can-damage-boss gargoyles w0)
    (can-damage-boss gargoyles w1)
  )
  (:goal 
        (and
            (deposited-soul gargoyles)               
            (deposited-soul sif)                     
        )
    )
)

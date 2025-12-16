(define (problem p06-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink sen-entrance sen-inner anor-entrance - location
    shortcut-key - key
    sen-guard1 sen-guard2 - minor-enemy
    iron-golem - boss

    hp0 hp1 hp2 hp3 - hp-level
    w0 w1 w2 - wlevel
    pl0 pl1 - player-level
    bp0 bp1 bp2 bp3 bp4 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 - soul-level
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
    (boss-phase iron-golem bp4)
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

    ;; souls gain from minor enemies (saturating)
    (soul-after-drop sen-guard1 s0 s1) (soul-after-drop sen-guard1 s1 s2) (soul-after-drop sen-guard1 s2 s3) (soul-after-drop sen-guard1 s3 s4) (soul-after-drop sen-guard1 s4 s5) (soul-after-drop sen-guard1 s5 s6) (soul-after-drop sen-guard1 s6 s6)
    (soul-after-drop sen-guard2 s0 s1) (soul-after-drop sen-guard2 s1 s2) (soul-after-drop sen-guard2 s2 s3) (soul-after-drop sen-guard2 s3 s4) (soul-after-drop sen-guard2 s4 s5) (soul-after-drop sen-guard2 s5 s6) (soul-after-drop sen-guard2 s6 s6)

    ;; souls spend for leveling (cost increases per level)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4) (soul-spend-for-level pl0 pl1 s6 s5)

    ;; boss weapon requirements
    (can-damage-boss iron-golem w2)
  )
  (:goal (and
    (not (is-alive iron-golem))
    (deposited-soul iron-golem)
  ))
)

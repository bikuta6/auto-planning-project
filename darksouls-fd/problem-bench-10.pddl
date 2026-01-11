;; BENCHMARK 10-FD: Epic Challenge - Large complex problem
(define (problem bench-10-fd)
  (:domain dark-souls-fd)

  (:objects
    firelink workshop burg parish depths catacombs fortress throne - location
    master-key catacombs-key - key
    hollow bandit skeleton giant - minor-enemy
    gaping-dragon iron-golem final-lord - boss

    hp0 hp1 hp2 hp3 hp4 hp5 hp6 hp7 hp8 hp9 hp10 hp11 hp12 hp13 hp14 hp15 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 bp6 bp7 - boss-phase
    e1 e2 e3 e4 e5 e6 - estus-slot
    s0 s1 s2 s3 s4 s5 - soul-level
  )

  (:init
    ;; -----------------------------
    ;; Map / connectivity
    ;; -----------------------------
    (connected firelink workshop) (connected workshop firelink)
    (connected firelink burg) (connected burg firelink)
    (connected burg parish) (connected parish burg)
    (connected parish depths) (connected depths parish)
    (connected firelink catacombs) (connected catacombs firelink)
    (connected catacombs fortress) (connected fortress catacombs)
    (connected fortress throne) (connected throne fortress)

    (locked parish depths) (locked depths parish)
    (locked catacombs fortress) (locked fortress catacombs)

    (can-open-shortcut parish firelink)
    (can-open-shortcut fortress catacombs)

    (is-firelink firelink)
    (has-bonfire firelink) (has-bonfire parish) (has-bonfire fortress)
    (is-blacksmith workshop)

    ;; -----------------------------
    ;; Keys / items
    ;; -----------------------------
    (key-at master-key burg)
    (key-at catacombs-key depths)

    (matches master-key parish depths)
    (matches catacombs-key catacombs fortress)

    (titanite-at workshop)

    ;; -----------------------------
    ;; Enemies / bosses
    ;; -----------------------------
    (enemy-at hollow burg)
    (enemy-at bandit parish)
    (enemy-at skeleton catacombs)
    (enemy-at giant fortress)

    (is-alive hollow) (is-alive bandit) (is-alive skeleton) (is-alive giant)

    (enemy-at gaping-dragon depths)
    (enemy-at iron-golem fortress)
    (enemy-at final-lord throne)

    (is-alive gaping-dragon) (is-alive iron-golem) (is-alive final-lord)

    (has-active-boss depths)
    (has-active-boss fortress)
    (has-active-boss throne)

    ;; -----------------------------
    ;; Player state
    ;; -----------------------------
    (at-player firelink)
    (last-rested-bonfire firelink)

    ;; -----------------------------
    ;; HP ladder + death marker
    ;; -----------------------------
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5)
    (hp-next hp5 hp6) (hp-next hp6 hp7) (hp-next hp7 hp8) (hp-next hp8 hp9) (hp-next hp9 hp10)
    (hp-next hp10 hp11) (hp-next hp11 hp12) (hp-next hp12 hp13) (hp-next hp13 hp14) (hp-next hp14 hp15)

    (hp-zero hp0)

    ;; player HP starts at 10, but max-hp can reach 15 via level-up-stats
    (player-max-hp hp10)
    (player-hp hp10)

    ;; -----------------------------
    ;; HP-HEAL table: Estus heals +5, capped by max-hp ?m
    ;; (hp-heal ?m ?h_before ?h_after)
    ;; -----------------------------

    ;; max = hp10
    (hp-heal hp10 hp0 hp5)  (hp-heal hp10 hp1 hp6)  (hp-heal hp10 hp2 hp7)  (hp-heal hp10 hp3 hp8)  (hp-heal hp10 hp4 hp9)
    (hp-heal hp10 hp5 hp10) (hp-heal hp10 hp6 hp10) (hp-heal hp10 hp7 hp10) (hp-heal hp10 hp8 hp10) (hp-heal hp10 hp9 hp10)
    (hp-heal hp10 hp10 hp10) (hp-heal hp10 hp11 hp10) (hp-heal hp10 hp12 hp10) (hp-heal hp10 hp13 hp10) (hp-heal hp10 hp14 hp10) (hp-heal hp10 hp15 hp10)

    ;; max = hp11
    (hp-heal hp11 hp0 hp5)  (hp-heal hp11 hp1 hp6)  (hp-heal hp11 hp2 hp7)  (hp-heal hp11 hp3 hp8)  (hp-heal hp11 hp4 hp9)
    (hp-heal hp11 hp5 hp10) (hp-heal hp11 hp6 hp11) (hp-heal hp11 hp7 hp11) (hp-heal hp11 hp8 hp11) (hp-heal hp11 hp9 hp11)
    (hp-heal hp11 hp10 hp11) (hp-heal hp11 hp11 hp11) (hp-heal hp11 hp12 hp11) (hp-heal hp11 hp13 hp11) (hp-heal hp11 hp14 hp11) (hp-heal hp11 hp15 hp11)

    ;; max = hp12
    (hp-heal hp12 hp0 hp5)  (hp-heal hp12 hp1 hp6)  (hp-heal hp12 hp2 hp7)  (hp-heal hp12 hp3 hp8)  (hp-heal hp12 hp4 hp9)
    (hp-heal hp12 hp5 hp10) (hp-heal hp12 hp6 hp11) (hp-heal hp12 hp7 hp12) (hp-heal hp12 hp8 hp12) (hp-heal hp12 hp9 hp12)
    (hp-heal hp12 hp10 hp12) (hp-heal hp12 hp11 hp12) (hp-heal hp12 hp12 hp12) (hp-heal hp12 hp13 hp12) (hp-heal hp12 hp14 hp12) (hp-heal hp12 hp15 hp12)

    ;; max = hp13
    (hp-heal hp13 hp0 hp5)  (hp-heal hp13 hp1 hp6)  (hp-heal hp13 hp2 hp7)  (hp-heal hp13 hp3 hp8)  (hp-heal hp13 hp4 hp9)
    (hp-heal hp13 hp5 hp10) (hp-heal hp13 hp6 hp11) (hp-heal hp13 hp7 hp12) (hp-heal hp13 hp8 hp13) (hp-heal hp13 hp9 hp13)
    (hp-heal hp13 hp10 hp13) (hp-heal hp13 hp11 hp13) (hp-heal hp13 hp12 hp13) (hp-heal hp13 hp13 hp13) (hp-heal hp13 hp14 hp13) (hp-heal hp13 hp15 hp13)

    ;; max = hp14
    (hp-heal hp14 hp0 hp5)  (hp-heal hp14 hp1 hp6)  (hp-heal hp14 hp2 hp7)  (hp-heal hp14 hp3 hp8)  (hp-heal hp14 hp4 hp9)
    (hp-heal hp14 hp5 hp10) (hp-heal hp14 hp6 hp11) (hp-heal hp14 hp7 hp12) (hp-heal hp14 hp8 hp13) (hp-heal hp14 hp9 hp14)
    (hp-heal hp14 hp10 hp14) (hp-heal hp14 hp11 hp14) (hp-heal hp14 hp12 hp14) (hp-heal hp14 hp13 hp14) (hp-heal hp14 hp14 hp14) (hp-heal hp14 hp15 hp14)

    ;; max = hp15
    (hp-heal hp15 hp0 hp5)  (hp-heal hp15 hp1 hp6)  (hp-heal hp15 hp2 hp7)  (hp-heal hp15 hp3 hp8)  (hp-heal hp15 hp4 hp9)
    (hp-heal hp15 hp5 hp10) (hp-heal hp15 hp6 hp11) (hp-heal hp15 hp7 hp12) (hp-heal hp15 hp8 hp13) (hp-heal hp15 hp9 hp14)
    (hp-heal hp15 hp10 hp15) (hp-heal hp15 hp11 hp15) (hp-heal hp15 hp12 hp15) (hp-heal hp15 hp13 hp15) (hp-heal hp15 hp14 hp15) (hp-heal hp15 hp15 hp15)

    ;; -----------------------------
    ;; Player progression / weapon
    ;; -----------------------------
    (player-current-level pl0)
    (player-level-next pl0 pl1) (player-level-next pl1 pl2) (player-level-next pl2 pl3)
    (player-level-next pl3 pl4) (player-level-next pl4 pl5)

    (player-weapon-level w0)
    (wlevel-next w0 w1)

    ;; -----------------------------
    ;; Boss phases
    ;; -----------------------------
    (boss-phase-zero bp0)

    (boss-phase-next bp6 bp5) (boss-phase-next bp5 bp4) (boss-phase-next bp4 bp3)
    (boss-phase-next bp3 bp2) (boss-phase-next bp2 bp1) (boss-phase-next bp1 bp0)
    (boss-phase-next bp7 bp6)

    (boss-max-phase gaping-dragon bp6) (boss-current-phase gaping-dragon bp6)
    (boss-max-phase iron-golem bp6)    (boss-current-phase iron-golem bp6)
    (boss-max-phase final-lord bp7)    (boss-current-phase final-lord bp7)

    ;; -----------------------------
    ;; Estus
    ;; -----------------------------
    (estus-unlocked e1) (estus-full e1)
    (estus-unlocked e2) (estus-full e2)
    (estus-unlocked e3) (estus-full e3)

    ;; -----------------------------
    ;; Souls ladder
    ;; -----------------------------
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5)
    (player-max-souls s5)
    (player-souls s0)
    (soul-min s0)

    ;; enemy drops (saturating)
    (soul-after-drop hollow s0 s2) (soul-after-drop hollow s1 s3) (soul-after-drop hollow s2 s4) (soul-after-drop hollow s3 s5) (soul-after-drop hollow s4 s5) (soul-after-drop hollow s5 s5)
    (soul-after-drop bandit s0 s2) (soul-after-drop bandit s1 s3) (soul-after-drop bandit s2 s4) (soul-after-drop bandit s3 s5) (soul-after-drop bandit s4 s5) (soul-after-drop bandit s5 s5)
    (soul-after-drop skeleton s0 s2) (soul-after-drop skeleton s1 s3) (soul-after-drop skeleton s2 s4) (soul-after-drop skeleton s3 s5) (soul-after-drop skeleton s4 s5) (soul-after-drop skeleton s5 s5)
    (soul-after-drop giant s0 s2) (soul-after-drop giant s1 s3) (soul-after-drop giant s2 s4) (soul-after-drop giant s3 s5) (soul-after-drop giant s4 s5) (soul-after-drop giant s5 s5)

    (soul-after-drop gaping-dragon s0 s4) (soul-after-drop gaping-dragon s1 s5) (soul-after-drop gaping-dragon s2 s5) (soul-after-drop gaping-dragon s3 s5) (soul-after-drop gaping-dragon s4 s5) (soul-after-drop gaping-dragon s5 s5)
    (soul-after-drop iron-golem s0 s4)    (soul-after-drop iron-golem s1 s5)    (soul-after-drop iron-golem s2 s5)    (soul-after-drop iron-golem s3 s5)    (soul-after-drop iron-golem s4 s5)    (soul-after-drop iron-golem s5 s5)
    (soul-after-drop final-lord s0 s5)    (soul-after-drop final-lord s1 s5)    (soul-after-drop final-lord s2 s5)    (soul-after-drop final-lord s3 s5)    (soul-after-drop final-lord s4 s5)    (soul-after-drop final-lord s5 s5)

    ;; spend souls for leveling (cost grows)
    (soul-spend-for-level pl0 pl1 s1 s0) (soul-spend-for-level pl0 pl1 s2 s1) (soul-spend-for-level pl0 pl1 s3 s2) (soul-spend-for-level pl0 pl1 s4 s3) (soul-spend-for-level pl0 pl1 s5 s4)
    (soul-spend-for-level pl1 pl2 s2 s0) (soul-spend-for-level pl1 pl2 s3 s1) (soul-spend-for-level pl1 pl2 s4 s2) (soul-spend-for-level pl1 pl2 s5 s3)
    (soul-spend-for-level pl2 pl3 s3 s0) (soul-spend-for-level pl2 pl3 s4 s1) (soul-spend-for-level pl2 pl3 s5 s2)
    (soul-spend-for-level pl3 pl4 s4 s0) (soul-spend-for-level pl3 pl4 s5 s1)
    (soul-spend-for-level pl4 pl5 s5 s0)

    ;; -----------------------------
    ;; Damage model (hp-after-attack)
    ;; -----------------------------
    ;; bandit: -1 each hit
    (hp-after-attack bandit hp15 hp14) (hp-after-attack bandit hp14 hp13) (hp-after-attack bandit hp13 hp12) (hp-after-attack bandit hp12 hp11)
    (hp-after-attack bandit hp11 hp10) (hp-after-attack bandit hp10 hp9)  (hp-after-attack bandit hp9 hp8)   (hp-after-attack bandit hp8 hp7)
    (hp-after-attack bandit hp7 hp6)   (hp-after-attack bandit hp6 hp5)   (hp-after-attack bandit hp5 hp4)   (hp-after-attack bandit hp4 hp3)
    (hp-after-attack bandit hp3 hp2)   (hp-after-attack bandit hp2 hp1)   (hp-after-attack bandit hp1 hp0)

    ;; final-lord: -2 per hit-ish (as you defined)
    (hp-after-attack final-lord hp15 hp13) (hp-after-attack final-lord hp14 hp12) (hp-after-attack final-lord hp13 hp11)
    (hp-after-attack final-lord hp12 hp10) (hp-after-attack final-lord hp11 hp9)  (hp-after-attack final-lord hp10 hp8)
    (hp-after-attack final-lord hp9 hp7)   (hp-after-attack final-lord hp8 hp6)   (hp-after-attack final-lord hp7 hp5)
    (hp-after-attack final-lord hp6 hp4)   (hp-after-attack final-lord hp5 hp3)   (hp-after-attack final-lord hp4 hp2)
    (hp-after-attack final-lord hp3 hp1)   (hp-after-attack final-lord hp2 hp0)   (hp-after-attack final-lord hp1 hp0)

    ;; gaping-dragon: -1 each hit
    (hp-after-attack gaping-dragon hp15 hp14) (hp-after-attack gaping-dragon hp14 hp13) (hp-after-attack gaping-dragon hp13 hp12)
    (hp-after-attack gaping-dragon hp12 hp11) (hp-after-attack gaping-dragon hp11 hp10) (hp-after-attack gaping-dragon hp10 hp9)
    (hp-after-attack gaping-dragon hp9 hp8)   (hp-after-attack gaping-dragon hp8 hp7)   (hp-after-attack gaping-dragon hp7 hp6)
    (hp-after-attack gaping-dragon hp6 hp5)   (hp-after-attack gaping-dragon hp5 hp4)   (hp-after-attack gaping-dragon hp4 hp3)
    (hp-after-attack gaping-dragon hp3 hp2)   (hp-after-attack gaping-dragon hp2 hp1)   (hp-after-attack gaping-dragon hp1 hp0)

    ;; giant: -2 per hit-ish
    (hp-after-attack giant hp15 hp13) (hp-after-attack giant hp14 hp12) (hp-after-attack giant hp13 hp11)
    (hp-after-attack giant hp12 hp10) (hp-after-attack giant hp11 hp9)  (hp-after-attack giant hp10 hp8)
    (hp-after-attack giant hp9 hp7)   (hp-after-attack giant hp8 hp6)   (hp-after-attack giant hp7 hp5)
    (hp-after-attack giant hp6 hp4)   (hp-after-attack giant hp5 hp3)   (hp-after-attack giant hp4 hp2)
    (hp-after-attack giant hp3 hp1)   (hp-after-attack giant hp2 hp0)   (hp-after-attack giant hp1 hp0)

    ;; hollow: -1 each hit
    (hp-after-attack hollow hp15 hp14) (hp-after-attack hollow hp14 hp13) (hp-after-attack hollow hp13 hp12) (hp-after-attack hollow hp12 hp11)
    (hp-after-attack hollow hp11 hp10) (hp-after-attack hollow hp10 hp9)  (hp-after-attack hollow hp9 hp8)   (hp-after-attack hollow hp8 hp7)
    (hp-after-attack hollow hp7 hp6)   (hp-after-attack hollow hp6 hp5)   (hp-after-attack hollow hp5 hp4)   (hp-after-attack hollow hp4 hp3)
    (hp-after-attack hollow hp3 hp2)   (hp-after-attack hollow hp2 hp1)   (hp-after-attack hollow hp1 hp0)

    ;; iron-golem: -2 per hit-ish
    (hp-after-attack iron-golem hp15 hp13) (hp-after-attack iron-golem hp14 hp12) (hp-after-attack iron-golem hp13 hp11)
    (hp-after-attack iron-golem hp12 hp10) (hp-after-attack iron-golem hp11 hp9)  (hp-after-attack iron-golem hp10 hp8)
    (hp-after-attack iron-golem hp9 hp7)   (hp-after-attack iron-golem hp8 hp6)   (hp-after-attack iron-golem hp7 hp5)
    (hp-after-attack iron-golem hp6 hp4)   (hp-after-attack iron-golem hp5 hp3)   (hp-after-attack iron-golem hp4 hp2)
    (hp-after-attack iron-golem hp3 hp1)   (hp-after-attack iron-golem hp2 hp0)   (hp-after-attack iron-golem hp1 hp0)

    ;; skeleton: -1 each hit
    (hp-after-attack skeleton hp15 hp14) (hp-after-attack skeleton hp14 hp13) (hp-after-attack skeleton hp13 hp12)
    (hp-after-attack skeleton hp12 hp11) (hp-after-attack skeleton hp11 hp10) (hp-after-attack skeleton hp10 hp9)
    (hp-after-attack skeleton hp9 hp8)   (hp-after-attack skeleton hp8 hp7)   (hp-after-attack skeleton hp7 hp6)
    (hp-after-attack skeleton hp6 hp5)   (hp-after-attack skeleton hp5 hp4)   (hp-after-attack skeleton hp4 hp3)
    (hp-after-attack skeleton hp3 hp2)   (hp-after-attack skeleton hp2 hp1)   (hp-after-attack skeleton hp1 hp0)

    ;; -----------------------------
    ;; Weapon gates for bosses
    ;; -----------------------------
    (can-damage-boss gaping-dragon w0)
    (can-damage-boss iron-golem w1)
    (can-damage-boss final-lord w1)

    ;; -----------------------------
    ;; Cost init
    ;; -----------------------------
    (= (total-cost) 0)
  )

  (:goal (and
    (deposited-soul gaping-dragon)
    (deposited-soul iron-golem)
    (deposited-soul final-lord)
  ))

  (:metric minimize (total-cost))
)

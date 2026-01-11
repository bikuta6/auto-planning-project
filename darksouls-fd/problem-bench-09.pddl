;; BENCHMARK 09-FD: Three Bosses with Upgrade
(define (problem bench-09-fd)
  (:domain dark-souls-fd)
  (:objects
    firelink forge east-wing west-wing north-tower - location
    sentinel1 sentinel2 - minor-enemy
    east-guardian west-champion north-tyrant - boss
    hp0 hp1 hp2 hp3 hp4 hp5 hp6 hp7 hp8 hp9 hp10 - hp-level
    w0 w1 - wlevel
    pl0 pl1 pl2 pl3 pl4 pl5 - player-level
    bp0 bp1 bp2 bp3 bp4 bp5 bp6 - boss-phase
    e1 e2 e3 e4 - estus-slot
    s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 - soul-level
  )
  (:init
    (connected firelink forge) (connected forge firelink)
    (connected firelink east-wing) (connected east-wing firelink)
    (connected firelink west-wing) (connected west-wing firelink)
    (connected firelink north-tower) (connected north-tower firelink)
    (is-firelink firelink) (has-bonfire firelink) (is-blacksmith forge)
    (titanite-at forge)
    (enemy-at sentinel1 east-wing) (enemy-at sentinel2 west-wing)
    (is-alive sentinel1) (is-alive sentinel2)
    (enemy-at east-guardian east-wing) (enemy-at west-champion west-wing) (enemy-at north-tyrant north-tower)
    (is-alive east-guardian) (is-alive west-champion) (is-alive north-tyrant)
    (has-active-boss east-wing) (has-active-boss west-wing) (has-active-boss north-tower)
    (at-player firelink) (last-rested-bonfire firelink)
    (hp-next hp0 hp1) (hp-next hp1 hp2) (hp-next hp2 hp3) (hp-next hp3 hp4) (hp-next hp4 hp5) (hp-next hp5 hp6) (hp-next hp6 hp7) (hp-next hp7 hp8) (hp-next hp8 hp9) (hp-next hp9 hp10)
    (hp-zero hp0)
    ;; HP-HEAL table: Estus heals +5, capped by max-hp ?m
    ;; (hp-heal ?m ?h_before ?h_after)
    ;; ---------------------------------------------
    ;; max = hp0
    (hp-heal hp0 hp0 hp0) (hp-heal hp0 hp1 hp0) (hp-heal hp0 hp2 hp0) (hp-heal hp0 hp3 hp0) (hp-heal hp0 hp4 hp0)
    (hp-heal hp0 hp5 hp0) (hp-heal hp0 hp6 hp0) (hp-heal hp0 hp7 hp0) (hp-heal hp0 hp8 hp0) (hp-heal hp0 hp9 hp0)
    (hp-heal hp0 hp10 hp0)
    ;; max = hp1
    (hp-heal hp1 hp0 hp1) (hp-heal hp1 hp1 hp1) (hp-heal hp1 hp2 hp1) (hp-heal hp1 hp3 hp1) (hp-heal hp1 hp4 hp1)
    (hp-heal hp1 hp5 hp1) (hp-heal hp1 hp6 hp1) (hp-heal hp1 hp7 hp1) (hp-heal hp1 hp8 hp1) (hp-heal hp1 hp9 hp1)
    (hp-heal hp1 hp10 hp1)
    ;; max = hp2
    (hp-heal hp2 hp0 hp2) (hp-heal hp2 hp1 hp2) (hp-heal hp2 hp2 hp2) (hp-heal hp2 hp3 hp2) (hp-heal hp2 hp4 hp2)
    (hp-heal hp2 hp5 hp2) (hp-heal hp2 hp6 hp2) (hp-heal hp2 hp7 hp2) (hp-heal hp2 hp8 hp2) (hp-heal hp2 hp9 hp2)
    (hp-heal hp2 hp10 hp2)
    ;; max = hp3
    (hp-heal hp3 hp0 hp3) (hp-heal hp3 hp1 hp3) (hp-heal hp3 hp2 hp3) (hp-heal hp3 hp3 hp3) (hp-heal hp3 hp4 hp3)
    (hp-heal hp3 hp5 hp3) (hp-heal hp3 hp6 hp3) (hp-heal hp3 hp7 hp3) (hp-heal hp3 hp8 hp3) (hp-heal hp3 hp9 hp3)
    (hp-heal hp3 hp10 hp3)
    ;; max = hp4
    (hp-heal hp4 hp0 hp4) (hp-heal hp4 hp1 hp4) (hp-heal hp4 hp2 hp4) (hp-heal hp4 hp3 hp4) (hp-heal hp4 hp4 hp4)
    (hp-heal hp4 hp5 hp4) (hp-heal hp4 hp6 hp4) (hp-heal hp4 hp7 hp4) (hp-heal hp4 hp8 hp4) (hp-heal hp4 hp9 hp4)
    (hp-heal hp4 hp10 hp4)
    ;; max = hp5
    (hp-heal hp5 hp0 hp5) (hp-heal hp5 hp1 hp5) (hp-heal hp5 hp2 hp5) (hp-heal hp5 hp3 hp5) (hp-heal hp5 hp4 hp5)
    (hp-heal hp5 hp5 hp5) (hp-heal hp5 hp6 hp5) (hp-heal hp5 hp7 hp5) (hp-heal hp5 hp8 hp5) (hp-heal hp5 hp9 hp5)
    (hp-heal hp5 hp10 hp5)
    ;; max = hp6
    (hp-heal hp6 hp0 hp5) (hp-heal hp6 hp1 hp6) (hp-heal hp6 hp2 hp6) (hp-heal hp6 hp3 hp6) (hp-heal hp6 hp4 hp6)
    (hp-heal hp6 hp5 hp6) (hp-heal hp6 hp6 hp6) (hp-heal hp6 hp7 hp6) (hp-heal hp6 hp8 hp6) (hp-heal hp6 hp9 hp6)
    (hp-heal hp6 hp10 hp6)
    ;; max = hp7
    (hp-heal hp7 hp0 hp5) (hp-heal hp7 hp1 hp6) (hp-heal hp7 hp2 hp7) (hp-heal hp7 hp3 hp7) (hp-heal hp7 hp4 hp7)
    (hp-heal hp7 hp5 hp7) (hp-heal hp7 hp6 hp7) (hp-heal hp7 hp7 hp7) (hp-heal hp7 hp8 hp7) (hp-heal hp7 hp9 hp7)
    (hp-heal hp7 hp10 hp7)
    ;; max = hp8
    (hp-heal hp8 hp0 hp5) (hp-heal hp8 hp1 hp6) (hp-heal hp8 hp2 hp7) (hp-heal hp8 hp3 hp8) (hp-heal hp8 hp4 hp8)
    (hp-heal hp8 hp5 hp8) (hp-heal hp8 hp6 hp8) (hp-heal hp8 hp7 hp8) (hp-heal hp8 hp8 hp8) (hp-heal hp8 hp9 hp8)
    (hp-heal hp8 hp10 hp8)
    ;; max = hp9
    (hp-heal hp9 hp0 hp5) (hp-heal hp9 hp1 hp6) (hp-heal hp9 hp2 hp7) (hp-heal hp9 hp3 hp8) (hp-heal hp9 hp4 hp9)
    (hp-heal hp9 hp5 hp9) (hp-heal hp9 hp6 hp9) (hp-heal hp9 hp7 hp9) (hp-heal hp9 hp8 hp9) (hp-heal hp9 hp9 hp9)
    (hp-heal hp9 hp10 hp9)
    ;; max = hp10
    (hp-heal hp10 hp0 hp5) (hp-heal hp10 hp1 hp6) (hp-heal hp10 hp2 hp7) (hp-heal hp10 hp3 hp8) (hp-heal hp10 hp4 hp9)
    (hp-heal hp10 hp5 hp10) (hp-heal hp10 hp6 hp10) (hp-heal hp10 hp7 hp10) (hp-heal hp10 hp8 hp10) (hp-heal hp10 hp9 hp10)
    (hp-heal hp10 hp10 hp10)
    ;; HP-HEAL table: Estus heals +5, capped by max-hp ?m
    ;; ---------------------------------------------
    ;; max = hp10
    ;; Niveles del Jugador
    (player-max-hp hp5) (player-hp hp5)
    (player-current-level pl0) (player-level-next pl0 pl1) (player-level-next pl1 pl2) (player-level-next pl2 pl3) (player-level-next pl3 pl4) (player-level-next pl4 pl5)
    (player-weapon-level w0) (wlevel-next w0 w1)
    (boss-phase-zero bp0)
    (boss-phase-next bp5 bp4) (boss-phase-next bp4 bp3) (boss-phase-next bp3 bp2) (boss-phase-next bp2 bp1) (boss-phase-next bp1 bp0)
    (boss-phase-next bp6 bp5)
    (boss-max-phase east-guardian bp5) (boss-current-phase east-guardian bp5)
    (boss-max-phase west-champion bp5) (boss-current-phase west-champion bp5)
    (boss-max-phase north-tyrant bp6) (boss-current-phase north-tyrant bp6)
    (estus-unlocked e1) (estus-full e1)
    (soul-next s0 s1) (soul-next s1 s2) (soul-next s2 s3) (soul-next s3 s4) (soul-next s4 s5) (soul-next s5 s6) (soul-next s6 s7) (soul-next s7 s8) (soul-next s8 s9)
    ;; Souls lader
    (player-max-souls s9) (player-souls s0) (soul-min s0)
    (hp-after-attack sentinel1 hp10 hp9) (hp-after-attack sentinel1 hp9 hp8) (hp-after-attack sentinel1 hp8 hp7) (hp-after-attack sentinel1 hp7 hp6) (hp-after-attack sentinel1 hp6 hp5) (hp-after-attack sentinel1 hp5 hp4) (hp-after-attack sentinel1 hp4 hp3) (hp-after-attack sentinel1 hp3 hp2) (hp-after-attack sentinel1 hp2 hp1) (hp-after-attack sentinel1 hp1 hp0)
    (hp-after-attack sentinel2 hp10 hp9) (hp-after-attack sentinel2 hp9 hp8) (hp-after-attack sentinel2 hp8 hp7) (hp-after-attack sentinel2 hp7 hp6) (hp-after-attack sentinel2 hp6 hp5) (hp-after-attack sentinel2 hp5 hp4) (hp-after-attack sentinel2 hp4 hp3) (hp-after-attack sentinel2 hp3 hp2) (hp-after-attack sentinel2 hp2 hp1) (hp-after-attack sentinel2 hp1 hp0)
    (hp-after-attack east-guardian hp10 hp9) (hp-after-attack east-guardian hp9 hp8) (hp-after-attack east-guardian hp8 hp7) (hp-after-attack east-guardian hp7 hp6) (hp-after-attack east-guardian hp6 hp5) (hp-after-attack east-guardian hp5 hp4) (hp-after-attack east-guardian hp4 hp3) (hp-after-attack east-guardian hp3 hp2) (hp-after-attack east-guardian hp2 hp1) (hp-after-attack east-guardian hp1 hp0)
    (hp-after-attack west-champion hp10 hp9) (hp-after-attack west-champion hp9 hp8) (hp-after-attack west-champion hp8 hp7) (hp-after-attack west-champion hp7 hp6) (hp-after-attack west-champion hp6 hp5) (hp-after-attack west-champion hp5 hp4) (hp-after-attack west-champion hp4 hp3) (hp-after-attack west-champion hp3 hp2) (hp-after-attack west-champion hp2 hp1) (hp-after-attack west-champion hp1 hp0)
    (hp-after-attack north-tyrant hp10 hp9) (hp-after-attack north-tyrant hp9 hp8) (hp-after-attack north-tyrant hp8 hp7) (hp-after-attack north-tyrant hp7 hp6) (hp-after-attack north-tyrant hp6 hp5) (hp-after-attack north-tyrant hp5 hp4) (hp-after-attack north-tyrant hp4 hp3) (hp-after-attack north-tyrant hp3 hp2) (hp-after-attack north-tyrant hp2 hp1) (hp-after-attack north-tyrant hp1 hp0)
    (soul-after-drop sentinel1 s0 s2) (soul-after-drop sentinel1 s1 s3) (soul-after-drop sentinel1 s2 s4) (soul-after-drop sentinel1 s3 s5) (soul-after-drop sentinel1 s4 s6) (soul-after-drop sentinel1 s5 s7) (soul-after-drop sentinel1 s6 s8) (soul-after-drop sentinel1 s7 s9) (soul-after-drop sentinel1 s8 s9) (soul-after-drop sentinel1 s9 s9)
    (soul-after-drop sentinel2 s0 s2) (soul-after-drop sentinel2 s1 s3) (soul-after-drop sentinel2 s2 s4) (soul-after-drop sentinel2 s3 s5) (soul-after-drop sentinel2 s4 s6) (soul-after-drop sentinel2 s5 s7) (soul-after-drop sentinel2 s6 s8) (soul-after-drop sentinel2 s7 s9) (soul-after-drop sentinel2 s8 s9) (soul-after-drop sentinel2 s9 s9)
    (soul-after-drop east-guardian s0 s3) (soul-after-drop east-guardian s1 s4) (soul-after-drop east-guardian s2 s5) (soul-after-drop east-guardian s3 s6) (soul-after-drop east-guardian s4 s7) (soul-after-drop east-guardian s5 s8) (soul-after-drop east-guardian s6 s9) (soul-after-drop east-guardian s7 s9) (soul-after-drop east-guardian s8 s9) (soul-after-drop east-guardian s9 s9)
    (soul-after-drop west-champion s0 s3) (soul-after-drop west-champion s1 s4) (soul-after-drop west-champion s2 s5) (soul-after-drop west-champion s3 s6) (soul-after-drop west-champion s4 s7) (soul-after-drop west-champion s5 s8) (soul-after-drop west-champion s6 s9) (soul-after-drop west-champion s7 s9) (soul-after-drop west-champion s8 s9) (soul-after-drop west-champion s9 s9)
    (soul-after-drop north-tyrant s0 s4) (soul-after-drop north-tyrant s1 s5) (soul-after-drop north-tyrant s2 s6) (soul-after-drop north-tyrant s3 s7) (soul-after-drop north-tyrant s4 s8) (soul-after-drop north-tyrant s5 s9) (soul-after-drop north-tyrant s6 s9) (soul-after-drop north-tyrant s7 s9) (soul-after-drop north-tyrant s8 s9) (soul-after-drop north-tyrant s9 s9)
    (soul-spend-for-level pl0 pl1 s2 s0) (soul-spend-for-level pl0 pl1 s3 s1) (soul-spend-for-level pl0 pl1 s4 s2) (soul-spend-for-level pl0 pl1 s5 s3) (soul-spend-for-level pl0 pl1 s6 s4) (soul-spend-for-level pl0 pl1 s7 s5) (soul-spend-for-level pl0 pl1 s8 s6) (soul-spend-for-level pl0 pl1 s9 s7)
    (can-damage-boss east-guardian w0)
    (can-damage-boss west-champion w0)
    (can-damage-boss north-tyrant w1)
    (= (total-cost) 0)
  )
  (:goal (and
    (deposited-soul east-guardian)
    (deposited-soul west-champion)
    (deposited-soul north-tyrant)
  ))
  (:metric minimize (total-cost))
)

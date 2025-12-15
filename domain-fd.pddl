;; =================================================================
;; DOMINIO DARK SOULS (FAST DOWNWARD / SIN NUMERIC)
;; =================================================================
;; Compilación proposicional del dominio original para planificadores
;; que NO aceptan :fluents ni funciones numéricas.
;;
;; Idea:
;; - Sustituimos todos los valores numéricos (salud, daño, almas, estus,
;;   nivel de arma, etc.) por OBJETOS finitos y PREDICADOS.
;; - Las "operaciones" (restar vida, curar, subir arma, subir nivel)
;;   se codifican mediante relaciones estáticas en el problema:
;;     (hp-next h1 h2), (wlevel-next w0 w1), (hp-after-attack e h h2), ...
;;
;; Nota: Para mantener compatibilidad amplia, este dominio evita funciones.
;; Mantiene mecánicas: subir nivel, descansar, revivir, jefes, mejorar arma,
;; curación con estus.
;; =================================================================

(define (domain dark-souls-fd)
  (:requirements :strips :typing :negative-preconditions :adl)

  (:types
    location - object
    enemy - object
    boss minor-enemy - enemy
    key - object

    ;; niveles discretos
    hp-level - object
    wlevel - object
    player-level - object

    ;; fases discretas para jefes (nº de golpes restantes)
    boss-phase - object

    ;; estus como "slots" discretos (cada slot es una carga)
    estus-slot - object

    ;; almas como niveles discretos (tipo HP, con máximo)
    soul-level - object
  )

  (:predicates
    ;; Mapa / navegación
    (connected ?from ?to - location)
    (at-player ?loc - location)
    (is-firelink ?loc - location)
    (has-bonfire ?loc - location)
    (is-blacksmith ?loc - location)

    ;; Llaves / puertas
    (locked ?from ?to - location)
    (has-key ?k - key)
    (key-at ?k - key ?loc - location)
    (matches ?k - key ?from ?to - location)
    (can-open-shortcut ?from ?to - location)

    ;; Titanita
    (has-titanite)
    (titanite-at ?loc - location)

    ;; Enemigos
    (enemy-at ?e - enemy ?loc - location)
    (is-alive ?e - enemy)
    (weakened ?e - enemy)
    (has-active-boss ?loc - location)

    ;; Almas de jefe
    (has-boss-soul ?b - boss)
    (deposited-soul ?b - boss)

    ;; Progresión discreta
    (player-hp ?h - hp-level)
    (player-max-hp ?h - hp-level)
    (hp-next ?h1 ?h2 - hp-level)                  ;; sucesor (curación/level-up)
    (hp-leq ?h ?m - hp-level)                     ;; tabla: h <= m (no sobrecurar)
    (hp-zero ?h - hp-level)                        ;; marca el nivel de HP "muerte" (p.ej., hp0)
    (hp-after-attack ?e - enemy ?h1 ?h2 - hp-level) ;; cómo queda la vida tras atacar a ?e

    (player-dead)                                  ;; estado terminal: no puedes actuar

    ;; jefe: contador de golpes
    (boss-phase ?b - boss ?p - boss-phase)
    (boss-phase-next ?p1 ?p2 - boss-phase)         ;; decremento: p1 -> p2
    (boss-max-phase ?b - boss ?p - boss-phase)     ;; fase inicial para resetear al huir
    (boss-phase-zero ?p - boss-phase)              ;; marca la fase 0 (boss listo para rematar)

    (player-weapon-level ?w - wlevel)
    (wlevel-next ?w1 ?w2 - wlevel)
    (can-damage-boss ?b - boss ?w - wlevel)       ;; tabla: qué niveles de arma pueden dañar al jefe

    (player-level ?l - player-level)
    (player-level-next ?l1 ?l2 - player-level)

    ;; Estus
    (estus-unlocked ?s - estus-slot)              ;; forma parte del máximo
    (estus-full ?s - estus-slot)                  ;; carga disponible

    ;; Souls (moneda) como nivel discreto (tipo HP)
    (player-souls ?s - soul-level)
    (player-max-souls ?s - soul-level)
    (soul-next ?s1 ?s2 - soul-level)
    ;; tabla de ganancia al ejecutar un enemigo: s1 -> s2 (debe saturar en el máximo)
    (soul-after-drop ?e - enemy ?s1 ?s2 - soul-level)
    ;; tabla de gasto por subir nivel: desde l1 a l2, s1 -> s2 (coste creciente por nivel)
    (soul-spend-for-level ?l1 ?l2 - player-level ?s1 ?s2 - soul-level)
  )

  ;; =================================================================
  ;; MOVIMIENTO
  ;; =================================================================

  (:action move
    :parameters (?from ?to - location)
    :precondition (and
      (at-player ?from)
      (not (player-dead))
      (connected ?from ?to)
      (not (locked ?from ?to))
      (not (has-active-boss ?from))
    )
    :effect (and
      (not (at-player ?from))
      (at-player ?to)
    )
  )

  (:action flee-boss
    :parameters (?from ?to - location ?b - boss ?pmax - boss-phase)
    :precondition (and
      (at-player ?from)
      (not (player-dead))
      (connected ?from ?to)
      (not (locked ?from ?to))
      (has-active-boss ?from)
      (enemy-at ?b ?from)
      (is-alive ?b)
      (boss-max-phase ?b ?pmax)
    )
    :effect (and
      (not (at-player ?from))
      (at-player ?to)
      ;; huir resetea el contador de golpes del jefe
      (forall (?p - boss-phase)
        (when (boss-phase ?b ?p)
          (not (boss-phase ?b ?p))
        )
      )
      (boss-phase ?b ?pmax)
    )
  )

  ;; =================================================================
  ;; INVENTARIO / EXPLORACIÓN
  ;; =================================================================

  (:action pick-up-key
    :parameters (?k - key ?loc - location)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (key-at ?k ?loc)
    )
    :effect (and
      (not (key-at ?k ?loc))
      (has-key ?k)
    )
  )

  (:action unlock-door
    :parameters (?k - key ?loc - location ?to - location)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (connected ?loc ?to)
      (locked ?loc ?to)
      (has-key ?k)
      (matches ?k ?loc ?to)
    )
    :effect (and
      (not (locked ?loc ?to))
      (not (locked ?to ?loc))
    )
  )

  (:action open-shortcut
    :parameters (?loc - location ?dest - location)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (can-open-shortcut ?loc ?dest)
    )
    :effect (and
      (not (can-open-shortcut ?loc ?dest))
      (connected ?loc ?dest)
      (connected ?dest ?loc)
    )
  )

  (:action pick-up-titanite
    :parameters (?loc - location)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (titanite-at ?loc)
    )
    :effect (and
      (not (titanite-at ?loc))
      (has-titanite)
    )
  )

  ;; =================================================================
  ;; MEJORA DE ARMA
  ;; =================================================================

  (:action upgrade-weapon
    :parameters (?loc - location ?w1 ?w2 - wlevel)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (is-blacksmith ?loc)
      (has-titanite)
      (player-weapon-level ?w1)
      (wlevel-next ?w1 ?w2)
    )
    :effect (and
      (not (has-titanite))
      (not (player-weapon-level ?w1))
      (player-weapon-level ?w2)
    )
  )

  ;; =================================================================
  ;; COMBATE
  ;; =================================================================

  ;; Ataque abstracto: deja al enemigo "weakened" y reduce la vida del jugador
  ;; según tabla (hp-after-attack ?e ?h1 ?h2) definida en el problema.
  (:action attack-minor
    :parameters (?e - minor-enemy ?loc - location ?h1 ?h2 - hp-level)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (enemy-at ?e ?loc)
      (is-alive ?e)
      (not (weakened ?e))
      (player-hp ?h1)
      (hp-after-attack ?e ?h1 ?h2)
    )
    :effect (and
      (not (player-hp ?h1))
      (player-hp ?h2)
      (weakened ?e)
      (when (hp-zero ?h2)
        (player-dead)
      )
    )
  )

  ;; Ataque a jefe: reduce HP del jugador y decrementa la fase del jefe.
  (:action attack-boss
    :parameters (?b - boss ?loc - location ?h1 ?h2 - hp-level ?p1 ?p2 - boss-phase)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (enemy-at ?b ?loc)
      (is-alive ?b)
      (player-hp ?h1)
      (hp-after-attack ?b ?h1 ?h2)
      (boss-phase ?b ?p1)
      (boss-phase-next ?p1 ?p2)
    )
    :effect (and
      (not (player-hp ?h1))
      (player-hp ?h2)
      (not (boss-phase ?b ?p1))
      (boss-phase ?b ?p2)
      (when (hp-zero ?h2)
        (player-dead)
      )
    )
  )

  (:action execute-enemy
    :parameters (?e - enemy ?loc - location ?s1 ?s2 - soul-level)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (enemy-at ?e ?loc)
      (is-alive ?e)
      (weakened ?e)
      (player-souls ?s1)
      (soul-after-drop ?e ?s1 ?s2)
    )
    :effect (and
      (not (is-alive ?e))
      (not (weakened ?e))
      (not (player-souls ?s1))
      (player-souls ?s2)
    )
  )

  ;; Matar jefe: requiere haberlo debilitado y poder dañarlo con tu arma
  ;; (tabla can-damage-boss definida en el problema).
  ;; Además, desbloquea + rellena 1 slot de Estus.
  (:action kill-boss
    :parameters (?b - boss ?loc - location ?w - wlevel ?slot - estus-slot ?p - boss-phase)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (enemy-at ?b ?loc)
      (is-alive ?b)
      (boss-phase ?b ?p)
      (boss-phase-zero ?p)
      (player-weapon-level ?w)
      (can-damage-boss ?b ?w)
      ;; elegimos explícitamente qué slot nuevo desbloquear
      (not (estus-unlocked ?slot))
    )
    :effect (and
      (not (is-alive ?b))
      (forall (?p - boss-phase)
        (when (boss-phase ?b ?p)
          (not (boss-phase ?b ?p))
        )
      )
      (not (has-active-boss ?loc))
      (has-boss-soul ?b)

      (estus-unlocked ?slot)
      (estus-full ?slot)
    )
  )

  ;; =================================================================
  ;; SUPERVIVENCIA
  ;; =================================================================

  (:action drink-estus
    :parameters (?slot - estus-slot ?h1 ?h2 ?m - hp-level)
    :precondition (and
      (estus-unlocked ?slot)
      (estus-full ?slot)
      (player-hp ?h1)
      (not (player-dead))
      (hp-next ?h1 ?h2)
      (player-max-hp ?m)
      (hp-leq ?h2 ?m)
    )
    :effect (and
      (not (estus-full ?slot))
      (not (player-hp ?h1))
      (player-hp ?h2)
    )
  )

  ;; Descansar: cura al máximo, rellena estus, revive enemigos menores.
  (:action rest
    :parameters (?loc - location)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (has-bonfire ?loc)
    )
    :effect (and
      ;; cura: poner player-hp = player-max-hp
      (forall (?h - hp-level ?m - hp-level)
        (when (and (player-hp ?h) (player-max-hp ?m))
          (and (not (player-hp ?h)) (player-hp ?m))
        )
      )

      ;; rellena estus desbloqueados
      (forall (?s - estus-slot)
        (when (estus-unlocked ?s)
          (estus-full ?s)
        )
      )

      ;; revive todos los minor-enemy
      (forall (?m - minor-enemy)
        (when (not (is-alive ?m))
          (and (is-alive ?m) (not (weakened ?m)))
        )
      )
    )
  )

  ;; Subir nivel (bonfire): gasta almas discretas (coste creciente), sube player-level y aumenta max HP (1 paso).
  (:action level-up-stats
    :parameters (?loc - location ?l1 ?l2 - player-level ?m1 ?m2 - hp-level ?s1 ?s2 - soul-level)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (has-bonfire ?loc)
      (player-level ?l1)
      (player-level-next ?l1 ?l2)
      (player-max-hp ?m1)
      (hp-next ?m1 ?m2)
      (player-souls ?s1)
      (soul-spend-for-level ?l1 ?l2 ?s1 ?s2)
    )
    :effect (and
      (not (player-level ?l1))
      (player-level ?l2)
      (not (player-max-hp ?m1))
      (player-max-hp ?m2)

      (not (player-souls ?s1))
      (player-souls ?s2)

      ;; también curamos al nuevo máximo
      (forall (?h - hp-level)
        (when (player-hp ?h)
          (and (not (player-hp ?h)) (player-hp ?m2))
        )
      )
    )
  )

  (:action deposit-soul
    :parameters (?b - boss ?loc - location)
    :precondition (and
      (at-player ?loc)
      (not (player-dead))
      (is-firelink ?loc)
      (has-boss-soul ?b)
    )
    :effect (and
      (not (has-boss-soul ?b))
      (deposited-soul ?b)
    )
  )
)

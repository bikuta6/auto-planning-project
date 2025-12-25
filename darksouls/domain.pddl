;; =================================================================
;; DOMINIO DARK SOULS - PLANIFICACION AUTOMATIZADA
;; =================================================================
;; Este dominio modela un juego simplificado de Dark Souls donde:
;; - El jugador debe explorar diferentes ubicaciones
;; - Combatir enemigos menores y jefes (bosses)
;; - Mejorar su arma para poder derrotar ciertos jefes
;; - Recoger llaves y abrir puertas cerradas
;; - Gestionar su salud con frascos de Estus
;; - Depositar almas de jefes para completar objetivos
;; =================================================================

(define (domain dark-souls)
    (:requirements :strips :typing :action-costs :adl :fluents)
    ; 

    ;; TIPOS DE OBJETOS
    ;; ================
    (:types
        location - object      ; Ubicaciones del mundo (firelink, parish, etc.)
        enemy - object         ; Tipo base para todos los enemigos
        boss minor-enemy - enemy  ; Jefes y enemigos menores (subtipos de enemy)
        key - object          ; Llaves para abrir puertas cerradas
    )

    ;; PREDICADOS DEL DOMINIO
    ;; ======================
    (:predicates
        ;; NAVEGACION Y MAPA
        (connected ?from ?to - location)     ; Dos ubicaciones están conectadas
        (at-player ?loc - location)          ; Posición actual del jugador
        (is-firelink ?loc - location)        ; Ubicación es Firelink Shrine (hub principal)
        (has-bonfire ?loc - location)        ; Ubicación tiene hoguera (punto de descanso)
        (is-blacksmith ?loc - location)      ; Ubicación tiene herrero (para mejorar armas)
        
        ;; SISTEMA DE LLAVES Y PUERTAS
        (locked ?from ?to - location)        ; Conexión entre ubicaciones está cerrada
        (has-key ?k - key)                   ; El jugador posee una llave
        (key-at ?k - key ?loc - location)    ; Una llave está en una ubicación específica
        (matches ?k - key ?from ?to - location) ; Una llave abre una puerta específica
        (can-open-shortcut ?from ?to - location) ; Se puede abrir un atajo entre ubicaciones
        
        ;; SISTEMA DE MEJORA DE ARMAS
        (has-titanite)                       ; El jugador tiene titanita (material de mejora)
        (titanite-at ?loc - location)        ; Hay titanita en una ubicación
        
        ;; SISTEMA DE COMBATE Y ENEMIGOS
        (enemy-at ?e - enemy ?loc - location) ; Un enemigo está en una ubicación
        (is-alive ?e - enemy)                ; Un enemigo está vivo
        (has-boss-soul ?b - boss)            ; El jugador tiene el alma de un jefe
        (deposited-soul ?b - boss)           ; El alma de un jefe ha sido depositada
        (has-active-boss ?loc - location)    ; Hay un jefe activo en la ubicación (muro de niebla)
        
        ;; SISTEMA DE MUERTE Y RESPAWN
        (player-dead)                        ; El jugador está muerto (no puede actuar)
        (last-rested-bonfire ?loc - location) ; Última hoguera donde descansó el jugador
    )

    ;; FUNCIONES NUMERICAS
    ;; ===================
    (:functions
        ;; ESTADISTICAS DEL JUGADOR
        (player-health)                      ; Salud actual del jugador
        (player-max-health)                  ; Salud máxima del jugador
        (player-damage)                      ; Daño que inflige el jugador
        (player-souls)                       ; Almas que posee el jugador (moneda del juego)
        
        ;; SISTEMA DE FRASCOS ESTUS (CURACION)
        (estus-charges)                      ; Cargas actuales de frascos Estus
        (estus-max)                          ; Máximo de frascos Estus
        (estus-heal-amount)                  ; Cantidad de salud que cura cada frasco
        
        ;; COSTOS Y NIVELES
        (level-up-cost)                      ; Costo en almas para subir de nivel
        (total-cost)                         ; Costo total acumulado (métrica de optimización)
        
        ;; ESTADISTICAS DE ENEMIGOS
        (enemy-health ?e - enemy)            ; Salud actual de un enemigo
        (enemy-max-health ?e - enemy)        ; Salud máxima de un enemigo
        (enemy-damage ?e - enemy)            ; Daño que inflige un enemigo
        (enemy-soul-value ?e - enemy)        ; Almas que otorga un enemigo al morir
        
        ;; SISTEMA DE MEJORA DE ARMAS 
        (player-weapon-level)                ; Nivel actual del arma (0, +1, +2, etc.)
        (boss-required-weapon-level ?b - boss) ; Nivel de arma requerido para dañar a un jefe
    )

    ;; =================================================================
    ;; ACCIONES DE MOVIMIENTO Y NAVEGACION
    ;; =================================================================
    
    ;; MOVER: Permite al jugador moverse entre ubicaciones conectadas
    ;; Precondiciones: estar en la ubicación origen, que esté conectada al destino,
    ;; que no esté cerrada y que no haya un jefe activo
    (:action move
        :parameters (?from ?to - location)
        :precondition (and 
            (at-player ?from)                ; El jugador está en la ubicación origen
            (not (player-dead))              ; El jugador no está muerto
            (connected ?from ?to)            ; Las ubicaciones están conectadas
            (not (locked ?from ?to))         ; La conexión no está cerrada
            (not (has-active-boss ?from))    ; No hay jefe activo (muro de niebla)
        )
        :effect (and 
            (not (at-player ?from))          ; Ya no está en la ubicación origen
            (at-player ?to)                  ; Ahora está en la ubicación destino
            (increase (total-cost) 10)       ; Costo del movimiento
        )
    )

    ;; HUIR DEL JEFE: Permite escapar de una pelea con un jefe
    ;; El jefe recupera toda su salud al huir
    (:action flee-boss
        :parameters (?from ?to - location ?b - boss)
        :precondition (and 
            (at-player ?from)                ; Está en la ubicación del jefe
            (not (player-dead))              ; El jugador no está muerto
            (last-rested-bonfire ?to)          ; Hay conexión de escape
            (has-active-boss ?from)          ; Hay un jefe activo
            (enemy-at ?b ?from)              ; El jefe está en esta ubicación
        )
        :effect (and 
            (not (at-player ?from))          ; Sale de la ubicación del jefe
            (at-player ?to)                  ; Va a la ubicación de escape
            (assign (enemy-health ?b) (enemy-max-health ?b)) ; El jefe recupera toda su salud
            (increase (total-cost) 5)       ; Costo mayor por huir
        )
    )

    ;; =================================================================
    ;; ACCIONES DE MEJORA DE EQUIPO
    ;; =================================================================
    
    ;; MEJORAR ARMA: Aumenta el nivel del arma usando titanita en el herrero
    ;; NOTA: La mejora de arma NO aumenta el daño del jugador.
    ;; Solo incrementa el nivel de arma, que actúa como un "gate" para
    ;; poder enfrentar ciertos jefes que requieren un nivel mínimo.
    ;; Esto mantiene la coherencia con el dominio proposicional (FD).
    (:action upgrade-weapon
        :parameters (?loc - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación
            (not (player-dead))              ; El jugador no está muerto
            (is-blacksmith ?loc)             ; La ubicación tiene herrero
            (has-titanite)                   ; Tiene material de mejora
        )
        :effect (and 
            (not (has-titanite))             ; Consume la titanita
            (increase (player-weapon-level) 1) ; Sube el nivel del arma en +1
            (increase (total-cost) 50)       ; Costo de la mejora
        )
    )

    ;; =================================================================
    ;; ACCIONES DE COMBATE CONTRA JEFES
    ;; =================================================================
    
    ;; MATAR JEFE: Acción consolidada para derrotar jefes
    ;; Requiere que el jefe esté debilitado (salud <= 0) y que el arma
    ;; tenga el nivel mínimo requerido para dañar a ese jefe específico
    (:action kill-boss
        :parameters (?b - boss ?loc - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación del jefe
            (not (player-dead))              ; El jugador no está muerto
            (enemy-at ?b ?loc)               ; El jefe está aquí
            (is-alive ?b)                    ; El jefe está vivo
            (<= (enemy-health ?b) 0)         ; El jefe está debilitado (salud agotada)
            ;; VERIFICACION DE NIVEL DE ARMA:
            ;; Si el jefe requiere nivel 0 y tienes nivel 0+ -> OK
            ;; Si el jefe requiere nivel 1 y tienes nivel 0 -> FALLA
            (>= (player-weapon-level) (boss-required-weapon-level ?b))
        )
        :effect (and 
            (not (is-alive ?b))              ; El jefe muere
            (not (has-active-boss ?loc))     ; Se quita el muro de niebla
            (has-boss-soul ?b)               ; Obtienes el alma del jefe
            (increase (estus-max) 1)         ; Aumenta el máximo de frascos Estus
            (increase (total-cost) 100)      ; Costo de la acción
        )
    )

    ;; =================================================================
    ;; ACCIONES DE GESTION DE INVENTARIO Y EXPLORACION
    ;; =================================================================
    
    ;; RECOGER LLAVE: Recoge una llave del suelo
    (:action pick-up-key
        :parameters (?k - key ?loc - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación
            (not (player-dead))              ; El jugador no está muerto
            (key-at ?k ?loc)                 ; La llave está en esta ubicación
        )
        :effect (and 
            (not (key-at ?k ?loc))           ; La llave ya no está en el suelo
            (has-key ?k)                     ; El jugador ahora tiene la llave
            (increase (total-cost) 5)        ; Costo de la acción
        )
    )
        
    ;; ABRIR PUERTA: Usa una llave para abrir una puerta cerrada
    (:action unlock-door
        :parameters (?k - key ?loc - location ?to - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación origen
            (not (player-dead))              ; El jugador no está muerto
            (connected ?loc ?to)             ; Hay conexión entre ubicaciones
            (locked ?loc ?to)                ; La conexión está cerrada
            (has-key ?k)                     ; Tiene la llave
            (matches ?k ?loc ?to)            ; La llave abre esta puerta específica
        )
        :effect (and 
            (not (locked ?loc ?to))          ; Abre la puerta en ambas direcciones
            (not (locked ?to ?loc))
            (increase (total-cost) 10)       ; Costo de abrir
        )
    )
        
    ;; ABRIR ATAJO: Crea una nueva conexión permanente entre ubicaciones
    (:action open-shortcut
        :parameters (?loc - location ?dest - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación
            (not (player-dead))              ; El jugador no está muerto
            (can-open-shortcut ?loc ?dest)   ; Se puede abrir este atajo
        )
        :effect (and 
            (not (can-open-shortcut ?loc ?dest)) ; Ya no se puede abrir (ya está abierto)
            (connected ?loc ?dest)           ; Crea conexión bidireccional
            (connected ?dest ?loc)
            (increase (total-cost) 15)       ; Costo de abrir atajo
        )
    )

    ;; =================================================================
    ;; ACCIONES DE COMBATE CONTRA ENEMIGOS MENORES
    ;; =================================================================

    ;; ATACAR: Intercambia daño con un enemigo
    ;; Si el ataque reduce la salud a 0 o menos, el jugador muere
    (:action attack
        :parameters (?e - enemy ?loc - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación del enemigo
            (not (player-dead))              ; El jugador no está muerto
            (enemy-at ?e ?loc)               ; El enemigo está aquí
            (is-alive ?e)                    ; El enemigo está vivo
            (> (enemy-health ?e) 0)          ; El enemigo tiene salud
        )
        :effect (and 
            (decrease (enemy-health ?e) (player-damage))    ; Daña al enemigo
            (decrease (player-health) (enemy-damage ?e))    ; El enemigo contraataca
            ;; Si la salud cae a 0 o menos, el jugador muere
            (when (<= (player-health) 0)
                (player-dead)
            )
            (increase (total-cost) 5)        ; Costo del combate
        )
    )
        
    ;; EJECUTAR ENEMIGO: Mata a un enemigo debilitado y obtiene sus almas
    (:action execute-enemy
        :parameters (?e - enemy ?loc - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación del enemigo
            (not (player-dead))              ; El jugador no está muerto
            (enemy-at ?e ?loc)               ; El enemigo está aquí
            (is-alive ?e)                    ; El enemigo está vivo pero...
            (<= (enemy-health ?e) 0)         ; ...está debilitado (salud agotada)
        )
        :effect (and 
            (not (is-alive ?e))              ; El enemigo muere
            (increase (player-souls) (enemy-soul-value ?e)) ; Obtienes sus almas
            (increase (total-cost) 2)        ; Costo mínimo por ejecutar
        )
    )
        
    ;; RECOGER TITANITA: Recoge material de mejora para armas
    (:action pick-up-titanite
        :parameters (?loc - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación
            (not (player-dead))              ; El jugador no está muerto
            (titanite-at ?loc)               ; Hay titanita aquí
        )
        :effect (and 
            (not (titanite-at ?loc))         ; Ya no hay titanita en el suelo
            (has-titanite)                   ; El jugador ahora tiene titanita
            (increase (total-cost) 5)        ; Costo de recoger
        )
    )

    ;; =================================================================
    ;; ACCIONES DE SUPERVIVENCIA Y GESTION DE RECURSOS
    ;; =================================================================

    ;; BEBER ESTUS: Usa un frasco para recuperar salud
    (:action drink-estus
        :parameters ()
        :precondition (and 
            (not (player-dead))              ; El jugador no está muerto
            (> (estus-charges) 0)            ; Tiene frascos disponibles
            (< (player-health) (player-max-health)) ; No está a salud máxima
        )
        :effect (and 
            (decrease (estus-charges) 1)     ; Consume un frasco
            (increase (player-health) (estus-heal-amount)) ; Recupera salud
            (increase (total-cost) 5)        ; Costo de usar frasco
        )
    )
        
    ;; DESCANSAR: Usa una hoguera para recuperar salud y frascos completamente
    ;; ATENCION: También revive a todos los enemigos menores
    ;; Actualiza la última hoguera donde el jugador descansó (para respawn)
    (:action rest
        :parameters (?loc - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación
            (not (player-dead))              ; El jugador no está muerto
            (has-bonfire ?loc)               ; La ubicación tiene hoguera
        )
        :effect (and 
            (assign (player-health) (player-max-health))     ; Salud completa
            (assign (estus-charges) (estus-max))             ; Frascos completos
            ;; PENALIZACION: Revive todos los enemigos menores
            (forall (?m - minor-enemy) 
                (when (not (is-alive ?m))
                    (and 
                        (assign (enemy-health ?m) (enemy-max-health ?m))
                        (is-alive ?m)
                    )
                )
            )
            ;; Actualiza la última hoguera de descanso
            (forall (?old-loc - location)
                (when (last-rested-bonfire ?old-loc)
                    (not (last-rested-bonfire ?old-loc))
                )
            )
            (last-rested-bonfire ?loc)
            (increase (total-cost) 60)       ; Costo alto por descansar
        )
    )
        
    ;; SUBIR NIVEL: Gasta almas para mejorar estadísticas en Firelink
    (:action level-up-stats
        :parameters (?loc - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación
            (not (player-dead))              ; El jugador no está muerto
            (has-bonfire ?loc)               ; Es una hoguera cualquiera
            (>= (player-souls) (level-up-cost)) ; Tiene suficientes almas
        )
        :effect (and 
            (decrease (player-souls) (level-up-cost))        ; Gasta las almas
            (increase (level-up-cost) 50)                    ; El siguiente nivel cuesta más
            (increase (player-max-health) 30)                ; Aumenta salud máxima
            (increase (player-health) 30)                    ; Aumenta salud actual
            (increase (total-cost) 10)       ; Costo de subir nivel
        )
    )
        
    ;; DEPOSITAR ALMA: Entrega el alma de un jefe en Firelink (objetivo del juego)
    (:action deposit-soul
        :parameters (?b - boss ?loc - location)
        :precondition (and 
            (at-player ?loc)                 ; Está en la ubicación
            (not (player-dead))              ; El jugador no está muerto
            (is-firelink ?loc)               ; Es Firelink Shrine
            (has-boss-soul ?b)               ; Tiene el alma del jefe
        )
        :effect (and 
            (not (has-boss-soul ?b))         ; Ya no tiene el alma
            (deposited-soul ?b)              ; El alma ha sido depositada (objetivo)
            (increase (total-cost) 10)       ; Costo de depositar
        )
    )

    ;; =================================================================
    ;; MUERTE Y RESPAWN
    ;; =================================================================

    ;; RESPAWN: Revive al jugador en la última hoguera donde descansó
    ;; PENALIZACIONES COSTOSAS (simulando Dark Souls):
    ;; - Pierde TODAS las almas acumuladas
    ;; - Revive a TODOS los enemigos menores
    ;; - Alto costo de acción (muerte es muy costosa)
    (:action respawn
        :parameters (?bonfire ?current - location)
        :precondition (and 
            (player-dead)                    ; El jugador está muerto
            (last-rested-bonfire ?bonfire) ; Existe una hoguera de respawn
            (at-player ?current)             ; Está en la ubicación actual (muerto)
        )
        :effect (and 
            (not (player-dead))              ; Ya no está muerto
            ;; Teleporta al jugador a la hoguera
            (not (at-player ?current))
            (at-player ?bonfire)
            ;; Restaura salud y frascos
            (assign (player-health) (player-max-health))
            (assign (estus-charges) (estus-max))
            ;; PENALIZACION CRITICA: Pierde todas las almas
            (assign (player-souls) 0)
            ;; PENALIZACION: Revive todos los enemigos menores
            (forall (?m - minor-enemy) 
                (when (not (is-alive ?m))
                    (and 
                        (assign (enemy-health ?m) (enemy-max-health ?m))
                        (is-alive ?m)
                    )
                )
            )
            ;; PENALIZACION: Resetea la salud de todos los jefes vivos
            (forall (?b - boss)
                (when (is-alive ?b)
                    (assign (enemy-health ?b) (enemy-max-health ?b))
                )
            )
            (increase (total-cost) 200)      ; Costo MUY alto - morir es muy costoso
        )
    )
)
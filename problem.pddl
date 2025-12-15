;; =================================================================
;; PROBLEMA DARK SOULS - INSTANCIA CONCRETA DEL JUEGO
;; =================================================================
;; Este problema define una instancia específica del dominio Dark Souls
;; con un escenario donde el jugador debe:
;; 1. Explorar el mundo desde Firelink Shrine
;; 2. Derrotar a las Gargolas Campanas (jefe inicial)
;; 3. Mejorar su arma para poder dañar a Sif
;; 4. Derrotar al Gran Lobo Gris Sif (jefe final)
;; 5. Depositar ambas almas de jefe en Firelink
;;
;; DESAFIO: Sif requiere un arma mejorada (+1) para poder ser dañado,
;; mientras que las Gargolas pueden ser derrotadas con el arma inicial.
;; =================================================================

(define (problem dark-souls-game)
    (:domain dark-souls)

    ;; OBJETOS DEL MUNDO
    ;; =================
    (:objects
        ;; UBICACIONES DEL MAPA
        firelink burg parish darkroot boss-arena roof - location
        ;; firelink: Santuario principal (hub, hoguera, depositar almas)
        ;; burg: Burgo de los no-muertos (enemigo menor)
        ;; parish: Parroquia de los no-muertos (herrero, enemigo fuerte, llave)
        ;; darkroot: Jardín de Darkroot (titanita, puerta cerrada)
        ;; boss-arena: Arena de Sif (jefe final, requiere arma mejorada)
        ;; roof: Tejado de la parroquia (Gargolas, jefe inicial)
        
        ;; ENEMIGOS DEL JUEGO
        hollow-soldier balder-knight - minor-enemy  ; Enemigos menores
        sif gargoyles - boss                        ; Jefes principales
        
        ;; OBJETOS ESPECIALES
        crest-of-artorias - key                     ; Llave para acceder a Sif
    )

    (:init
        ;; =================================================================
        ;; CONFIGURACION DEL MAPA Y CONEXIONES
        ;; =================================================================
        
        ;; TOPOLOGIA DEL MUNDO
        ;; Firelink <-> Burg <-> Parish <-> Darkroot <-> Boss Arena
        ;;                        |
        ;;                      Roof (Gargolas)
        (connected firelink burg) (connected burg firelink)
        (connected burg parish) (connected parish burg)
        (connected parish darkroot) (connected darkroot parish)
        (connected darkroot boss-arena) (connected boss-arena darkroot)
        (connected parish roof) (connected roof parish)  ; Acceso a las Gargolas
        
        ;; PUERTAS CERRADAS
        ;; La entrada al área de Sif está cerrada y requiere la Cresta de Artorias
        (locked darkroot boss-arena)
        (locked boss-arena darkroot)
        (matches crest-of-artorias darkroot boss-arena)  ; La cresta abre esta puerta
        (key-at crest-of-artorias parish)                ; La cresta está en la parroquia
        
        ;; ATAJOS DISPONIBLES
        ;; Se puede abrir un atajo directo desde la parroquia a Firelink
        (can-open-shortcut parish firelink)

        ;; MUROS DE NIEBLA (JEFES ACTIVOS)
        ;; Indican áreas con jefes que bloquean el movimiento normal
        (has-active-boss boss-arena) ; Sif está en su arena
        (has-active-boss roof)       ; Las Gargolas están en el tejado

        ;; =================================================================
        ;; CONFIGURACION DE UBICACIONES ESPECIALES
        ;; =================================================================
        
        ;; POSICION INICIAL DEL JUGADOR
        (at-player firelink)                         ; Comienza en Firelink Shrine
        
        ;; PROPIEDADES DE UBICACIONES
        (is-firelink firelink)                       ; Firelink: hub principal del juego
        (has-bonfire firelink)                       ; Firelink: tiene hoguera para descansar
        (has-bonfire parish)                         ; Parish: también tiene hoguera
        (is-blacksmith parish)                       ; Parish: tiene herrero para mejorar armas

        ;; MATERIALES DE MEJORA
        (titanite-at darkroot)                       ; Hay titanita en Darkroot para mejorar armas

        ;; =================================================================
        ;; SISTEMA DE ARMAS Y REQUISITOS DE JEFES
        ;; =================================================================
        
        ;; NIVEL INICIAL DEL ARMA
        (= (player-weapon-level) 0)                  ; Empieza con arma sin mejorar (+0)
        
        ;; REQUISITOS DE NIVEL DE ARMA POR JEFE
        ;; Esta es la mecánica clave del problema:
        (= (boss-required-weapon-level sif) 1)       ; Sif requiere arma +1 ("inmune" al arma inicial)
        (= (boss-required-weapon-level gargoyles) 0) ; Gargolas aceptan arma +0 (se pueden luchar inmediatamente)

        ;; =================================================================
        ;; ESTADISTICAS INICIALES DEL JUGADOR
        ;; =================================================================
        
        ;; SALUD Y COMBATE
        (= (player-health) 100)                      ; Salud inicial
        (= (player-max-health) 100)                  ; Máximo de salud inicial
        (= (player-damage) 15)                       ; Daño base (se incrementa con mejoras)
        (= (player-souls) 0)                         ; Sin almas al inicio
        
        ;; SISTEMA DE CURACION (FRASCOS ESTUS)
        (= (estus-charges) 3)                        ; 3 frascos iniciales
        (= (estus-max) 3)                            ; Máximo inicial de frascos
        (= (estus-heal-amount) 50)                   ; Cada frasco cura 50 de salud
        
        ;; SISTEMA DE PROGRESION
        (= (level-up-cost) 150)                      ; Costo inicial para subir nivel
        (= (total-cost) 0)                           ; Métrica de optimización (empieza en 0)

        ;; =================================================================
        ;; CONFIGURACION DE ENEMIGOS Y JEFES
        ;; =================================================================
        
        ;; ENEMIGO 1: SOLDADO HUECO (FÁCIL)
        ;; Ubicado en el Burgo, enemigo de entrada con estadísticas bajas
        (enemy-at hollow-soldier burg) (is-alive hollow-soldier)
        (= (enemy-health hollow-soldier) 30)         ; Poca salud, fácil de derrotar
        (= (enemy-max-health hollow-soldier) 30)
        (= (enemy-damage hollow-soldier) 10)         ; Daño bajo
        (= (enemy-soul-value hollow-soldier) 80)     ; Pocas almas como recompensa

        ;; ENEMIGO 2: CABALLERO BALDER (INTERMEDIO)
        ;; Ubicado en la Parroquia, más desafiante pero aún manejable
        (enemy-at balder-knight parish) (is-alive balder-knight)
        (= (enemy-health balder-knight) 80)          ; Salud considerable
        (= (enemy-max-health balder-knight) 80)
        (= (enemy-damage balder-knight) 25)          ; Daño moderado-alto
        (= (enemy-soul-value balder-knight) 250)     ; Buena recompensa de almas

        ;; JEFE 1: GARGOLAS CAMPANAS (JEFE INICIAL)
        ;; Ubicadas en el Tejado, accesibles inmediatamente
        ;; Diseñadas para ser el primer jefe derrotado
        (enemy-at gargoyles roof) (is-alive gargoyles)
        (= (enemy-health gargoyles) 200)             ; Salud alta pero factible
        (= (enemy-max-health gargoyles) 200)
        (= (enemy-damage gargoyles) 30)              ; Daño supervivable con salud inicial
        (= (enemy-soul-value gargoyles) 1000)        ; Gran cantidad de almas para mejorar

        ;; JEFE 2: GRAN LOBO GRIS SIF (JEFE FINAL)
        ;; Ubicado en la Arena del Jefe, requiere arma mejorada
        ;; El desafío principal del problema
        (enemy-at sif boss-arena) (is-alive sif)
        (= (enemy-health sif) 400)                   ; Salud muy alta
        (= (enemy-max-health sif) 400)
        (= (enemy-damage sif) 50)                    ; Daño peligroso
        (= (enemy-soul-value sif) 3000)              ; Recompensa masiva
    )

    ;; =================================================================
    ;; OBJETIVO DEL JUEGO
    ;; =================================================================
    ;; Para completar el juego, el jugador debe derrotar a ambos jefes
    ;; y depositar sus almas en Firelink Shrine.
    ;;
    ;; ESTRATEGIA REQUERIDA:
    ;; 1. Derrotar a las Gargolas primero (no requiere mejoras)
    ;; 2. Usar las almas para conseguir materiales y mejorar el arma
    ;; 3. Conseguir la Cresta de Artorias para acceder a Sif
    ;; 4. Derrotar a Sif con el arma mejorada
    ;; 5. Depositar ambas almas en Firelink
    (:goal 
        (and
            (deposited-soul gargoyles)               ; Alma de Gargolas depositada
            (deposited-soul sif)                     ; Alma de Sif depositada
        )
    )

    ;; =================================================================
    ;; METRICA DE OPTIMIZACION
    ;; =================================================================
    ;; El planificador intentará minimizar el costo total de acciones
    ;; para encontrar la ruta más eficiente hacia el objetivo
    (:metric minimize (total-cost))
)
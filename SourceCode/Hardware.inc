;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;DEFINIÇÕES DE HARDWARE;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Neste Arquivo estão definidas constantes e macros para
;utilização da placa didática utilizada no projeto e 
;sensores/componentes elétrônicos utilizados


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;DRIVER DA PLACA DIDÁTICA;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;BUZZER;;;;;;;;;;;;;;;
PINO_BUZZER         EQU      P1.0

MACRO LIGA_BUZZER
CLR PINO_BUZZER
ENDM

MACRO DESLIGA_BUZZER
SETB PINO_BUZZER
ENDM
;;;;;;;;;;;LEDS;;;;;;;;;;;;;;;

LED1           EQU     P2.1
LED2           EQU     P2.2
LED3           EQU     P2.3
LED4           EQU     P2.4
LED5           EQU     P2.5
LED6           EQU     P2.6
LED7           EQU     P2.7

MACRO LIGA_LED  NUM
CLR NUM
ENDM

MACRO DESLIGA_LED  NUM
SETB NUM
ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;ENTRADAS COMPARADORES;;;;;;
COMP_LOW        EQU         P3.6
COMP_HIGH       EQU         P3.7    

MACRO LIGA_VENTILADOR
    CLR P2.0
ENDM

MACRO DESLIGA_VENTILADOR
    SETB P2.0
ENDM
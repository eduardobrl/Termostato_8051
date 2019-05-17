;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;DEFINIÇÕES DE HARDWARE;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;PLACA DIDÁTICA;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;LEDS;;;;;;;;;;;;;;;
PINO_LED            EQU     P2
LED0           EQU     P2.0
LED1           EQU     P2.1
LED2           EQU     P2.2
LED3           EQU     P2.3
LED4           EQU     P2.4
LED5           EQU     P2.5
LED6           EQU     P2.6
LED7           EQU     P2.7

;;;;;;;;;;;;BOTOES;;;;;;;;;;;;;;
PINO_BOTAO0         EQU     P3.3
PINO_BOTAO1         EQU     P3.4
PINO_BOTAO2         EQU     P3.5
PINO_BOTAO3         EQU     P3.6
PINO_BOTAO4         EQU     P3.7

BOTAO_ON_OFF          EQU     PINO_BOTAO0

DISP_A              EQU      P0.0
DISP_B              EQU      P0.1
DISP_C              EQU      P0.2
DISP_D              EQU      P0.3
DISP_E              EQU      P0.4
DISP_F              EQU      P0.5
DISP_G              EQU      P0.6

DISP_1              EQU      P1.2
DISP_2              EQU      P1.3

;;;;;;;;;;;OUTROS COMPONENTES;;;;
PINO_PULSO          EQU      P2.0
PINO_CAPTURE        EQU      P1.1

PINO_BUZZER         EQU      P1.0
PINO_RELE           EQU      P1.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RELE_ON             EQU      00h
RELE_OFF            EQU      01h

BUZZER_ON           EQU      00h
BUZZER_OFF          EQU      01h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
TURN_OFF            EQU     00h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MACRO LIGA_BUZZER
CLR PINO_BUZZER
ENDM

MACRO DESLIGA_BUZZER
SETB PINO_BUZZER
ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MACRO LIGA_LED  NUM
CLR NUM
ENDM

MACRO DESLIGA_LED  NUM
SETB NUM
ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
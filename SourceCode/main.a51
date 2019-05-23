$include(REG51.inc)
$include(Hardware.inc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;ENDEREÇOS DE MEMÓRIA UTILIZADOS;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;BYTES;;;;;;;;;;;;;;;;;;;;
PERIOD_LOC      EQU         0x31
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;BTSFLAGS (AUXILIARES);;;;;;;;;;;;
LOW_PWM         EQU         0x07
HIGH_PWM        EQU         0x06
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;VALORES CONSTANTES;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOW_DUTY        EQU         00CH       ;; - > Duty Temperatura Baixa = 50% do Periodo
HIGH_DUTY       EQU         019h       ;; -> Duty Temperatura Alta = 100% do Periodo
PERIOD          EQU         019h       ;; - > Periodo do PWM = 0,25s = 0,25/10m = 19
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;RESETA TIMER PARA 10 MS;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MACRO resetTimer
    mov TH1, #0D8h
    mov TL1, #0EFh
ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


code at 0
    ljmp START
code

code at 001Bh
    ljmp DRV_TIMER 
code

code at 0100h

DRV_TIMER: 
    
    JB LOW_PWM, _LOW
    JB HIGH_PWM, _HIGH

    resetTimer
    reti

    
    _LOW: ;; Temperatura Baixa - 50% Duty
    inc PERIOD_LOC 
    mov A, PERIOD_LOC
    SUBB A, #LOW_DUTY
    JC SET_PWM_ON
    jmp SET_PWM_OFF   
    
    _HIGH: ;; Temperatura Alta - 100% Duty
    inc PERIOD_LOC 
    mov A, PERIOD_LOC
    SUBB A, #HIGH_DUTY
    JC SET_PWM_ON
    jmp SET_PWM_OFF   
    
    
    SET_PWM_ON:
        LIGA_VENTILADOR
        LIGA_LED  LED7
        mov A, PERIOD_LOC
        CJNE A, #PERIOD, FIM_ISR
        mov PERIOD_LOC, #00h
        resetTimer
    reti
    
    SET_PWM_OFF:
        DESLIGA_VENTILADOR
        DESLIGA_LED  LED7
        mov A, PERIOD_LOC
        CJNE A, #PERIOD, FIM_ISR
        mov PERIOD_LOC, #00h
        resetTimer
    reti
    
    FIM_ISR:
    resetTimer
    reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;VERIFICA ESTADO DOS COMPARADORES;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   

TASKS_SENSOR:

    JNB  COMP_HIGH, SET_HIGH_PWM
    JNB  COMP_LOW, SET_LOW_PWM   
    
    CLR HIGH_PWM
    CLR LOW_PWM
    DESLIGA_VENTILADOR
    DESLIGA_BUZZER
    ret
        
    SET_LOW_PWM:
        SETB LOW_PWM 
        CLR HIGH_PWM
    ret
    
    
    SET_HIGH_PWM:
        SETB HIGH_PWM
        CLR LOW_PWM
    ret
   

INIT_HARD:
    SETB COMP_LOW    
    SETB COMP_HIGH 
    MOV TMOD, #00010000b ; Timer 16 bits
    mov IE, #10001000b
    MOV TCON, #01000000b 
    MOV PERIOD_LOC, #00h
    resetTimer    
ret


START:
    lcall INIT_HARD
    LOOP:
    lcall TASKS_SENSOR
    ljmp LOOP
end
    

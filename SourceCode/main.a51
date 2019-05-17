$include(REG51.inc)
$include(Hardware.inc)

COMP_LOW        EQU         PINO_BOTAO3
COMP_HIGH       EQU         PINO_BOTAO4    

TON             EQU         0x30
PERIOD_LOC      EQU         0x31
BUTTON_CLICK    EQU         0x32
HISTERESE_LOC   EQU         0x33
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FLAGS;;;;

LOW_PWM         EQU         0x07
HIGH_PWM        EQU         0x06
T_OFF           equ         0x05
HIST_ST         equ         0x06
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOW_DUTY        EQU         07FH            
HIGH_DUTY       EQU         0ffh        
PERIOD          EQU         0ffh      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HISTERESE       EQU         0xAA


MACRO resetTimer
mov TH1, #0D8h
mov TL1, #0EFh
ENDM



code at 0
    ljmp START
code

code at 0013h
    RETI
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

    _LOW:
    inc PERIOD_LOC 
    mov A, PERIOD_LOC
    SUBB A, #LOW_DUTY
    JC SET_PWM_ON
    jmp SET_PWM_OFF   
    
    _HIGH:
    inc PERIOD_LOC 
    mov A, PERIOD_LOC
    SUBB A, #HIGH_DUTY
    JC SET_PWM_ON
    jmp SET_PWM_OFF   
    
    
    SET_PWM_ON:
        LIGA_LED  LED0
        LIGA_LED  LED7
        mov A, PERIOD_LOC
        CJNE A, #PERIOD, FIM_ISR
        mov PERIOD_LOC, #00h
        resetTimer
    reti
    
    SET_PWM_OFF:
        DESLIGA_LED  LED0
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

   
    JNB  COMP_LOW, SET_LOW_PWM   
    JNB  COMP_HIGH, SET_HIGH_PWM
    
    
    CLR HIGH_PWM
    CLR LOW_PWM
    mov PERIOD_LOC, #00h
    DESLIGA_LED  LED0
    DESLIGA_BUZZER
    DESLIGA_LED LED1
    DESLIGA_LED LED2  
    DESLIGA_LED LED7


    RETORNA:
    ret
      
   
    SET_LOW_PWM:
        SETB LOW_PWM 
        LIGA_LED LED1
        CLR HIGH_PWM
    ret
    
    
    SET_HIGH_PWM:
        SETB HIGH_PWM
        LIGA_LED LED2
        CLR LOW_PWM
    ret
   

INIT_HARD:
    MOV COMP_LOW, #0FFh    
    MOV COMP_HIGH, #0FFh 
    MOV TCON, #01000100b
    mov IE, #10001100b
    MOV PERIOD_LOC, #00h
    mov HISTERESE_LOC,#00h
    resetTimer    
ret


START:
    lcall INIT_HARD
    LOOP:
    lcall TASKS_SENSOR
    ljmp LOOP
end
    

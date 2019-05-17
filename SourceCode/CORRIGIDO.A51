$include(REG51.inc)
code at 0
ljmp START
code







code at 0200h
START:
    mov sp, #40h
    lcall INIC_HARD
    lcall INICIAR_HARDWARE
    lcall CONFIG_TIME
    mov r7,#00h
    setb TR0
    lcall PREPARA_DISPLAY_UNIDADE
LOOP:
    sjmp LOOP
    end
code

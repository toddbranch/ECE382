.include "header.S"

.global turn_off

.text
turn_off:
    mov.b   #0x00, &P1OUT
    ret

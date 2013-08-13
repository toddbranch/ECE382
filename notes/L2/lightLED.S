; This program sets all pins on Port 1 to output and high.  Since LEDs 1 and 2 are connected to P1.0 and P1.6 respectively, they will light up.
;

.include "header.S"

.text
main:
    mov.w   #WDTPW, r15
    xor.w   #WDTHOLD, r15
    mov.w   r15, &WDTCTL
    bis.b   #0xFF, &P1DIR
    bis.b   #0xFF, &P1OUT
loop:
	jmp loop

.section ".vectors", "a"
    .org    0x1e
    .word   main

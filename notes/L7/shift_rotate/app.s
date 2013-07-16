.include "header.s"

.text
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL

    clrc
    mov     #0b10010101, r10
    rrc.b     r10                     ;r10 is now 01001010, carry is set 
    rrc.b     r10                     ;r10 is now 10100101, carry bit is clear

    rra.b     r10                     ;r10 is now 11010010, carry bit is set 
    rra.b   r10                     ;r10 is now 11101001, carry bit is clear

    swpb    r10
    swpb    r10

    sxt     r10

    mov     #2, r10
    rla     r10         ;$r10 is now 0x4
    rla     r10         ;$r10 is now 0x8 
    setc
    rlc     r10         ;$r10 is now 0b10001, or 0x11

forever:
    jmp     forever

.section    ".vectors", "a"
.org    0x1e
    .word   main

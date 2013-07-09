.include "header.s"

.text
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL
    ;initialize stack
    mov     #RAMEND, r1
    ;code
    push.b  #0xab
    push    #0xcccc

forever:
    jmp     forever

.section    ".vectors", "a"
.org    0x1e
    .word   main

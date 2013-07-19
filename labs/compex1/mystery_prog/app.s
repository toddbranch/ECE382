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
            mov.w   #0x0200, r9
            mov.w   #10, r10

            mov.w   #0, r11
            mov.w   r11, 0(r9)

            mov.w   #1, r12
            incd    r9
            mov.w   r12, 0(r9)

loop:       tst     r10
            jz      forever

            incd    r9
            dec     r10

            mov.w   r12, r13
            add.w   r11, r12
            mov.w   r12, 0(r9)
            mov.w   r13, r11
            jmp     loop

forever:     jmp     forever

.section    ".vectors", "a"
.org    0x1e
    .word   main

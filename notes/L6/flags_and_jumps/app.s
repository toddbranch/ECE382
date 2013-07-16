.include "header.s"

.text
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL

    mov.w   #1, r7          ;move instructions don't set flags
    add.w   #0xffff, r7     ;this should set the carry and zero flags

    mov.w   #1, r7
    add.w   #0x7fff, r7     ;this should set the overflow and negative flags

    mov.w   #0xffff, r7
    add.w   #0xffff, r7     ;this should set the negative and carry flags

    xor.w   #0b10101010, r7 ;this sets the negative and carry flags - in logical operations, the carry flag is the opposite of the zero flag

    clrc
    clrn
    setz

    ; example of a conditional
    mov     #10, r7
    cmp     #5, r7
    jge     greater
    mov     #0xbeef, r7
    jmp     done
greater:
    mov     #0xdfec, r7
done:


    ; example of a loop
    mov     #0, r6
    mov     #10, r7
loop:
    add     #2, r6
    dec     r7
    jnz     loop

forever:
    jmp     forever

.section    ".vectors", "a"
.org    0x1e
    .word   main

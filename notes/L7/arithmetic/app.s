.include "header.s"

.text
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL

    mov     #0xabab, r10
    add     #0xabab, r10    ;which flags will be set?  carry and overflow

    addc    #5, r10         ;result is 0x575c because of the carry

    mov     #10, r10
    sub     #5, r10         ;which flags will be set?  carry because we're adding the 2's complement!

    subc    #3, r10         ;since the carry is set, why did this only subtract 3?  because we're doing bitwise not - and adding the carry makes it the 2's complement

    clrc
    mov     #0x0009, r10
    dadd    #1, r10

    incd    r10
    dec     r10

    sbc     r10             ;why doesn't this subtract one?  think about what the operation is doing

    setc
    adc    r10

forever:
    jmp     forever

.section    ".vectors", "a"
.org    0x1e
    .word   main

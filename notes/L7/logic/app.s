.include "header.s"

.text
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL

    mov     #1, r10
    cmp     #10, r10

    mov     #10, r10
    cmp     #1, r10

    mov     #0x8000, r12        ;status flags not set
    bit     #0xffff, r10        ;set negative flag, carry flag - for logic instructions, carry opposite of zero flag.  does not impact $r10
    bis     #0xdfec, r10        ;does not set status flags.  $r10 is 0xdfec 
    bic     #0xfff0, r10        ;does not set status flags.  $r10 is 0x000c 
    xor     #0xece0, r10        ;set negative flag, carry flag.  $r10 is 0xecec
    and     #0xff00, r10        ;set negative flag, carry flag.  $r10 is 0xec00

    inv     r10                 ;$r10 is 0x13ff, set overflow and carry flags
    bic     #0b0000000100000000, r2     ;clear overflow bit
    mov     #0x8000, r10
    inv     r10                 ;$r10 is 0x7fff, set overflow and carry flags

    clr     r10                 ;$r10 is 0 - status flags not set because this is a mov instruction
    tst     r10                 ;set zero, carry flags
    inv     r10                 ;$r10 is 0xffff, set negative and carry flags
    tst     r10                 ;set negative, carry flags  

forever:
    jmp     forever

.section    ".vectors", "a"
.org    0x1e
    .word   main

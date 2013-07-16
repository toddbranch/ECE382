.include "header.s"

.text
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL

    mov     #0x8000, r12
    bit     #0xffff, r10        ;set negative flag, carry flag - for logic instructions, carry opposite of zero flag.  does not impact $r10
    bis     #0xdfec, r10        ;does not set status flags.  $r10 is 0xdfec 
    bic     #0xfff0, r10        ;does not set status flags.  $r10 is 0x000c 
    xor     #0xece0, r10        ;set negative flag, carry flag.  $r10 is 0xecec
    and     #0xff00, r10        ;set negative flag, carry flag.  $r10 is 0xec

forever:
    jmp     forever

.section    ".vectors", "a"
.org    0x1e
    .word   main

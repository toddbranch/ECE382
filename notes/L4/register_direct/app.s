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
    mov.w   r11,r10     
    bis.b   #0xFF, r6   
    inv.w   r5          
    swpb    r10         

forever:
    jmp     forever

.section    ".vectors", "a"
.org    0x1e
    .word   main

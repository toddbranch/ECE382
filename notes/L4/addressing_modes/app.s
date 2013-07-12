.include "header.s"

.data
ram_int:    .space  2

.section    ".rodata"
some_constant:  .word   0xbeef
blah_int:    .space  2

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
    swpb    r10         
    mov.w   #0xC7, r9
    bis.b   #0xFF, r6   
    inv.w   r5          

    mov.w   #0x200, r6
    mov.w   r6, r5
    mov.w   #0xbeef, 2(r6)
    mov.w   2(r6), 6(r5)   

    mov.w   some_constant, r7

    mov.w   #0x200, r6
    mov.w   #0xcccc, &0x0200
    mov.w   @r6, r7

    add.b   #0x7, r7
    add.w   #0x7, r7

    mov.w   r7,&0x0200

forever:
    jmp     forever

.section    ".vectors", "a"
.org    0x1e
    .word   main

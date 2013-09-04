; Lab 1 - Simple Calculator
; Capt Todd Branchflower, USAF
; 17 Jul 2013

.include "header.s"

.data
result:

.text
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL

    ;r11 holds address of next result
    ;r10 holds address of current operation/operand
    ;r9 holds current operation
    ;r8 holds first operand, result
    ;r7 holds second operand

    mov     #result, r11
    mov     #instructions, r10  
    mov.b   @r10, r8

loop:
    inc     r10
    mov.b   @r10, r9 
    sub.b   #0x11, r9
    jz      addition
    sub.b   #0x11, r9
    jz      subtraction
    sub.b   #0x11, r9
    jz      multiplication
    sub.b   #0x11, r9
    jz      clear
    jmp     forever

addition:
    inc     r10
    mov.b   @r10, r7
    add.b   r7, r8
    jc      too_big
    jmp     store_result    

subtraction:
    inc     r10
    mov.b   @r10, r7
    sub.b   r7, r8
    jnc    too_small
    jmp     store_result    

multiplication:
    inc r10
    mov.b   @r10, r7

    ;use r15 to store previous r8
mult_loop:    
    cmp.b   #1, r7
    jeq     store_result 
    mov.b   r8, r15
    clrc
    rrc.b   r7
    jnc     one_add
    add.b   r15, r8
    jc      too_big
one_add:
    add.b   r15, r8 
    jc      too_big
    jmp     mult_loop 

clear:
    inc r10
    mov.b   @r10, r8
    mov.b   #00, @r11
    inc     r11
    jmp     loop 

too_big:
    mov.b   #0xff, r8
    jmp     store_result

too_small:
    mov.b   #0x00, r8
    jmp     store_result

store_result:
    mov.b   r8, @r11
    inc     r11
    jmp     loop

forever:
    jmp     forever

instructions:
    ;.byte   0x14,0x11,0x32,0x22,0x08,0x44,0x04,0x11,0x08,0x55
    .byte   0x14,0x11,0x32,0x22,0x08,0x44,0x44,0x44,0x04,0x11,0xFF,0x55

.section    ".vectors", "a"
.org    0x1e
    .word   main

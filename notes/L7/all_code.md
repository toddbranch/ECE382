```
    mov     #0xabab, r10
    add     #0xabab, r10    ; sets C and V

    addc    #2, r10         


    mov     #5, r10
    sub     #8, r10         ; which flags will be set?  carry because we're adding the 2's complement!  Remember - 2's complement is 1 + bitwise not

    subc    #1, r10         ; expected result

    mov     #5, r10
    mov     #4, r10

    subc    #1, r10         ; weird result - what's going on here?  Watch out for SUBC - can be confusing!


    mov     #5, r10
    cmp     #10, r10        ;evaluates 1-10, sets negative flag - remember, subtraction involves adding the 2's complement (a bit-wise invert + 1)

    subc    #1, r10         ; still weird!

    mov     #10, r10
    cmp     #1, r10         ;evaluates 10-1, sets carry flag - remember, subtraction involves adding the 2's complement (a bit-wise invert + 1)


    clrc
    mov     #0x99, r10
    dadd    #1, r10
    setc
    dadd    #1, r10         ; DADD uses the carry bit!


    incd    r10
    dec     r10

    sbc     r10             ;why doesn't this subtract one?  think about what the operation is doing

    clrc

    sbc     r10

    setc
    adc    r10


    incd    r10
    dec     r10

    bit     #10b, r2

    incd    r10
    dec     r10

    bit     #1b, r2

    mov.b   #0xff, &P1OUT 
    mov.b   #0xff, &P1DIR

    bic     #1b, &P1OUT
    bic     #1000000b, &P1OUT
    bis     #1b, &P1OUT
    bis     #1000000b, &P1OUT


    mov     #0xdfec, r12
    mov     #0, r11
    setc
    and     r11, r12
    mov     #0x5555, r11
    xor     #0xffff, r11


    mov     #0xec00, r10
    inv     r10                 ;$r10 is 0x13ff, set overflow and carry flags
    bic     #100000000b, r2     ;clear overflow bit
    mov     #0x8000, r10
    inv     r10                 ;$r10 is 0x7fff, set overflow and carry flags

    clr     r10                 ;$r10 is 0 - status flags not set because this is a mov instruction
    tst     r10                 ;set zero, carry flags
    inv     r10                 ;$r10 is 0xffff, set negative and carry flags
    tst     r10                 ;set negative, carry flags  


    clrc
    mov     #10010101b, r10
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


    ;disable watchdog timer
    mov     #WDTPW, r10         ;to prevent inadvertent writing, the watchdog has a password - if you write without the password in the upper 8 bits, you'll initiate a PUC.
                                ;the password is 0x5a in the upper 8 bits.  if you read from the password, you'll read 0x69.
    bis     #WDTHOLD, r10       ;next, we need to bis the password with the bit that tells the timer to hold, not count
    mov     r10, &WDTCTL        ;next, we need to write that value to the WDTCTL - this is a static address in memory (not relative to our code), so we need 
```

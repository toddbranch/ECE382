```
    mov.w   #0x7fff, r5
    add.w   #1, r5

    mov.b   #0x80, r5       ; note how MOV doesn't impact flags.  BIC, BIS don't either.
    add.b   #0x80, r5

    mov.b   #0x7f, r5
    sub.b   #0x80, r5


    mov.w   #0x8001, r5
    cmp.w   #0x1, r5

    cmp.w   #0x1000, r5
    add.w   #00001111b, r5


    mov.w   #10, r5
    cmp.w   #10, r5         ; note how CMP only sets flags, along with BIT, TST

    sub.w   #10, r5
    tst     r5              ; talk about how tst emulated CMP #0, dst


    mov.w   #1, r7          
    add.w   #0xffff, r7     

    mov.w   #1, r7
    add.w   #0x7fff, r7     

    mov.w   #0xffff, r7
    add.w   #0xffff, r7     

    xor.w   #10101010b, r7 


    clrc
    clrn
    setz

    ; example of a conditional
    mov     #10, r7
    cmp     #5, r7              ; why is the carry flag set here?  think about how CMP is SUB and how the SUB operation is implemented
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
```

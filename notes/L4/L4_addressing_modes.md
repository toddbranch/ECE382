# L4 Assignment - Addressing Modes, Hand-assembly

This assignment will be graded on the CheckPlus / Check / CheckMinus / 0 scale - see [Grading](/admin/grading.html) for more information.

## Addressing Modes

1. For each of the following instructions, identify the addressing modes being used and hand-assemble it.
```
swpb    r7
```
Addressing modes used:
<br>
<br>
<br>
<br>
<br>
<br>
<br>
Hand-assembled machine code:
<br>
<br>
<br>
<br>
<br>
<br>
<br>
```
xor     @r12+, 0(r6)
```
Addressing modes used:
<br>
<br>
<br>
<br>
<br>
<br>
<br>
Hand-assembled machine code:
<br>
<br>
<br>
<br>
<br>
<br>
<br>
```
nop
```
Addressing modes used:
<br>
<br>
<br>
<br>
<br>
<br>
<br>
Hand-assembled machine code:
<br>
<br>
<br>
<br>
<br>
<br>
<br>
```
            jmp     TARGET      ; address is 0xc000
...
TARGET:     nop                 ; address is 0xc024
```
What addressing mode do relative jumps use (if any)?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
Hand-assembled machine code:
<br>
<br>
<br>
<br>
<br>
<br>
<br>
```
mov.w   @r12, &0x0200
```
Addressing modes used:
<br>
<br>
<br>
<br>
<br>
<br>
<br>
Hand-assembled machine code:
<br>
<br>
<br>
<br>
<br>
<br>
<br>
2. Consider the following code snippet:
```
mov.w   #0xFF, P1OUT    ;P1OUT is 0x0021
```
What addressing modes are being used here?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
Hand-assemble the code.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
The programmer wants this code to move 0xFF into P1OUT, but the code isn't working.  Why not?  
*Hint: talk about the assembly / linking process.*
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
How would you change the code snippet to fix the problem?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
3. Consider the following code snippet:
```
mov.w   r10, @r9
```

This doesn't assemble.  Why?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
What's an equivalent replacement instruction?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

# L4 Assignment - Addressing Modes, Hand-assembly

## Addressing Modes

Name:
Documentation:


**All answers should be in little-endian, hex format.**

1. For each of the following instructions, identify the addressing modes being used.
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
4. What is the purpose of emulated instructions?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
5. Use the MSP430x2xx Family User's Guide to answer the following questions:

- What status bits does the TST instruction manipulate?
<br>
<br>
<br>
<br>
- Give an example of how the PUSH and POP instructions manipulate the stack.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
- In the example code for the CMP instruction (page 77) what role do the R6 and R7 registers play?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
- In the Digital I/O section, how is it recommended that you should configure unused pins?  In your own words, explain why is this course of action recommended.
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
# Lesson 6 Notes

## Readings
Davies pp123-124  
[Control Flow](http://en.wikipedia.org/wiki/Control_flow)  
[Overflow Flag](http://en.wikipedia.org/wiki/Overflow_flag)

## Assignment

## Lesson Outline
- Status Register
- Flow of Control
- Movement Instructions

## Status Register

*[Discuss CompEx, get some feedback, remind them of due dates]*

Quick review - how many registers does the MSP430 have?  16.  How many of these have special purposes?  4 - program counter (PC), stack pointer (SP), status register (SR), and constant generator (CG).

What's the purpose of the program counter?  Holds the address of the next instruction.  We'll cover the purpose of the stack pointer later.

Last lesson we learned how the SR and CG are used to shorten the length of instructions involving common constants and allow for immediate addresssing.

When used normally, the CG is hardwired to 0.

The status register, on the other hand, has a very specific purpose.  Here's its structure:

| 15 | 14 | 13 | 12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| Reserved	colspan=7 | V | SCG1 | SCG0 | OSCOFF | CPUOFF | GIE | N | Z | C |

Don't worry about the upper 7 bits - they're unused.

The remainder are flags.  Some are read to gain information about the result of a previous operation.  These are what we'll focus on today.  Others control interrupts or the various low-power modes the MSP430 can be placed in.  We'll talk about those further down the road.

x86 has a FLAGS register that is structured very similarly to this - so your personal computers function the same way.

### Result of Previous Operations

Many of the bits in the Status Register can give us information about the results of previous operations.

The V bit is the **overflow** bit.

Who can tell me what an overflow is?  

This indicates that the signed two's-complement result of an operation cannot fit in the available space.  Remember, in two's-complement the most significant bit is the sign bit.  If I had a large positive number and added it to another positive number, the result could spill over into the most significant bit and appear negative, even though the addition of two positive numbers can't be negative.  For instance, `0x7fff + 0x01` would result in `0x8000`.  In unsigned addition, this result is correct.  In signed, it isn't.  So this flag is only meaningful when dealing with signed numbers.

In practice, it is set when the result of adding two positive numbers is negative or the result of adding two negative numbers is positive.  Essentially, when the sign of the result is different when adding two numbers with the same sign.  It is never set when adding numbers with different signs.  This could also result if positive - negative = negative or negative - positive = positive.

The N bit is the **negative** bit.

This is the same as the first bit of the result of the previous operation.  This only works for signed numbers - where the MSB of the result indicates the sign.  1 indicates a negative number, 0 a positive.

The Z bit is the **zero** bit.

This is set if the result of the previous operation is 0.  If not, it is cleared.  This functions the same way for both signed and unsigned numbers.  This is commonly used to test for equality.  You'd subtract to numbers - if the result is 0, they are equal.

The C bit is the **carry** bit.

The carry bit is used to indicate that the result of an operation is too large to fit in the space allocated.  For instance, say the register `r7` had the value 1.  The operation `add.w #0xffff, r7` would result in `0000` in `r7` and the C bit being set.  In that situation, we'd say a carry occurred.

Logical instructions set C to the opposite of Z - i.e. C is set if the result is NOT 0.

Some code to step through that will set / clear these flags:
```
mov.w   #1, r7          ;move instructions don't set flags
add.w   #0xffff, r7     ;this should set the carry and zero flags

mov.w   #1, r7
add.w   #0x7fff, r7     ;this should set the overflow and negative flags

mov.w   #0xffff, r7
add.w   #0xffff, r7     ;this should set the negative and carry flags

xor.w   #0b10101010, r7 ;this sets the negative and carry flags - in logical operations, the carry flag is the opposite of the zero flag
```

*[Step through above code on the board, then in debugger]*

Since it's so common to use these flags, the MSP430 offers emulated instructions to manipulate each one:

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| CLRC | BIC #1, SR |
| SETC | BIS #1, SR |
| CLRZ | BIC #2, SR |
| SETZ | BIS #2, SR |
| CLRN | BIC #4, SR |
| SETN | BIS #4, SR |
| DINT | BIC #8, SR |
| EINT | BIS #8, SR |

Here's a quick example:
```
clrc
clrn
setz
```

## Flow of Control

Often times, we want to execute certain pieces of code conditionally.  In computer science, **control flow** refers to the order in which instructions in a program are executed.  Higher level languages use constructs like if/then/else statements or switch statements or loops to achieve this.  

``` 
if (a > 10) {
    //if a is greater than 10, execute this code
} else {
    //if not, execute this
}

switch (variable) {
    case 10:
        //if variable is 10, do something
        break;
    case 20:
        //if variable is 20, do something else
        break;
    default:
        //do some default thing
        break;
}

while (b < 10) {
    //do this code as long as b is less than 10
}
```

Remember, all higher level code eventually becomes assembly, then is assembled into machine code.  In assembly, we use conditional jumping instructions that jump based on the status of certain flags in the Status Register to achieve this.  

The key thing to remember is that these jumps are only checking flags in the status register.  For instance, `JN` (jump if negative) will jump if the N flag in the status register is set.  If we're using signed numbers, that flag corresponds to the result being negative.  But the core action of these jumps is testing the flags in the status register and jumping appropriately.

## Movement Instructions

Here are the conditional jump statements available in the MSP430:

| Condition Code | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 000 | JNE/JNZ | Jump if Z==0 (if `!=`) |
| 001 | JEQ/JZ | Jump if Z==1 (if `==`) |
| 010 | JNC/JLO | Jump if C==0 (if unsigned `<`) |
| 011 | JC/JHS | Jump if C==1 (if unsigned `>`) |
| 100 | JN | Jump if N==1 - Note there is no jump if N==0 |
| 101 | JGE | Jump if N==V (if signed `>=`) |
| 110 | JL | Jump if N!=V (if signed `<`) |
| 111 | JMP | Jump unconditionally |

Remember, these are relative jumps - meaning they are jumps relative to the PC.  If you use labels in your code, the assembler will take care of all of the heavy lifting for you.

When working with these jumps, instructions like `CMP` or `TST` are useful - they only set the flags in the status register, no destination is written.

```
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

One additional instruction:

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| BR dst | MOV dst, PC |

This instruction is simply a MOV to the PC.  So, with `BR` we have access to the full range of addressing modes if PC-relative is not acceptable.

title = 'Status Register.  Flow of Control.  Movement Instructions.' 

# Lesson 6 Notes

## Readings

- [MSP430 Family Users Guide pp121](/datasheets/msp430_msp430x2xx_family_users_guide.pdf)
- Davies pp123-124
- [Control Flow](http://en.wikipedia.org/wiki/Control_flow)
- [Overflow Flag](http://en.wikipedia.org/wiki/Overflow_flag)

## Assignment

## Lesson Outline
- Status Register
- Flow of Control
- Movement Instructions

## Admin

- [Listing of all code in this lesson](all_code.html)
- Video - Daily Show Russian Meteor
- Collect CompEx Questions at end of period

*[Discuss CompEx, get some feedback]*

## Review

**Addressing modes on board, special cases on projector**

- Pass back Skills Review, HW
- Quick overview of CheckPlus / Check / CheckMinus grading policy
- Review assembler / linker assignment if necessary
- Review Addressing Modes assignment
- Review addressing modes, hit anything we missed in L4 (**SPECIAL CASES**)
- Note binary error. In CCS, binary is specified `mov.w #10101010b, r5` - not `mov.w #0b10101010, r5` as I had previously said.

## Status Register

Quick review - how many registers does the MSP430 have?  16.  How many of these have special purposes?  4 - program counter (PC), stack pointer (SP), status register (SR), and constant generator (CG).

Last lesson we learned how the SR and CG are used to shorten the length of instructions involving common constants and allow for immediate addresssing.

When used normally, the CG is hardwired to 0.

The status register, on the other hand, has a very specific purpose.  Here's its structure:

**On projector**

| 15 | 14 | 13 | 12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| Reserved	colspan=7 | V | SCG1 | SCG0 | OSCOFF | CPUOFF | GIE | N | Z | C |

Don't worry about the upper 7 bits - they're unused.

The remainder are flags.  Some control interrupts or the various low-power modes the MSP430 can be placed in (SCG1, SCG0, OSCOFF, CPUOFF, GIE).  We'll talk about those further down the road.  Some are read to gain information about the result of a previous operation.  These are what we'll focus on today.

[x86 has a FLAGS register](http://en.wikipedia.org/wiki/FLAGS_register) that is structured very similarly to this - so your personal computers function the same way.

### Result of Previous Operations

**Number Circle on the board**

Many of the bits in the Status Register can give us information about the results of previous operations.

The V bit is the **overflow** bit.

Who can tell me what an overflow is?

This indicates that the signed two's-complement result of an operation cannot fit in the available space.  Remember, in two's-complement the most significant bit is the sign bit.  If I had a large positive number and added it to another positive number, the result could spill over into the most significant bit and appear negative, even though the addition of two positive numbers can't be negative.  For instance, `0x7fff + 0x01` would result in `0x8000`.  In unsigned addition, this result is correct.  In signed, it isn't.  So this flag is only meaningful when dealing with signed numbers.

```
mov.w   #0x7fff, r5
add.w   #1, r5          ; sets N, V

mov.b   #0x80, r5       ; note how MOV doesn't impact flags.  BIC, BIS don't either.
add.b   #0x80, r5       ; sets C, V, Z - resets N

mov.b   #0x7f, r5
sub.b   #0x80, r5       ; sets N - resets Z, C
```

In practice, it is set when the result of adding two positive numbers is negative or the result of adding two negative numbers is positive.  Essentially, when the sign of the result is different when adding two numbers with the same sign.  It is never set when adding numbers with different signs.  This could also result if positive - negative = negative or negative - positive = positive.

The N bit is the **negative** bit.

**This is the same as the first bit of the result of the previous operation.**  This only works for signed numbers - where the MSB of the result indicates the sign.  1 indicates a negative number, 0 a positive.

```
mov.w   #0x8001, r5
cmp.w   #0x1, r5        ; sets N, C

cmp.w   #0x1000, r5     ; sets C, V - resets N
add.w   #00001111b, r5  ; sets N - resets C, V
```

The Z bit is the **zero** bit.

This is set if the result of the previous operation is 0.  If not, it is cleared.  This functions the same way for both signed and unsigned numbers.  This is commonly used to test for equality.  You'd subtract two numbers - if the result is 0, they are equal.

```
mov.w   #10, r5
cmp.w   #10, r5         ; sets C, Z
                        ; note how CMP only sets flags, along with BIT, TST

sub.w   #10, r5         ; sets C, Z
tst     r5              ; sets C, Z 
                        ; talk about how tst emulated CMP #0, dst
```

The C bit is the **carry** bit.

The carry bit is used to indicate that the result of an operation is too large to fit in the space allocated.  For instance, say the register `r7` had the value 1.  The operation `add.w #0xffff, r7` would result in `0000` in `r7` and the C bit being set.  In that situation, we'd say a carry occurred.

Logical instructions set C to the opposite of Z - i.e. C is set if the result is NOT 0.

Some code to step through that will set / clear these flags (ask which flags should be set):
```
mov.w   #1, r7          
add.w   #0xffff, r7     ; sets C, Z

mov.w   #1, r7
add.w   #0x7fff, r7     ; sets N, V - resest C, Z

mov.w   #0xffff, r7
add.w   #0xffff, r7     ; sets N, C - resets V

xor.w   #10101010b, r7  ; logical ops set C to the opposite of Z 

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

Oftentimes, we want to execute certain pieces of code conditionally.  In computer science, **control flow** refers to the order in which instructions in a program are executed.  Higher level languages use constructs like if/then/else statements or switch statements or loops to achieve this.  

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

`JNE` just checks the zero flag.  `JLO` just checks the carry flag.  Don't read more into the mnemonics - they're there to make your code more readable.

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
    cmp     #5, r7              ; set C - why is the carry flag set here?  think about how CMP is SUB and how the SUB operation is implemented
    jge     greater             ; if N == V, jump
    mov     #0xbeef, r7
    jmp     done                ; always jump
greater:
    mov     #0xdfec, r7
done:
    ; example of a loop
    mov     #0, r6
    mov     #10, r7
loop:                           ; count upward by 2 ten times
    add     #2, r6
    dec     r7
    jnz     loop

forever:                        ; trap CPU
    jmp     forever
```

What's the distance limitation on our jumps?  -1024 - +1022.  So we can't jump throughout our entire memory map (which is 64k in size).  The `BR` instruction is an emulated instruction for a `MOV` to the `PC` - this allows us to move anywhere in the map we choose.

One additional instruction:

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| BR dst | MOV dst, PC |

This instruction is simply a MOV to the PC.  So, with `BR` we have access to the full range of addressing modes if PC-relative is not acceptable.

## Final Notes

No HW tonight!  But Lab 1 is coming (and will align with Parents Weekend), so it would be in your best interest to take a look and get a head start on it if you can.

# Lesson 7 Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Arithmetic Instructions
- Logic Instructions
- Shift / Rotate Instructions
- Watch Dog

Last time, we discussed the Status Register and how it's used in conditional code exectuion in assembly language programs.  We saw how we could use it and relative jump instructions to implement higher level code constructs like if/then and looping.  This time, we're going to learn about a lot more of the available MSP430 instructions - what they do, what flags they set, etc. - it will be our last lesson on the instruction set.  After today, I'll expect that you're all comfortable using these instructions to write your own assembly programs.


## Arithmetic Instructions

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 0101 | ADD src, dest | dest += src | |
| 0110 | ADDC src, dest | dest += src + C | |

```
mov     #0xabab, r10
add     #0xabab, r10    ;which flags will be set?  carry and overflow

addc    #5, r10         ;result is 0x575c because of the carry

```

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 0111 | SUBC src, dest | dest += ~src + C | |
| 1001 | SUB src, dest | dest -= src | Implemented as dest += ~src + 1 |

```
mov     #10, r10
sub     #5, r10         ;which flags will be set?  carry because we're adding the 2's complement!  Remember - 2's complement is 1 + bitwise not

subc    #3, r10         ;since the carry is set, why did this only subtract 3?  Because we're doing bitwise not - and adding the carry makes it the 2's complement
```

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 1001 | CMP src, dest | dest - src | Sets status only; the destination is not written. |
| 1010 | DADD src, dest | dest += src + C, BCD (Binary Coded Decimal) | |

Compare sets the flags based on subtracting the destination from the source - but it does not write to the destination.  It can be a little tricky to wrap your head around.

```
mov     #1, r10
cmp     #10, r10        ;evaluates 1-10, sets negative flag - remember, subtraction involves adding the 2's complement (a bit-wise invert + 1)

mov     #10, r10
cmp     #1, r10         ;evaluates 10-1, sets carry flag - remember, subtraction involves adding the 2's complement (a bit-wise invert + 1)
```

DADD does binary coded decimal (BCD) addition.  In BCD, each nibble represents a binary digit.  So if I used DADD to add 0x0009 and 0x1, the result would be 0x0010 - not 0x000A.  This can actually be very useful if you're recording a value for later output in decimal.

```
clrc
mov     #0x0009, r10
dadd    #1, r10
```

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| DEC(.B) dst | SUB(.B) #1, dst |
| DECD(.B) dst | SUB(.B) #2, dst |
| INC(.B) dst | ADD(.B) #1, dst |
| INCD(.B) dst | ADD(.B) #2, dst |

The assembler provides some emulated increment / decrement commands.  The D postfix means double - so it will increment or decrement by 2.

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| ADC(.B) dst | ADDC(.B) #0, dst |
| DADC(.B) dst | DADDC(.B) #0, dst |
| SBC(.B) dst | SUBC(.B) #0, dst |

This final set of emulated instructions allows you to add or subtract the carry bit by itself.

```
incd    r10
dec     r10

sbc     r10             ;why doesn't this subtract one?  think about what the operation is doing

setc
adc    r10
```

## Logic Instructions

These instructions can be very useful for manipulating / testing individual bits.  They're the foundation for the emulated instructions we talked about last time that set or clear flags in the Status Register.

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 1011 | BIT src, dest | dest & src | Sets status only; the destination is not written. |
| 1100 | BIC src, dest | dest &= ~src | The status flags are NOT set. |
| 1101 | BIS src, dest | dest &#124;=src | The status flags are NOT set. |

Logical operators AND and XOR are available as well.  These operations set status flags, while the BIC / BIS operators don't.

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 1110 | XOR src, dest | dest ^= src | |
| 1111 | AND src, dest | dest &= src | |

```
mov     #0x8000, r12
bit     #0xffff, r10        ;set negative flag, carry flag - for logic instructions, carry opposite of zero flag.  does not impact $r10
bis     #0xdfec, r10        ;does not set status flags.  $r10 is 0xdfec 
bic     #0xfff0, r10        ;does not set status flags.  $r10 is 0x000c 
xor     #0xece0, r10        ;set negative flag, carry flag.  $r10 is 0xecec
and     #0xff00, r10        ;set negative flag, carry flag.  $r10 is 0xec
```

There are a few emulated logical instructions: INV, CLR, and TST.  TST has unique behavior in that it always clears the V flag and set the C flag.  N and Z are set as expected.

INV will flip all of the bits, CLR sets all bits to 0, TST compares the dst to 0.

| Emulated Instruction | Assembly Instruction | Notes |
| :---: | :---: | :---: | :---: |
| INV(.B) dst | XOR(.B) #-1, dst | Sets overflow if result sign is different than inputs |
| CLR(.B) dst | MOV(.B) #0, dst | No flags set, since it's a MOV |
| TST(.B) dst | CMP(.B) #0, dst | V always clear, C always set |

```
mov     #0xec00, r10
inv     r10                 ;$r10 is 0x13ff, set overflow and carry flags
bic     #0b0000000100000000, r2     ;clear overflow bit
mov     #0x8000, r10
inv     r10                 ;$r10 is 0x7fff, set overflow and carry flags

clr     r10                 ;$r10 is 0 - status flags not set because this is a mov instruction
tst     r10                 ;set zero, carry flags
inv     r10                 ;$r10 is 0xffff, set negative and carry flags
tst     r10                 ;set negative, carry flags  
```

## Shift / Rotate Instructions

| Opcode | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 000 | RRC(.B) |  9-bit rotate right through carry. C->msbit->...->lsbit->C. Clear the carry bit beforehand to do a logical right shift. |
| 001 | SWPB | Swap 8-bit register halves.  No byte form. |
| 010 | RRA(.B) | Badly named, this is an arithmetic right shift - meaning the most significant bit is preserved. LSB moves into carry. |
| 011 | SXT | Sign extend 8 bits to 16.  No byte form. |

If the carry is cleared, RRC is a logical right shift.  RRA is an arithmetic right shift.  Since the MSB is preserved, this is a way to divide by 2.  Since the LSB is discarded, the result is always rounded down.

SXT sign extends the MSB of the lower byte into the upper byte.  SWPB sways 8-bit register halves.

```
clrc
mov     #0b10010101, r10
rrc.b     r10                     ;r10 is now 01001010, carry is set 
rrc.b     r10                     ;r10 is now 10100101, carry bit is clear

rra.b     r10                     ;r10 is now 11010010, carry bit is set 
rra.b   r10                     ;r10 is now 11101001, carry bit is clear

swpb    r10
swpb    r10

sxt     r10
```

Rotate left is emulated by addition.  A rotate left is the equivalent of multiplication by two, so it is emulated by adding the destination to itself.  

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| RLA(.B) | ADD(.B) dst, dst |
| RLC(.B) | ADDC(.B) dst, dst |

```
mov     #2, r10
rla     r10         ;$r10 is now 0x4
rla     r10         ;$r10 is now 0x8 
setc
rlc     r10         ;$r10 is now 0b10001, or 0x11
```

## Watch Dog

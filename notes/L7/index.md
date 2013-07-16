# Lesson 7 Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Arithmetic Instructions
- Logic Instructions
- Shift / Rotate Instructions

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

Compare sets the flags based on subtracting the destination from the source - but it does not write to the destination.  

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

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 1011 | BIT src, dest | dest & src | Sets status only; the destination is not written. |
| 1100 | BIC src, dest | dest &= ~src | The status flags are NOT set. |
| 1101 | BIS src, dest | dest &#124;=src | The status flags are NOT set. |
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

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| INV(.B) dst | XOR(.B) #-1, dst |
| CLR(.B) dst | MOV(.B) #0, dst |
| TST(.B) dst | CMP(.B) #0, dst |

## Shift / Rotate Instructions

| Opcode | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 000 | RRC(.B) |  9-bit rotate right through carry. C->msbit->...->lsbit->C. Clear the carry bit beforehand to do a logical right shift. |
| 001 | SWPB | Swap 8-bit register halves.  No byte form. |
| 010 | RRA(.B) | Badly named, this is an arithmetic right shift - meaning the most significant bit is preserved. |
| 011 | SXT | Sign extend 8 bits to 16.  No byte form. |

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| RLA(.B) | ADD(.B) dst, dst |
| RLC(.B) | ADDC(.B) dst, dst |

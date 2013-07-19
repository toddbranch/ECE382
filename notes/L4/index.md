# Lesson 4 Notes

## Readings
Davies 5.2 (pp125 - pp131)  
[MSP430 Addressing Modes](http://mspgcc.sourceforge.net/manual/x147.html)

*Note*: Davies is great for walking through each addressing mode step-by-step and showing how it's relevant to higher-level programming.  MSP430 Addressing Modes addresses some of the nuances and conversion to machine code.

## Assignment
[Addressing Modes](L4_addressing_modes.html)

## Lesson Outline
- Addressing Modes
- Converting to Machine Code
- CompEx1 Intro

## Addressing Modes

Last lesson, we discussed the MSP430 instruction set and ended with converting a few instructions from assembly language to machine code.  We noticed that in order to convert from assembly language to machine code, you've got to have an excellent understanding of the instruction to include the **addressing modes** it uses to reference its operands.  Learning about all of the different addressing modes also gives us a better understanding of the kinds of instructions we can write and how they work.

Luckily, the MSP430 has only 4 different addressing modes to cover:

| Code | Addressing Mode | Description |
| :-: | :-: | :-: |
| 00 | Rn	| Register direct |
| 01 | offset(Rn) | Register indexed |
| 10 | @Rn	| Register indirect |
| 11 | @Rn+	| Register indirect with post-increment |

Review - Who can name the three different instruction types and their formats?  One operand, relative jump, and two operand.

| 15 | 14 | 13 | 12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 0 | 0 | Opcode colspan=3 | B/W | Ad colspan=2 | Dest reg colspan=4 |
| 0 | 0 | 1 | Condition colspan=3 | PC offset (10 bit) colspan=10 |
| Opcode colspan=4 | Source reg colspan=4 | Ad | B/W | As colspan=2 | Dest reg colspan=4 |

Today, we're going to cover the full range of MSP430 addressing modes, practice some more conversion from assembly to machine code, and introduce you to your first computer exercise.

Relative jumps don't use addressing modes.  Let's try one of those:
```
forever:
    jmp     forever
```

Disassembled:
```
c01c:	ff 3f       	jmp	$+0      	;abs 0xc01c
```

The first 3 bits will always be `001`.  Next, we'll find the condition code - `111`.  Finally, we need to calculate the PC offset - -2 in our case, since the PC increments immediately when we execute an instruction.  Remember, we're jumping 2x the sign-extended offset.  So our jump is going to be -1 or `1111111111`.  So our hand-assembled machine code instruction is `0011 1111 1111 1111` or `ff 3f` in little-endian hex.

Using an *offset* is important because it allows us to have relocatable code.  It doesn't matter where our code ultimately gets placed in memory because we're only jumping relative to our position within the code.

Ok, let's get into the instructions that actually use addressing modes.

### Register Mode or Register Direct

This is the most straight-forward addressing mode - taking information / values directly from the CPUs registers.  We covered it a little last time.  

Some examples:
```
mov.w   r11,r10     ;move the word from r11 into r10 - both the source and destination addressing modes are register direct

swpb    r10         ;swap the upper and lower byte of r10
```

Disassembled:
```
c010:	0a 4b       	mov	r11,	r10	
c012:	8a 10       	swpb	r10		
```

If used in a one-operand instruction, the Ad value is `00`.  If used in a two operand instruction, Ad would be `0` because there are only two available addressing modes - register direct and indexed.  As would be `00`.

*[Go through conversion from assembly to machine of first `mov` instruction]*

What's this instruction doing?  Moving the value in r11 to r10.

Since this is a two-operand instruction, the first 4 bits are the opcode, which we'll look up - it's `0100`.  Next, we need to indicate the source register - r11, which is `1011` in binary.  Next, we need to know the addressing mode of the destination.  It's Register Direct - `0`, it only needs a single bit because there are only two ways the destination can be addressed - Register Direct or Register Indexed, so the LSB of the code.  Next, we need to know if it's a byte or word instruction.  It's a word, so `0`.  Finally, source addressing mode - also Register Direct, so `00`.  Finally, we need the destination register, r10 - `1010`.  So our hand-assembled machine code instruction is `0100 1011 0000 1010` or `0a 4b` in little-endian hex.

*[Go through conversion from assembly to machine of first `swpb` instruction]*

What's this instruction doing?  Swapping the upper and lower bytes of r10.

Since this is a one-operand instruction, the first 6 bits are `000100`.  Next, we need the opcode, which we'll look up - `001`.  Next, B/W - only word available for this, so `0`.  Next, Ad - Register Direct, so `00`.  Finally, destination register - r10, so `1010`.  Final binary is `0001 0000 1000 1010` or `8a 10` in little-endian hex.

### Indexed Mode

In this mode, you're adding an offset to a given register to determine the actual address.  Let's say I had an instruction `add.w   4(r10), r11`.  Let's say r10 has the value 0xc000.  This would say find the value at the memory address 4 + r10 = 0xc004 and add it to r11.  So we'd find the value at memory address 0xc004 and add it to the value in r11 and store the result in r11.

An example:
```
mov.w   #0x200, r6
mov.w   r6, r5
mov.w   #0xbeef, 2(r6)    ;places 0xbeef at address 0x0202
mov.w   2(r6), 6(r5)   ;this would move the word in the memory location at 2+r6 into the memory location at 6+r5 - so 0xbeef will be copied to 0x0206
```
Disassembled:
```
c01c:	36 40 00 02 	mov	#512,	r6	;#0x0200
c020:	05 46       	mov	r6,	r5	
c022:	b6 40 ef be 	mov	#-16657,2(r6)	;#0xbeef, 0x0002(r6)
c026:	02 00 
c028:	95 46 02 00 	mov	2(r6),	6(r5)	;0x0002(r6), 0x0006(r5)
c02c:	06 00 
```

If used in a one-operand instruction, the Ad value is `01`.  If used in a two operand instruction, Ad would be `1`.   As would be `01`.

Let's look at the `mov` instruction above.  This is the first time we've looked at a three-word instruction.  The second word is holding our source offset and the third word is holding our destination offset.  These are called extension words.  If we specify Register Indexed, the CPU knows to look at the PC for the offset and then increment it afterwards!


Let's hand-assemble it.  Since it's a two-operand instruction, first is the opcode - `0100` in this case.  Then is the source register - r6 - `0110`.  Then comes destination addressing mode - Register Indexed - `1`.  Next, B/W - `0` for word.  Next, source addressing mode - Register Indexed - `01`.  Finally, destination register - r5 - `0101`.  Binary instruction is `0100 0110 1001 0101` or `95 46` in little-endian hex.

It may seem a little convoluted right now - why would we address this way?  We'll see that this addressing mode is extremely useful when working with higher level data structures like arrays or referencing variables on the stack once we begin to work with C.

#### PC Relative

We can also index off of the program counter!  It might look something like this:
```
    mov.w   magic_number, r7

magic_number:
    .word   0xafaf
```

In practice, the assembler will convert our magic_number reference to an offset from the program counter and replace it with 0xXXXX(r0).

But be careful - this only works for locations that are always the same distance relative to the PC.  Absolute locations, like peripherals, or locations that get located away from our executable code, like RAM, wouldn't work.  Read only data `.rodata` works great with this addressing mode.

### Register Indirect Mode

Register indirect is when you're accessing the value at the *memory location* contained in a register.  It is the same as using Register Indexed with an offset of 0.  The reason you'd use this instead is that it saves a word of memory - you don't need to specify an extension word of 0!

This addressing mode is available only for the source and is coded `10`.

An example:
```
mov.w   #0x200, r6          ;storing the location of the start of RAM in r6
mov.w   #0xcccc, &0x0200    ;storing 0xcccc at that location
mov.w   @r6, r7             ;now 0xcccc is in r7
```
Disassembled:
```
c032:	36 40 00 02 	mov	#512,	r6	;#0x0200
c036:	b2 40 cc cc 	mov	#-13108,&0x0200	;#0xcccc
c03a:	00 02 
c03c:	27 46       	mov	@r6,	r7	
```

Let's hand-assemble to see what's going on.  First, is the opcode - `0100`.  Next, source register - r6 - `0110`.  Next, Ad - register direct, so `0`.  Next, B/W - word, so `0`.  Next, As - register indirect, so `10`.  Finally, destination register - r7, `0111`.  Binary - `0100 0110 0010 0111`, or little-endian hex - `27 46`.  Note no extension word!

This would be useful if a register holds a memory address, a pointer in C, instead of a value.

### Register Indirect Mode with Post-Increment

This is the same as the Register Indirect, but we'll increment the address contained in the register afterwards.    It is extremely useful in specifying immediate values for instructions.

This addressing mode is available only for the source and is coded `11`.

```
mov.w   #0xC7, r9   ;move C7 into r9 - only destination uses register direct.
```

```
c014:	39 40 c7 00 	mov	#199,	r9	;#0x00c7
```

First, what's the opcode?  `0100`.  Next, we need source register - we're using immediate, indicated by the #.  In assembly, this means we'll specify the value in the instruction.  In machine code, this means we'll put the value immediately after the instruction and reference it using the PC - see how `c7 00` is right after the instruction in the disassembly?  This is known is **register indirect** because we'll take the value in the register as an *address* and use the value at that address.  We'll also want to increment the PC by 2 after so it points to the next instruction - known as **post-increment**.  The PC is r0, `0000`.  Next, destination addressing mode - register direct, so `0`.  Next, B/W - word, so `0`.  Next, source addressing mode - register indirect with post increment as we said earlier - `11`.  Next, destination register - r9, which is `1001`.  Our binary instruction is `0100 0000 0011 1001` or `39 40` in little-endian hex.

An immediate cannot be used for the destination!

### Special Cases

Let's look at a few instructions that might look like ones we've covered, but are handled differently by the MSP430.

```
bis.b   #0xFF, r6   ;set all the bits in r6.  in this instruction, only the destination addressing mode would be register direct 
inv.w   r5          ;remember, inv is an *emulated instruction* - it translates to xor #-1, r5 - only the destination addressing mode would be register direct
```

Disassembled:
```
c018:	76 d3       	bis.b	#-1,	r6	;r3 As==11
c01a:	35 e3       	inv	r5		
```

*[Start going through conversion of `bis.b` instruction]*

First, what's the opcode?  `1101`.  Next, we need source register - we're using immediate, so the PC `0000`.  Next, destination addressing mode - register direct, so `0`.  Next, B/W - byte, so `1`.  Next, As - register indirect with post-increment, so `11`.  Next, destination register - r6 - `0110`.  So our binary instruction is `1101 0000 0111 0110` or `76 d0` in little-endian hex.  But that doesn't match with the disassembly!  And I don't see an immediate value in there either.  What's going on?!

The designers of the MSP430 realized that some of our registers don't make sense to use in certain addressing modes.  The Status Register, which we'll learn about next time, holds various flags - whether the result of the previous operation was 0, whether it was negative, whether it overflowed, etc.  It doesn't make sense to use this in addressing for anything other than register direct.  The same thing goes for R3, which gives a constant zero.  They exploit these available addressing modes by using them to code certain common constants without having to use extension words!  `0xFF` is one of those constants - so we need more information to hand-assemble this instruction.

| Code | Register | Addressing Mode | Description |
| :-: | :-: | :-: |
| 00 | 0010 | r2 | Normal access |
| 01 | 0010 | &< location> | Absolute addressing. The extension word is used as the address directly. The leading & is TI's way of indicating that the usual PC-relative addressing should not be used. |
| 10 | 0010 | #4 | This encoding specifies the immediate constant 4. |
| 11 | 0010 | #8 | This encoding specifies the immediate constant 8. |
| 00 | 0011 | #0 | This encoding specifies the immediate constant 0.  Also normal access. |
| 01 | 0011 | #1 | This encoding specifies the immediate constant 1. |
| 10 | 0011 | #2 | This encoding specifies the immediate constant 2. |
| 11 | 0011 | #-1 | This specifies the all-bits-set constant, -1. |

If you want to access the values stored in r2/r3, register direct addressing works as normal!

Hmm, so in our `bis.b` instruction we're using the immediate -1 - which is a common constant listed above.  That means As should be `11` and the source register should be `0011`.  Let's sub that in and see if it works - our binary is now `1101001101110110` or `37 d3` in little-endian hex - consistent with our disassembly.

But, as programmers, we don't have to remember the way the constant generators work when we're writing assembly.  We can simply code immediate values and the assembler will convert them to the native format using the constant generator automatically.

Let's try the the `inv r5` instruction.  Remember, this is an emulated instruction - it translates to `xor #-1, r5`.

A two-operand instruction - what's the opcode?  `1110`.  Next, we need the source register - since this is a common constant, we find the source register is r3 from the common constants table - `0011`.  Next, Ad - `0` for register direct.  Next, B/W - `0` for word.  The source register also comes from the common constant table - `11`.  Finally, the destination register - r5 - `0101`.  Binary - `1110 0011 0011 0101`, little-endian hex - `35 e3`.

#### Absolute Mode

The last mode we'll talk about is **absolute addressing** - a unique mode given in the common constants table.  In this mode, you are specifiying an absolute location in memory.  You precede the location with an & to tell the assembler this is a literal location.

```
mov.w   #0xff, &0x1111    ;this instruction moves the immediate value 0xff to the memory location 0x1111
mov.w   #0xff, &P1OUT    ;this instruction moves the immediate value 0xff to the memory location P1OUT
```

WARNING - potential pitfall:
```
mov.b   P1OUT,r7        ;in this case, the assembler will interpret P1OUT as PC-relative!  Since P1OUT is a constant memory location, the offset will change after linking!  This could crash the CPU if it references unbacked memory
```
Is not the same as:
```
mov.b   &P1OUT,r7       ;this is what you need to do to move the value in memory location P1OUT into r7
```

Any questions?  I know this was pretty jam-packed - so make sure to do some self-study if you feel uncomfortable with this material.  Addressing modes are fundamental to assembly language programming.
## CompEx1 Intro

*[Pass out CompEx to students]*

The purpose of this CompEx is to get you up and running with the MSP430 Development Kit and CodeComposer (or mspgcc, if you so choose).  By the end of this lab, you'll have written your first assembly program and programmed it to your MSP430.

**Due Dates, Expectations**

**Intro Logic Analyzer this early??? - meaning in this CompEx**

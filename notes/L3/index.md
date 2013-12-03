title = 'Debuggers.  MSP430 Execution Model.  MSP430 Instruction Set.  Converting Assembly to Machine Code.' 

# Lesson 3 Notes

## Readings
[Debuggers](http://en.wikipedia.org/wiki/Debugger)  
[MSP430 Instruction Set](http://mspgcc.sourceforge.net/manual/x223.html)

## Assignment
[Execution](L3_execution.html)

## Lesson Outline
- MSP430 Execution Model
- MSP430 Instruction Set
- Converting Assembly to Machine Code

## Admin

- Funny video!
- Collect skills reviews at end of class

## Review

**On Board!**

- Different types of instructions
    - One Operand
        - `SWPB r7`
    - Relative Jump
        - `JNE loop`
    - Two Operand
        - `add r5, r6`
        - `add src, dst`
        - `dst = dst + src`
        - `dst += src`
    - Three Operand?
        - `add r5, r6, r7`
        - These don't exist!
- Specifying values
    - `#10`
        - What's the `#` mean?
        - What base is this number in?
    - `#0x10`
        - What base is this number in?
    - `#0b10`
        - What base is this number in?

Assembler does the work of base conversion for you.

## MSP430 Execution Model

You're going to get the firehose approach here.  I'm going to expose you to a bunch of new, different instructions and tools.  If you don't understand something, ask.  The goal is to get us writing code as quickly as possible.

Last time, we introduced the MSP430, talked a little about its architecture, and we wrote and ran our embedded "hello, world!" program.

Can anyone tell me what the process is to convert an assembly language program to an executable that we can load onto our chip?

**Assembly Language Program --> Assembler --> Relocatable Object Code --> Linker --> Executable Binary**

Ask questions about what each stage in the process does.

Be familiar with this process - we'll be using it and building on it for the remainder of the course.  And it's the way computer programs on every computer are run.

So last time, we walked through this process at the command line level - just to show you what's going on at the lowest level.  The IDE you'll be using - CCS - does a lot of that for you.  So let's take a look at how that program might work in CCS.

Let's start from scratch.  Check out all of the variants available - each has different combinations of peripherals, memory.

What variant of the MSP430 are we using?  **MSP430G2553**

Let's check out the boilerplate you'll be given.

Ask about different elements.  What does the `.text` directive do?  Where does our main ROM start?  Talk about SP initialization, WDT.

Let's add the three lines of code that lit up our LEDs in the Main Loop section.

```
            bis.b   #0xff, &P1DIR
            bis.b   #0xff, &P1OUT

forever     jmp     forever
```

Briefly walk through program again.  What do the `bis.b` statements do?

Remember all the nerdery we had to go through to make this work last time?  All that goes on behind the scenes in CCS.  But it's doing all the same work under the hood.

**Build, Show Console window, show different steps in process**

To analyze how this program executes on the chip, we're going to use a tool called a **debugger**.  It allows us to step through code gradually and monitor the impact of different instructions on the state of the chip.

Anyone used a debugger before?  Can anyone name any debuggers?

There's a debugger built into Code Composer.  This is an important tool you'll use a lot in analyzing the behavior of your program when you encounter errors.

**Open up the disassembly window.**  Looking at our disassembled program, at what address does our program begin?  0xc000.  What does the program counter do?  It holds the address of the instruction that's about to be executed.

View registers - PC holds 0xc000!  What's this instruction do?  What's the address of our next instruction?  So once I **step** to the next instruction, what should be in PC?

*[Go through instruction by instruction until it's clear everyone gets it]*

*[When you get to the `bis.b` instructions, look at the P1 registers to watch them change]*

That's a little boring.  Let's add some code that does something more interesting.  Let's say I want to add the numbers `10+9+8+...+1`, how would I do it in a high-level language?  Ok, let's write assembly to do that.

**Walk through what each instruction does, have them calculate result**

```
            mov.w       #10, r6
            mov.w       #0, r5

summation   add.w       r6, r5
            dec         r6
            jnz         summation

            mov.w       r6, &0x0200

forever     jmp         forever
```

It's boring to have to step through this entire thing.  I want to see what r6 contains when this is over with.  How can I do that?  Breakpoints!  Set breakpoint at `mov` instruction, execute.  Look at contents of `r5` and `r6`.  I can also examine memory - let's see what wound up being stored at 0x0200.  **Open memory window, look at contents, step, watch them change.**

Remember last time when I said if we referenced undefined memory, our CPU would reset?  I wasn't quite right.  If we try to execute instructions in these areas, it will reset.  Writing won't do anything, reading will give you undefined results.

How can we change the address of the current instruction we're executing?  Write to the PC!

Let's add this instruction to see what happens.

`mov.w      #0x9000, $SP`

Power up clear!


Debuggers are a tool we'll use a lot.  Here's some more cool features that will help you get to the bottom of problems:

- Set breakpoints to stop execution at points of interest.
- View items of interest
- Examine memory directly

## MSP430 Instruction Set

As I said last lesson, the MSP430 has only 27 native instructions.  There are three instruction formats - one operand, relative jumps, and two operand.  These tables are all taken from [MSP430 Instruction Set](http://mspgcc.sourceforge.net/manual/x223.html). 

Anyone remember the standard word / datapath size for the MSP430?  16 bits.  All instructions are 16 bits long.  Their binary format looks like this:

| 15 | 14 | 13 | 12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 0 | 0 | Opcode colspan=3 | W=0/B=1 | Ad colspan=2 | Dest reg colspan=4 |
| 0 | 0 | 1 | Condition colspan=3 | PC offset (10 bit) colspan=10 |
| Opcode colspan=4 | Source reg colspan=4 | Ad | W=0/B=1 | As colspan=2 | Dest reg colspan=4 |

*[Spend a short bit of time describing this table and the fields]*

We'll use the above table a lot next lesson when we spend a lot of time converting assembly language to machine code by hand.

If instructions can be both word or byte instructions, they're word by default.  You can specify byte by appending .B to the instruction.  You can also explicitly add .W for word, but that's unnecessary.

We'll go through these instructions in a lot more detail as the semester goes on - so I don't expect you to know all of them right now.

*[Go through, only highlighting interesting instructions.  Don't spend much time on jumps or status register manipulation]*

### One Operand Instructions

| Opcode | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 000 | RRC(.B) |  9-bit rotate right through carry. C->msbit->...->lsbit->C. Clear the carry bit beforehand to do a logical right shift. |
| 001 | SWPB | Swap 8-bit register halves.  No byte form. |
| 010 | RRA(.B) | Badly named, this is an arithmetic right shift - meaning the most significant bit is preserved. |
| 011 | SXT | Sign extend 8 bits to 16.  No byte form. |
| 100 | PUSH(.B) |  Push operand on stack. Push byte decrements SP by 2. Most significant byte not overwritten.  CPU BUG: PUSH #4 and PUSH #8 do not work when the short encoding using @r2 and @r2+ is used. The workaround, to use a 16-bit immediate, is trivial, so TI do not plan to fix this bug. |
| 101 | CALL |  Fetch operand, push PC, then assign operand value to PC. Note the immediate form is the most commonly used. There is no easy way to perform a PC-relative call; the PC-relative addressing mode fetches a word and uses it as an absolute address. This has no byte form. |
| 110 | RETI | Pop SP, then pop PC. Note that because flags like CPUOFF are in the stored status register, the CPU will normally return to the low-power mode it was previously in. This can be changed by adjusting the SR value stored on the stack before invoking RETI (see below). The operand field is unused. |
| 111 | Unused | |

These are of the format `RRA    r10`.

Touch on RRC, SWPB, RRA, SXT.

RRC - when would we use it?  Division. `1000` -> `0100`
RRA - preserves sign in division. `1000` -> `1100`

### Relative Jumps

How many bits do we have for offset in a jump?  What is the range of signed numbers?

These are all PC-relative jumps, adding twice the sign-extended offset to the PC, for a jump range of -1024 to +1022.  Remember, the PC increments by 2 the instant the instruction begins execution (for JMP instructions).

| Condition Code | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 000 | JNE/JNZ | Jump if Z==0 (if `!=`) |
| 001 | JEQ/Z | Jump if Z==1 (if `==`) |
| 010 | JNC/JLO | Jump if C==0 (if unsigned `<`) |
| 011 | JC/JHS | Jump if C==1 (if unsigned `>`) |
| 100 | JN | Jump if N==1 - Note there is no jump if N==0 |
| 101 | JGE | Jump if N==V (if signed `>=`) |
| 110 | JL | Jump if N!=V (if signed `<`) |
| 111 | JMP | Jump unconditionally |

These are of the format `JMP    loop`.

Talk about differences in naming between loops that do the same thing - good for code readability depending on what you're doing.

### Two Operand Instructions

These are generally of the form `OP src, dst` which actually means `dest = src OP dest`.

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 0100 | MOV src, dest | dest = src | The status flags are NOT set. |
| 0101 | ADD src, dest | dest += src | |
| 0110 | ADDC src, dest | dest += src + C | |
| 0111 | SUBC src, dest | dest += ~src + C | |
| 1000 | SUB src, dest | dest -= src | Implemented as dest += ~src + 1 |
| 1001 | CMP src, dest | dest - src | Sets status only; the destination is not written. |
| 1010 | DADD src, dest | dest += src + C, BCD (Binary Coded Decimal) | |
| 1011 | BIT src, dest | dest & src | Sets status only; the destination is not written. |
| 1100 | BIC src, dest | dest &= ~src | The status flags are NOT set. |
| 1101 | BIS src, dest | dest &#124;=src | The status flags are NOT set. |
| 1110 | XOR src, dest | dest ^= src | |
| 1111 | AND src, dest | dest &= src | |

These are of the format `ADD r9, r10`.

Talk about `~` - one's complement.  Use it to describe difference between SUBC, SUB.

BCD - each decimal digit can be coded with 4 bits.  Takes care of the carries, etc. for you.

Talk about `+=`, `-=`, `^=`.

Walk thorugh how BIC, BIS work.

### Emulated Instructions

There are a number of instructions that will be understood by the assembler that aren't native to the instruction set.  24 in total.  These are known as 'emulated' instructions.  They are actually implemented using one of the core instructions.  So, including emulated instructions, there are 51 different assembly instructions you can write.

Assembler will make the swap for you behind the scenes - can make your code much more readable.

| Emulated Instruction | Assembly Instruction | Notes |
| :---: | :---: | :---: |
| NOP | MOV r3, r3 | Any register from r3 to r15 would do the same thing. |
| POP dst | MOV @SP+, dst | |

There are other ways to make NOPs - instructions that don't do anything - taking different numbers of cycles.  These can be useful in timing.

Branch and return can be done by adjusting the PC.

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| BR dst | MOV dst, PC |
| RET | MOV @SP+, PC |

These instructions are useful for manipulating the status register.

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

Shift / rotate left are emulated with ADD.  Use `0100 + 0100 = 1000`.

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| RLA(.B) | ADD(.B) dst, dst |
| RLC(.B) | ADDC(.B) dst, dst |

What does it mean to rotate left in binary?

Some common one-operand instructions:

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| INV(.B) dst | XOR(.B) #-1, dst |
| CLR(.B) dst | MOV(.B) #0, dst |
| TST(.B) dst | CMP(.B) #0, dst |

Increment / decrement:

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| DEC(.B) dst | SUB(.B) #1, dst |
| DECD(.B) dst | SUB(.B) #2, dst |
| INC(.B) dst | ADD(.B) #1, dst |
| INCD(.B) dst | ADD(.B) #2, dst |

Adding / subtracting using only the carry bit:

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| ADC(.B) dst | ADDC(.B) #0, dst |
| DADC(.B) dst | DADD(.B) #0, dst |
| SBC(.B) dst | SUBC(.B) #0, dst |

Here's a sample program using some of these instructions.  Let's walk through it using our **debugger**.
```
repeat:
    mov.b     #0x75, r10
    add.b     #0xC7, r10
    ;result should be 0x13c, so we should see 3c in r10 and carry bit set
    adc     r10
    ;since carry bit was set, this should increment r10 to 3d
    inv.b     r10
    ;invert, so r10 should be c2
    mov.w   #0x00aa, r10
    sxt     r10
    ;sign extend should clear upper 8 bits
    inv     r10 
    swpb    r10
    mov.w   r10, r9

    jmp     repeat
```

Disassembled:
```
c010:	7a 40 75 00 	mov.b	#117,	r10	;#0x0075
c014:	7a 50 c7 00 	add.b	#199,	r10	;#0x00c7
c018:	0a 63       	adc	r10		
c01a:	7a e3       	xor.b	#-1,	r10	;r3 As==11
c01c:	3a 40 aa 00 	mov	#170,	r10	;#0x00aa
c020:	8a 11       	sxt	r10		
c022:	3a e3       	inv	r10		
c024:	8a 10       	swpb	r10		
c026:	09 4a       	mov	r10,	r9	
c028:	f3 3f       	jmp	$-24     	;abs 0xc010
```

**This was as far as we got.**

## Converting Assembly to Machine Code

*[This can spill over into the next lesson if necessary]*

How can we be sure that the assembler is doing its job?  How can we know that it is producing the proper machine code for the instructions we've given it?  The table I showed initially gives us the tools to manually convert assembly to machine code as well as the reverse

Our three types of instructions and their binary breakdown:

| 15 | 14 | 13 | 12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 0 | 0 | Opcode colspan=3 | B/W | Ad colspan=2 | Dest reg colspan=4 |
| 0 | 0 | 1 | Condition colspan=3 | PC offset (10 bit) colspan=10 |
| Opcode colspan=4 | Source reg colspan=4 | Ad | B/W | As colspan=2 | Dest reg colspan=4 |

Addressing modes cover how our instructions reference their operands - the pieces of information they need to do their job.  Our available addressing modes (we'll learn more about this next time) and their binary breakdown:

| Code | Addressing Mode | Description |
| :-: | :-: | :-: |
| 00 | Rn	| Register direct |
| 01 | offset(Rn)	| Register indexed |
| 10 | @Rn	| Register indirect |
| 11 | @Rn+	| Register indirect with post-increment |

Let's try a couple to get us familiar with the process.

First, let's convert a single-operand instruction - `SXT r10` - from our disassembly, `c020:	8a 11       	sxt	r10`

The first six bits are always `000100`.  Next comes the opcode, which we'll look up - it's `011`.  Since this is a word instruction, B/W will be `0` - byte would be 1.  We'll learn about addressing modes tomorrow, but the addressing mode we use here is called Register Direct because we're referencing the value contained in a register and is coded by `00`.  Finally, we have to specify our destination register r10 - what's the binary for 10?  `1010`.  So our hand-assembled machine code instruction is `0001 0001 1000 1010` or `8a 11` in little-endian hex.

Let's try a relative jump instruction - `JMP $-24` - from our disassembly, `c028:	f3 3f       	jmp	$-24     	;abs 0xc010`.   This instruction jumps back to the start of our code - -24 from 0xc028.

The first 3 bits will always be `001`.  Next, we'll find the condition code - `111`.  Finally, we need to calculate the PC offset - -26 in our case, since the PC increments immediately when we execute an instruction.  Remember, we're jumping 2x the sign-extended offset.  So our jump is going to be -13 or `1111110011`.  So our hand-assembled machine code instruction is `0011 1111 1111 0011` or `f3 3f` in little-endian hex.

Luckily, when we're writing assembly we don't have to worry about calculating the PC offset - the assembler does that work for us!  That's why labels are so useful.

Let's try a two-operand instruction - `mov r10, r9` - from our disassembly, `c026:	09 4a       	mov	r10,	r9`.

The first 4 bits are the opcode, which we'll look up - it's `0100`.  Next, we need to indicate the source register - r10, which is `1010` in binary.  Next, we need to know the addressing mode of the destination.  It's Register Direct - `0`, it only needs a single bit because there are only two ways the destination can be addressed.  Next, we need to know if it's a byte or word instruction.  It's a word, so `0`.  Finally, source addressing mode - also Register Direct, so `00`.  Finally, we need the destination register, r9 - `1001`.  So our hand-assembled machine code instruction is `0100 1010 0000 1001` or `09 4a` in little-endian hex.

**Tough One!** - this introduces some addressing concepts, which we'll discuss next lesson.  Potentially a teaser.

Let's try another two-operand instruction - `add.b #0xC7, r10` - from our disassembly, `c014:	7a 50 c7 00 	add.b	#199,	r10	;#0x00c7`.

This addes the value 0xC7 to r10.

The first 4 bits are the opcode, which we'll look up - it's `0101`.  Next, we need to indicate the source register.  Since we're using an immediate, we'll look at the word following our instruction for our value - the location pointed to by the PC  - so the source is the PC `0000`.  Next, we need to know the addressing mode of the destination.  It's Register Direct - `0`, it only needs a single bit because there are only two ways the destination can be addressed.  Next, we need to know if it's a byte or word instruction.  It's a byte, so `1`.  Finally, source addressing mode - we're referencing the value at the address pointed to by the PC, so register indirect - we also need to post-increment so it contains the next executable instruction.  So register indirect with post-increment - `11`.  The PC always increments by 2 when this is specified because the word size is 2 bytes.  Finally, we need the destination register, r10 - `1010`.  So our hand-assembled machine code instruction is `0101 0000 0111 1010` or `7a 50` in little-endian hex.


Easy enough?!

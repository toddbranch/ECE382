# Lesson 2 Notes

## Readings

## Lesson Outline
- Intro to the MSP430
- MSP430 Architecture
- Assembly and Mahcine Languages

## Intro to the MSP430

**Issue Launchpad Kits**

## Architecture
Remember, the Instruction Set Architecture (ISA) is the programmer's API into the CPU.

Any architecture will consist of:

- set of operations (instructions)
- data units (sizes, addressing modes, etc)
- registers
- interaction with memory
- program counter

## MSP430 Architecture
- RISC architecture

- Set of Operations
    - 27 Instructions in 3 families
        - Single-operand arithmetic
        - Conditional jump
        - Two-operand arithmetic

- Registers
    - Four special purpose
        - r0 - Program Counter
        - r1 - Stack Pointer
        - r2 - Status Register
        - r3 - Constant Generator
    - 12 general purpose

- Interaction with Memory

- Little Endian
    - Discuss endianness (Big vs Little Endian)
    - Endianness is concerned with the ordering of bytes on a computer.
    - Little Endian means the least significant byte of a chunk of data is stored at the lowest memory address.
        - The MSP430 and your computer, presuming you run an x86_64 processor use this.
    - Big Endian means the most significant byte of a chunk of data is stored at the lowest memory address.
        - The 68S12 we used last semester used this

## Assembly and Machine Languages

### Assembly Language
Now that we're familiar with our API, how do we interact with it?  How do we talk to the computer?

- To command a computer, you must understand its language:
    - **Instructions:** words in a computers language
    - **Instruction Set:** the dictionary of the language
- Instructions indicate the operation to perform and the instructions to use
    - **Assembly Language:** human-readable format of computer instructions
    - **Machine Language:** computer-readable instructions - binary (1's and 0's)

### Assembly Process
**Machine vs Assembly**

Computers run on machine code, so why even worry about assembly?  Because machine code is hard to read.  Here's some machine code (in hex) for a factorial program on the MSP430:
```
  0x0000c000    55422001 35d0085a 82450002 31400004 
  0x0000c010    3f400000 0f930824 92420002 20012f83 
  0x0000c020    9f4fbcc0 0002f823 3f400000 0f930724 
  0x0000c030    92420002 20011f83 cf430002 f9230441 
  0x0000c040    24533150 d8ff3f40 0500b012 6ec0844f 
  0x0000c050    d6ff3f40 0900b012 6ec0844f fcff0f43 
  0x0000c060    31502800 32d0f000 fd3f3040 bac00412 
  0x0000c070    04412453 2183844f fcff8493 fcff0324 
  0x0000c080    9493fcff 02201f43 093c1f44 fcff3f53 
  0x0000c090    b0126ec0 1e44fcff b012a2c0 21533441 
  0x0000c0a0    30410d4f 0f430e93 072412c3 0d100128 
  0x0000c0b0    0f5e0e5e 0d93f723 30410013          
```

Here's the equivalent assembly.  It's not beautiful because it was produced by a compiler, but much easier to read.  Assembly is the human-readable equivalent of machine code.
```
factorial:
	push	r4
	mov	r1, r4
	add	#2, r4
	sub	#2, r1
	mov	r15, -4(r4)
	cmp	#0, -4(r4)
	jeq	.L2
	cmp	#1, -4(r4)
	jne	.L3
.L2:
	mov	#1, r15
	jmp	.L4
.L3:
	mov	-4(r4), r15
	add	#llo(-1), r15
	call	#factorial
	mov	-4(r4), r14
	call	#__mulhi3
.L4:
	add	#2, r1
	pop	r4
	ret
main:
	mov	r1, r4
	add	#2, r4
	add	#llo(-40), r1
	mov	#5, r15
	call	#factorial
	mov	r15, -42(r4)
	mov	#9, r15
	call	#factorial
	mov	r15, -4(r4)
	mov	#0, r15
	add	#40, r1
```

*\[DEMO - show [C code](factorial.c) that was compiled to generate this\]*

In semesters past, we've spent a lot of time working directly with assembly.  A lot of people complained that it's irrelevant - could not be farther from the truth.  Every single program that runs on your computer followed this process.  Every single program becomes assembly code.
*[Demo - disassemble 'ls' command and show x86_64 assembly]*

Since the code we'll be writing isn't for the machine we're running on, we'll be using a **cross-assembler**.  All this means is the assembler is creating machine code for an architecture different than what it's running on.

**Let's write our first MSP430 program.**

```
.text
    main:
    bis.b   #0xFF, &P1DIR
    bis.b   #0xFF, &P1OUT

.section ".vectors", "a"
    .org    0x1e
    .word   main
```

[DEMO: show the program on the computer, program the MSP430, show the result - Both LEDs light up]

**We'll walk through how this program executes in the next lesson.**

# Lesson 2 Notes

## Readings
[Assembler][http://en.wikipedia.org/wiki/Assembler_(computing)#Assembler]
[Linker][https://en.wikipedia.org/wiki/Linker_(computing)]

## Lesson Outline
- Intro to the MSP430
- MSP430 Architecture
- Assembly and Mahcine Languages

## Intro to the MSP430

The family of microcontrollers we'll be working with for the remainder of the semester is TI's MSP430 - it's the first semester we've ever used it.  For the past many years, we've used Motorola's 68S12 as our platform - but it had become less relevant and the tools we used were no longer being supported.  Last year, I went out looking for a platform that would be easy to learn, but still relevant.  The MSP430 is an industry leader in low-cost, low-power consumption embedded applications - and it uses a RISC architecture with just 27 instructions.

[Products in the Wild Using MSP430](http://www.43oh.com/2012/03/winner-products-using-the-msp430/)

Suffice to say, this chip is used by engineers to create real-world products that you've probably interacted with before.  Cool!

The other cool thing - they're cheap!  The MSP430 Launchpad development kit costs only $5 including shipping, so you can definitely get your own if you want to experiment with this beyond the semester.  We can also get replacement chips cheaply for when you inevitably burn them out.

**Issue Launchpad Kits, Geek Boxes**

For the rest of the semester, you'll be using these kits along with CodeComposer to learn about the msp430 and build things with it.

## Architecture
Ok, back to the dirty details about computer architecture.

Remember, the Instruction Set Architecture (ISA) is the programmer's API into the CPU.

Any architecture will consist of:

- set of operations (instructions)
- registers
- data units 
- addressing modes
- memory organization

## MSP430 Architecture

I'll give a brief overview of the MSP430's ISA - we'll go a lot more in depth in these areas in the next few lessons.

- RISC architecture
    - fewer instructions
    - emulates higher-level instructions
        - for instance, `NOP`
    - 16-bit datapath
        - word size is 16 bits
        - all instructions are 16 bits long

- Set of Operations
    - 27 Instructions in 3 families - we'll talk about these next time
        - Single-operand 
            - for instance, `SWPB`
        - Conditional jump
            - for instance, `JMP    jump_label`
        - Two-operand 
            - for instance, `MOV    r12, r10`

- Registers - 16 bits wide
    - fast memory that holds values in-use by the CPU
    - Four special purpose
        - r0 - Program Counter - holds address of instruction currently being executed
        - r1 - Stack Pointer - address of top of stack
        - r2 - Status Register - holds flags related to various conditions
        - r3 - Constant Generator - 0, but can assume other values for different addressing modes (L4)
    - 12 general purpose
        - can be used to hold anything you want

- Data Units
    - word size is 16 bits
        - words must lie on **even addresses**
    - instructions for byte and word actions
        - `MOV.B`
        - `MOV.W`
    - words must use even memory address
    - byte-addressable

- Addressing Modes
    - how programmers reference operands in instructions
    - register direct, for instance
        - `MOV    r12, r10`
    - will discuss them in detail in L4

- Memory Organization

*[Spend some time here]*

![MSP430 Memory Map](memory_map.jpg)

*[Briefly discuss what each section is used for, etc.]*

We'll be working with the **msp430g2553** variant.  
512b of RAM - 0x200-0x400  
16kb of ROM - 0xc000-0xffdf  

0x1100-0xc000 is empty!  There is no memory backing it up!  Other variants of the msp430 might use it, but ours is specialized for purposes that don't need much memory - making it cheaper.  If you attempt to write to this area of memory, you'll trigger what's essentially a **segmentation fault** because that memory doesn't exist.  It will cause the chip to do a Power-up Clear (PUC), resetting the state of your processor.

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

- To command a computer, you must understand its language (ISA):
    - **Instructions:** words in a computers language
    - **Instruction Set:** the dictionary of the language

So we're going to write some instructions out of its instruction set.  
As I said earlier, the MSP430 has 27 instructions in its instruction set.  How do we write them?

- Instructions indicate the operation to perform and the instructions to use
    - **Assembly Language:** human-readable format of computer instructions
    - **Machine Language:** computer-readable instructions - binary (1's and 0's)

Computers run on 1s and 0s - machine code.  Assembly is the human-readable equivalent.  For the first half of this course, we'll be writing in assembly.  We use an **assembler** to convert from assembly to machine code.

### Assembly Process
**Let's write our first MSP430 program.**  
*[DEMO Open vim and write this program, walking through instructions as they're written]*

```
; This program sets all pins on Port 1 to output and high.  Since LEDs 1 and 2 are connected to P1.0 and P1.6 respectively, they will light up.

.equ    WDTPW, 0x5a00
.equ    WDTHOLD, 0x0080
.equ    WDTCTL, 0x0120
.equ    P1DIR, 0x0022
.equ    P1OUT, 0x0021

.text
main:
    mov.w   #WDTPW, r15
    xor.w   #WDTHOLD, r15
    mov.w   r15, &WDTCTL
    bis.b   #0xFF, &P1DIR
    bis.b   #0xFF, &P1OUT
loop:
	jmp loop

.section ".vectors", "a"
    .org    0x1e
    .word   main
```

*Walk through the basic idea of the program.*

For the machine to be able to execute our code, we have to convert it to machine code.  That's where the assembler comes in.

Here's the first step of our assembly process:
**Assembly Language Program --> Assembler --> Relocatable Object Code**

Since the code we'll be writing isn't for the machine we're running on, we'll be using a **cross-assembler**.  All this means is the assembler is creating machine code for an architecture different than what it's running on.

To accomplish it, I run the command `msp430-as -mmcu=msp430g2553 lightLED.S -o lightLED.o`

The output is a file called lightLED.o - a file containing relocatable object code.  Here's what the machine code looks like:

```
Hex dump of section '.text':
  0x00000000 3f40005a 3fe08000 824f2001 f2d32200 
  0x00000010 f2d32100 b0120000 ff3f             
```
Are we good to go?  Can we just load this on our MCU?  No!

Think back to our memory map - can we write this region of memory?  No, that's where our special function registers and memory-mapped peripherals are.

This file is formatted this way so that its code is relocatable.  In the future, we may want to combine this with code from other files to create a single executable.  So we need something that can potentially combine multiple object code files and place their code at the correct memory location depending on the MCU.  The tool we use for this job is called a **linker**.

**Assembly Language Program --> Assembler --> Relocatable Object Code --> Linker --> Executable Binary**

To accomplish this, I run the command `msp430-ld lightLED.o -o lightLED.elf -L /usr/msp430/lib/ldscripts/msp430g2553 -T /usr/msp430/lib/ldscripts/msp430.x`

*[Show memory.x file for msp430g2553]* - this is how the linker knows memory map for our particular chip.

Here's what the machine code looks like now:
```
Hex dump of section '.text':
  0x0000c000 3f40005a 3fe08000 824f2001 f2d32200
  0x0000c010 f2d32100 b0121ac0 ff3fc243 21003041
```
It's located at c000, the start of our flash ROM block!  Great!  Now we can use it to program the chip.

[DEMO: show the program on the computer, program the MSP430, show the result - Both LEDs light up]

Let's disassemble the program.  This will take our executable and attempt to convert it back to assembly.  It gives us a good idea of which hex bytes correspond to which instructions.

```
Disassembly of section .text:

0000c000 <__ctors_end>:
    c000:	3f 40 00 5a 	mov	#23040,	r15	;#0x5a00
    c004:	3f e0 80 00 	xor	#128,	r15	;#0x0080
    c008:	82 4f 20 01 	mov	r15,	&0x0120	
    c00c:	f2 d3 22 00 	bis.b	#-1,	&0x0022	;r3 As==11
    c010:	f2 d3 21 00 	bis.b	#-1,	&0x0021	;r3 As==11

0000c014 <loop>:
    c014:	ff 3f       	jmp	$+0      	;abs 0xc014
```
From this disassembly, how can we tell if this is big-endian or little-endian?

**We'll walk through how this program executes in the next lesson.**

In years past, we've spent a the entire semester working directly with assembly.  A lot of people complained that it's irrelevant - could not be farther from the truth.  Every single program that runs on your computer followed this process.  Every single program becomes assembly code.  
*[Demo - disassemble 'ls' command and show x86_64 assembly]*

`objdump -d /usr/bin/ls`

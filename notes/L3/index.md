# Lesson 3 Notes

## Readings
[MSP430 Instruction Set](http://mspgcc.sourceforge.net/manual/x223.html)

## Lesson Outline
- MSP430 Execution Model
- MSP430 Instruction Set
- Converting Assembly to Machine Code

## MSP430 Execution Model
Last time, we introduced the MSP430, talked a little about its architecture, and we wrote and ran our first program.

Can anyone tell me what the process is to convert an assembly language program to an executable that we can load onto our chip?

**Assembly Language Program --> Assembler --> Relocatable Object Code --> Linker --> Executable Binary**

*[Touch on what each stage in the process does]*

Be familiar with this process - we'll be using it and building on it for the remainder of the course.  And it's the way computer programs on every computer are run.

Ok, remember the program we ended last class period on.
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
Let's send it through our assembly process and load it onto our chip.  It works!  Just like last time.  But **how** does it work?  Let's learn about how the MSP430 executes the code we've given it.

I'll **disassemble** the executable to give us a better idea of where the linker wound up placing our instructions.  Disassembly is the process of converting machine code into assembly language.
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

To analyze how this program works, I'm going to use a tool called a **debugger**.  It allows us to step through code gradually and monitor the impact of different instructions on the state of the chip.  The debugger I'll use is call **gdb** (GNU Debugger) and can be used to debug programs on just about any architecture there is.

Looking at our disassembled program, at what address does our program begin?  0xc000.  

**Say something about the clock, clock speed, how long each instruction takes to execute**

## MSP430 Instruction Set

## Converting Assembly to Machine Code
How can we be sure that the assembler is doing its job?  How can we know that it is producing the proper machine code for the instructions we've given it?

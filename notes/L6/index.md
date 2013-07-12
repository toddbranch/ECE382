# Lesson 6 Notes

## Readings
[Reading 1](/path/to/reading)

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

The status register, on the other hand, has a very specific purpose. 

| 15 | 14 | 13 | 12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| Reserved	colspan=7 | V | SCG1 | SCG0 | OSCOFF | CPUOFF | GIE | N | Z | GC |

Don't worry about the upper 7 bits - they're unused.

The remainder are flags.  Some are read to gain information about the result of a previous operation.  Some are set/read to create/determine certain conditions on the chip.

The V bit is the **overflow** bit.

The N bit is the **negative** bit.

The Z bit is the **zero** bit.

The C bit is the **carry** bit.

## Flow of Control

## Movement Instructions

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

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| BR dst | MOV dst, PC |

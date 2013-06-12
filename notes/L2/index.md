# Lesson 2 Notes

## Readings

## Lesson Outline
- Intro to the MSP430
- MSP430 Execution
- MSP430 Instruction Set

## Intro to the MSP430

### Architecture
Any architecture will consist of:
- set of operations (instructions)
- data units (sizes, addressing modes, etc)
- registers
- interaction with memory
- program counter

#### Assembly Language
- To command a computer, you must understand its language:
    - **Instructions:** words in a computers language
    - **Instruction Set:** the dictionary of the language
- Instructions indicate the operation to perform and the instructions to use
    - **Assembly Language:** human-readable format of computer instructions
    - **Machine Language:** computer-readable instructions - binary (1's and 0's)

**Machine vs Assembly**  
Talk about compilation, assembly, linking process

In semesters past, we've spent a lot of time working directly with assembly.  A lot of people complained that it's irrelevant - could not be farther from the truth.  Every single program that runs on your computer followed this process.  Every single program becomes assembly code.
[Demo - disassemble 'ls' command and show x86_64 assembly]

#### MSP430 Architecture
A simple MSP430 program
```
.text
    main:
    bis.b   #0xFF, &P1DIR
    bis.b   #0xFF, &P1OUT

.section ".vectors", "a"
    .org    0x1e
    .word   main
```

## MSP430 Execution

## MSP430 Instruction Set

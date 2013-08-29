# Lab 1 - A Simple Calculator

## Objectives

You'll write your first complete assembly language program using what you've learned in class.  You'll need all of the skills you've learned to this point - the instruction set, addressing modes, conditional jumps, status register flags, assembler directives, the assembly process, etc.  This lab will give you practice in using assembly to implement higher-level if/then/else and looping constructs.

## Details

### The Basic Idea

You'll write a program that interprets a series of operands and operations and stores the results - an assembly language calculator!

Your program will start reading at the location in ROM where you stored the calculator instructions.  It will read the first byte as the first operand.  The next byte will be an operation.  The third byte will be the second operand.  Your program will execute the expected operation and store the result starting at 0x0200.  The result will then be the first operand for the next operation.  The next byte will be an operation.  The following will be the second operand.  Your program will execute the requested operation and store the result at 0x0201.  Your program will continue doing this until you encounter an END_OP - at which point, your program will cease execution.

### Required Functionality

- The input and output for the calculator will be in memory locations.  The calculator operations and operands will be stored in ROM - any location in ROM is acceptable.  The results of the calculations will be stored in RAM starting at 0x0200.  Labels shall be used in the program to refer to the location of your instructions and results.
- The input operands and output results will be positive integers between 0 and 255 (an unsigned byte).
- Good coding standards (labels, .equ where appropriate) must be used throughout.

Your program will implement the following operations:

**ADD_OP**  
An addition operation is coded by the value 0x11.  It adds two numbers and stores the result.  
The calculator program `14 11 12` is equivalent to `0x14 + 0x12`.  It would store the result `26`.

**SUB_OP**  
An subtraction operation is coded by the value 0x22.  It subtracts two numbers and stores the result.  
The calculator program `21 22 01` is equivalent to `0x21 - 0x1`.  It would store the result `20`.

**CLR_OP**  
A clear operation clears the result by storing `00` to memory.  It then uses the second operand as the initial value for the next operation.
The calculator program `21 22 01 44 14 11 12` is equivalent to `0x21 - 0x1 CLR 0x14 + 0x12`.  It would store `20 00 26`.

**END_OP**  
The end operation terminates execution of the calculator.  It is coded by the value 0x55.

Example calculator program: `14 11 32 22 08 44 04 11 08 55`  
It's equivalent to: `0x14 + 0x32 - 0x08 CLR 0x04 + 0x08 END`  
The result should be, stored at 0x0200: `46 3e 00 0c`

Your calculator will be tested with various combinations of input instructions.  Results will be verified using the debugger.

### B Functionality

In addition to the Required Functionality, your program will meet the following requirement:

- If a result exceeds 255, it is set to the maximum value of 255.  If a result is less than 0, it is set to the minimum value of 0.

### A Functionality

In addition to B Functionality, your program will implement a multiply operation:

**MUL_OP**  
An multiplication operation is coded by the value 0x33.  It multiplies two numbers and stores the result.  
The calculator program `02 33 04` is equivalent to `0x02 * 0x04`.  It would store the result `08`.

The MSP430G2553 that you're using does not have a hardware multiplier, so you'll have to get creative to implement this.

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

Think about how you'll implement your calculator.  Draw a flowchart of how it will operate - include pseudocode.

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/admin/labs.html) thoroughly and follow it.

Since you haven't learned about them yet, don't use subroutines.  Do everything in the main program.  You'll get to use subroutines in future labs.

- Comments
    - Assume the reader is a competent assembly language programmer
    - Comment above blocks of code to convey **purpose**
    - Only comment individual lines when purpose is unclear
- Labels
    - Descriptive!
        - loop or loop1 or l1 or blah - not acceptable!
    - Used for all memory location, jumps, etc. 
- Constants
    - Use `.equ` syntax for all constants!
    - Don't want to see naked values
- Instruction Choice
    - Use the instruction that makes your code readable!
        - `JHS` rather than `JC`
        - `INCD` rather than `ADD #2`
    - Well-written code requires few comments
- Spacing
    - Align your code to make it readable
    - Put whitespace between logical blocks of code

## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 5 | | BOC L9 |
| Required Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 35 | | COB L10 |
| B Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L10 |
| A Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L10 |
| Lab Notebook | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ----- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 40 | | COB L11 |
| **Total** | | | **100** | | |

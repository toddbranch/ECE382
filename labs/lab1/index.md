title = 'Lab 1 - Assembly Language - "A Simple Calculator"'

# Lab 1 - Assembly Language - "A Simple Calculator"

[Teaching Notes](notes.html)

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
The calculator program `0x14 0x11 0x12` is equivalent to `0x14 + 0x12`.  It would store the result `0x26`.

**SUB_OP**  
An subtraction operation is coded by the value 0x22.  It subtracts two numbers and stores the result.  
The calculator program `0x21 0x22 0x01` is equivalent to `0x21 - 0x1`.  It would store the result `0x20`.

**CLR_OP**  
A clear operation, represented by the value 0x44, clears the result by storing `00` to memory.  It then uses the second operand as the initial value for the next operation.
The calculator program `0x21 0x22 0x01 0x44 0x14 0x11 0x12` is equivalent to `0x21 - 0x1 CLR 0x14 + 0x12`.  It would store `0x20 0x00 0x26`.

**END_OP**  
The end operation terminates execution of the calculator.  It is coded by the value 0x55.

Example calculator program: `0x14 0x11 0x32 0x22 0x08 0x44 0x04 0x11 0x08 0x55`  
It's equivalent to: `0x14 + 0x32 - 0x08 CLR 0x04 + 0x08 END`  
The result should be, stored at 0x0200: `0x46 0x3e 0x00 0x0c`

Your calculator will be tested with various combinations of input instructions.  Results will be verified using the debugger.

### B Functionality

In addition to the Required Functionality, your program will meet the following requirement:

- If a result exceeds 255, it is set to the maximum value of 255.  If a result is less than 0, it is set to the minimum value of 0.

### A Functionality

In addition to B Functionality, your program will implement a multiply operation:

**MUL_OP**  
An multiplication operation is coded by the value 0x33.  It multiplies two numbers and stores the result.  
The calculator program `0x02 0x33 0x04` is equivalent to `0x02 * 0x04`.  It would store the result `0x08`.

The MSP430G2553 that you're using does not have a hardware multiplier, so you'll have to get creative to implement this.

There are a couple of ways to implement multiply - **strive for the fastest possible implementation**.  Solutions that multiply in O(n) time will receive half points.  Only solutions that multiply in O(log n) time will receive full points.

O(n) means that the time it takes to reach a solution varies with the size of the input.  O(log n) means that time to solvevaries with the log of the size of the input.

## Prelab

Print out the grading section.  Hand it in to your instructor, complete with functionality marks, when the lab is due.  

Include whatever information from this lab you think will be useful in creating your program.

Think about how you'll implement your calculator.  Draw a flowchart of how it will operate - include pseudocode.

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/admin/labs.html) thoroughly and follow it.

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

## Test Cases!

[Test Cases](test_cases.html)

## Grading

Name:<br>
Documentation:<br>

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** | | 5 | | BOC L9 |
| Required Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 35 | | COB L10 |
| B Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L10 |
| A Functionality - O(n) | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 5 | | COB L10 |
| A Functionality - O(log n) | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 5 | | COB L10 |
| Lab Notebook | **On-Time:** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 40 | | COB L11 |
| **Total** | | | **100** | | |

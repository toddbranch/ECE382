title = 'Lab 4 - C - "Etch-a-Sketch and Pong"'

# Lab 4 - C - "Etch-a-Sketch and Pong"

## Objectives

You've spent the last 5 lessons transitioning from programming in assembly language to C.  In this lab, you'll use C to create an etch-a-sketch-type program that utilizes some subroutines from Lab 3.  You'll be expected to write clean, maintainable, modular code that is committed regularly to Git.

## Details

### Required Functionality


Modify your assembly drawBlock function to take in 3 values: an x coordinate, a y coodinate, and a color.  

Create an etch-a-sketch program using the directional buttons of the LCD booster pack to control the position of the paint brush. The paint brush will draw 8x8 blocks of pixels. The user will change the position of the paint brush by pressing the directional buttons. Each button press will move the cursor 8 pixels in the direction pressed (see table below). Pressing the auxiliary button (SW3) will toggle the mode of the paint brush between filling squares and clearing squares.

| Button | Function |
| --- | --- |
| SW5/Up |	Move the cursor up 1 block |
| SW4/Down	| Move the cursor down 1 block |
| SW2/Left	| Move the cursor left 1 block |
| SW1/Right | Move the cursor right 1 block |
| SW3/Aux | Toggle the color of the paint brush |

This program must be written in C and call many of the subroutines written as part of lab 3, including drawBlock and changePosition. 

Mind your coding standards!  Commit regularly with descriptive commit messages!

### B Functionality

Create a bouncing block!  This block should move across the screen with no more than 8 pixels per jump.  It should bounce off the walls appropriately, similar to assignment 6.  An adequate delay movement should be added between each block movement.  Your starting position and starting x and y velocities should be initialized in your header, or should be randomly generated. 

### A Functionality

Create Pong on your display! Create a single paddle that will move up and down on one side of the display, controlled by the up and down buttons.  The block will bounce off the paddle like it bounces off the wall.  When the block misses hitting the paddle, the game will end.  

### Bonus Functionality

Each bonus functionality can be achieved in conjunction with either A or B functionality.  These functionalities must be written in assembly and called by C.  Each is worth 5 points.

Circle: Instead of a bouncing block, create a bouncing circular ball!

Fine movement: Instead of having the ball/paddle move in 8-pixel jumps, have it move in 1-pixel jumps.

Inverted display: With a push of the SW3 button, invert the display.  Dark pixels will become light pixels, and vice versa.  Instead of a bouncing dark ball, you will have a bouncing light ball.

Note:  The maximum lab grade cannot exceed 105.

## Given Code
- [lab4.c](lab4.c)
- [nokia.asm](nokia.asm)
- [simpleLab4.c](simpleLab4.c)

## Prelab


### Data types

Go to page 76 of the C Compiler User's Guide to complete the following table. For the type, fill in data type that produces a variable of the given size. For max/min values, write in the maximum and minimum values that can be represented with the data type in that row.  Two examples have been given.

| Size | Signed/Unsigned | Type | Min value | Max value |
| --- | --- | --- | --- | --- |
| 8-bit | unsigned | | | |
| 8-bit | signed | | | |
| 16-bit | unsigned | unsigned short | | |
| 16-bit | signed | | | |
| 32-bit | unsigned | | | |
| 32-bit | signed | | -2,147,483,648 | |
| 64-bit | unsigned | | | |
| 64-bit | signed | | | | |

When writing embedded C code, it is always a good idea to separate your code from the architecture as much as possible because to make the code easier to change. This is why it is better to:
- use the peripheral register names in your code (e.g. P2IN) rather than their address (e.g. 0x28).
- use peripheral register field names in your code 

Because space is limited on microcontrollers, it is a common practice to use variables with a range suitable for the task at hand. Unfortunately, there is no standard among C compilers between the basic data types like char, short, long and the number of bits in the underlying data representation. Furthermore, when writing and reading code, it is not readily apparent how many bits are in a short or long variable. Consequently, we will write our programs using typed definitions that provide an obvious connection between the data type and the number of bits in the representation. 

Start by consulting the [Typedef Wikipedia page](http://en.wikipedia.org/wiki/Typedef). Next, fill in the following chart with the appropriate C code definitions.

| Type | Meaning | C typedef declaration |
| --- | --- | --- |
| int8 | unsigned 8-bit value |  |
| sint8 | signed 8-bit value |  |
| int16 | unsigned 16-bit value | typedef unsigned short int16;|
| sint16 | signed 16-bit value |  |
| int32 | unsigned 32-bit value |  |
| sint32 | signed 32-bit value |  |
| int64 | unsigned 64-bit value |  |
| sint64 | signed 64-bit value |  | |

### Calling/Return Convention

Make a project around simpleLab4.c. While the functioning of the program is not really that important, let's first take some time to understand what is going on in this program before we look at the underlying assembly language. Use CCS to step through the program and examine the a, b, c, d, e variables in main, just after the call to the function func in line 16.

| Iteration | a | b | c | d | e |
| --- | --- | --- | --- | ---| --- |
| 1st | | | | | | 
| 2nd | | | | | | 
| 3rd | | | | | | 
| 4th | | | | | | 
| 5th | | | | | |  |

Now examine the assembly code generated by the compiler by selecting the View -> Disassembly menu item. You should see the disassembly window as a selectable tab in the subwindow where your registers are displayed. To fill in the following table with the appropriate values, you have a few tasks:
- Firstly, find the code for the function `func` and write down the starting and ending address in the table below. 
- Next, identify which registers are used to pass the input parameters from main to the function. Write their identities below. If it is not clear which register holds which input parameter, test it out!  Go ahead and change the code, so that `func` only has one input parameter, recompile the code, and then examine the assembly. 
- Finally, determine which register is used to return the value from func to main.

| Parameter | Value Sought |
| --- | --- |
| Starting address of `func` | |
| Ending address of `func` | |
| Register holding w | |
| Register holding x | |
| Register holding y | |
| Register holding z | |
| Register holding return value | | |

### Cross language build constructs

Answer the following questions:

What is the role of the `extern` directive in a .c file?  Hint: check out the [external variable](http://en.wikipedia.org/wiki/External_variable) Wikipedia page.
<br><br><br><br><br>





What is the role of the `.global` directive in an .asm file (used in lines 28-32)?  Hint: reference section 2.6.2 in the MSP 430 Assembly Language Tools v4.3 User's Guide.
<br><br><br><br><br>

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/admin/labs.html) thoroughly and follow it.

Mind your code style!


## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 10 | | BOC L23 |
| Required Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 30 | | COB L24 |
| B Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 15 | | COB L24 |
| A Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L24 |
| Bonus Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 5 each for circle, fine, and inverted | | COB L24 |
| Lab Notebook | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ----- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 35 | | COB L25 |
| **Total** | | | **100** | | | |

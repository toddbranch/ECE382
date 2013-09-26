# Lab 5 - Interrupts - "A Simple Game"

## Objectives

In this lab, you'll use your knowledge of interrupts and the Timer_A subsytem to create a simple game.  To be successful, you'll have to use your knowledge of button debouncing and your LCD driver.

## Details

### The Basic Idea

In this game, the player will be represented by an asterisk (*), starting in the top left corner of the screen.  By using push buttons, the player advances through the board.  The goal of the player is to make it to the bottom right corner of the screen.

On your Geek Box, PB1 will move the player right and PB2 will move the player left.  If the player reaches the end of the top line and goes right, they should be placed on the farthest left position on the bottom line.

If the player doesn't move within 2 seconds, the game ends - display "GAME" on the first line and "OVER!" on the second line.  If the player reaches the bottom right corner of the screen, they won - display "YOU" on the first line" and "WON!" on the second line.  Pushing either PB1 or PB2 should initiate a new game.

To achieve B functionality, you'll have to add some additional features to the game.

To achieve A functionality, you'll have to use the MSP430's low power modes to minimize the power consumption of your game.

### Required Functionality

To achieve Required Functionality, you must implement the game as described in The Basic Idea.

Button presses must be handled via interrupts.  The two-second between-move time limit must also be handled via an interrupt and the Timer_A subsystem.

Remember, program time spent inside ISRs should be minimized!  Remember to effectively debounce your buttons!

### B Functionality

In addition to Required Functionality, your game must allow users to move up and down with two different push buttons.  Your game must place two mines in random positions on the board (represented by an "x") that players must navigate around.  If a player navigates onto a bomb, the game is over.  When the player wins, sound the buzzer on the Geek Box!

Include logic in your program that ensures the game is winnable!  You can't have obstacles stacked on top of or diagonal to one another - players couldn't get around them.

The buzzer should be turned off when the player starts a new game.

**TODO: give details on Geek Box buzzer**

### A Functionality

In addition to B Functionality, you must place the MSP430 into the lowest possible power mode between interrupts.  It should "wake up" on interrupt and return to the low power mode once the interrupt is handled.  Show that it's in a low power mode using a multimeter (i.e. contrast a program running in normal mode vs your low power program).

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

Think about how you'll implement your game logic.  Draw a flowchart of how it will operate - include pseudocode, as well as the interfaces to your functions.

Think about the work that will be done in your ISRs and how you'll pass information to your main program.  Remember to minimize the amount of time spent in ISRs. 

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/ECE382/notes/labs.html) thoroughly and follow it.

Remember to effectively debounce your buttons!

## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 5 | | BOC L29 |
| Required Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 30 | | COB L30 |
| B Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 15 | | COB L30 |
| A Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L30 |
| Lab Notebook | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ----- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 40 | | COB L31 |
| **Total** | | | **100** | | |

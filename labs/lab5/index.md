# Lab 5 - Interrupts - "A Simple Game"

## Objectives

In this lab, you'll use your knowledge of interrupts and the Timer_A subsytem to create a simple game.  To be successful, you'll have to use your knowledge of button debouncing and your LCD driver.

## Details

### The Basic Idea

In this game, the player will be represented by an asterisk (*), starting in the top left corner of the screen.  By using push buttons, the player advances through the board.  The goal of the player is to make it to the bottom right corner of the screen.

On your Geek Box, PB1 will move the player right and PB2 will move the player left.  If the player reaches the end of the top line and goes right, they should be placed on the farthest left position on the bottom line.

If the player doesn't move within 2 seconds, the game ends - display "GAME" on the first line and "OVER!" on the second line.  If the player reaches the bottom right corner of the screen, they won - display "YOU" on the first line" and "WON!" on the second line.  At this point, pushing either PB1 or PB2 should initiate a new game.

To achieve A and B functionality, you'll have to add some additional features to the game.

### Required Functionality

To achieve Required Functionality, you must implement the game as described in The Basic Idea.

In the spirit of open source software, you're free to use any LCD library you find on Github.  You can also use the button library I provided last time.

The two-second between-move time limit must also be handled via an interrupt and the Timer_A subsystem.

Remember, program time spent inside ISRs should be minimized!  Remember to effectively debounce your buttons!

You must place your code under version control on git and push your repo to Github.

### B Functionality

In addition to Required Functionality, your game must allow users to move up and down with two different push buttons.  Your game must place two mines in random positions on the board (represented by an "x") that players must navigate around.  If a player navigates onto a bomb, the game is over.  Display a creative message if a player steps on a mine (i.e. "BOOM!"), then the game over screen.

Here's some code that can help you out with random numbers (from K&R's "The C Programming Language"):
```
int rand()
{
  rand_next = rand_next * 1103515245 + 12345;
  return (unsigned int)(rand_next/ 65536) % 32768;
}
```

### A Functionality

(5 pts) Include logic in your program that ensures the game is winnable!  You can't have obstacles stacked on top of or diagonal to one another - players couldn't get around them.

(5 pts) This game is too easy!  Add an additional feature that makes the game more challenging.  Be creative!  Simply making the time limit shorter will not receive any credit.

(5 pts) Handle button presses via interrupts!  There are a couple of ways to do this - make sure you detail your approach and why you chose it.

**Note:** There's the potential for 5 bonus points if you implement all of the features of A Functionality.

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

Think about how you'll implement your game logic.  Draw a flowchart of how it will operate - include pseudocode, as well as the interfaces to your functions.

Think about the work that will be done in your ISRs and how you'll pass information to your main program.  Remember to minimize the amount of time spent in ISRs. 

Think of how to configure Timer_A for your purposes.

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/admin/labs.html) thoroughly and follow it.

Use git / Github and commit regularly with descriptive commit messages!  This is worth 10pts of your grade!

Remember to effectively debounce your buttons!

Think about how you'll pass information between ISRs and your main program.  Remember, global variables are acceptable **only** in this circumstance.

## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 5 | | BOC L29 |
| Required Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 35 | | COB L30 |
| B Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L30 |
| A Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L30 |
| Use of Git / Github | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 10 | | BOC L27 |
| Lab Notebook | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ----- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 30 | | COB L31 |
| **Total** | | | **100** | | |

# Lab 5 - Interrupts - "A Simple Game"

[Teaching Notes](notes.html)

## Objectives

In this lab, you'll use your knowledge of interrupts and the Timer_A subsytem to create a simple game.  To be successful, you'll have to use button and LCD libraries - either your own or open source.

## Details

### The Basic Idea

In this game, the player will be represented by an asterisk (*), starting in the top left corner of the screen.  By using push buttons, the player advances through the board.  The goal of the player is to make it to the bottom right corner of the screen.

On your Geek Box, PB1=right, PB2=left, PB3=up, and PB4=down.  Your game shouldn't allow players to go outside the bounds of the screen.

If the player doesn't move within 2 seconds, the game ends - display "GAME" on the first line and "OVER!" on the second line.  If the player reaches the bottom right corner of the screen, they won - display "YOU" on the first line" and "WON!" on the second line.  At this point, pushing any of the buttons should initiate a new game.

To achieve A and B functionality, you'll have to add some additional features to the game.

### Required Functionality

To achieve Required Functionality, you must implement the game as described in The Basic Idea.

[To allow you to move faster, I've provided you skeleton code.](https://github.com/toddbranch/game_shell)

You'll also need to interface with the LCD and buttons.  In the spirit of open source software, you're free to use any LCD library you find on Github.  You can also use any button library you find on Github.

The two-second between-move time limit must also be handled via an interrupt and the Timer_A subsystem.

Remember, program time spent inside ISRs should be minimized!  Remember to effectively debounce your buttons!

You must place your code under version control on git and push your repo to Github.

### B Functionality

Your game must handle button presses via interrupts!  Functionality will be identical to Required.

Remember the strategy we discussed in class!  We can initially trigger a button on the falling edge, then switch the trigger to rising edge to detect the release.  Here's some sample code:

```
void testAndRespondToButtonPush(char buttonToTest)
{
	if (buttonToTest & P1IFG)
	{
		if (buttonToTest & P1IES)
		{
			movePlayerInResponseToButtonPush(buttonToTest);
			clearTimer();
		} else
		{
			debounce();
		}	
		
		P1IES ^= buttonToTest;
		P1IFG &= ~buttonToTest;
	}
}
```

### A Functionality

#### Mines (10pts)

Your game must place two mines in random positions on the board (represented by an "x") that players must navigate around.  If a player navigates onto a bomb, the game is over.  Display a creative message if a player steps on a mine (i.e. "BOOM!"), then the game over screen.

Randomness is hard!  I found a random number library for the MSP430 on github and forked it to be compatible with CCS: https://github.com/toddbranch/msp430-rng .  Use it!  The `rand()` function generates a random seed.  `prand()` uses this seed to generate subsequent pseudorandom numbers.  You should only call `rand()` once, then let `prand()` generate additional numbers you may need.  You'll need to store each result of `prand()` to use as the seed for the next time you call `prand()`.

Include logic in your program that ensures the game is winnable!  You can't have obstacles stacked on top of or diagonal to one another - players couldn't get around them.

#### Additional Feature (5pts)

This game is too easy!  Add an additional feature that makes the game more challenging.  Be creative!  Simply making the time limit shorter will not receive any credit.

**Note:** There's the potential for 5 bonus points if you implement all of the features of A Functionality.

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

**SPEND TIME ON DESIGN - we will check this!**

Think about how you'll implement your game logic.  Draw a flowchart of how it will operate - include pseudocode, as well as the interfaces to your functions.

Think about the work that will be done in your ISRs and how you'll pass information to your main program.  Remember to minimize the amount of time spent in ISRs. 

Think of how to configure Timer_A for your purposes.

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/admin/labs.html) thoroughly and follow it.

## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 5 | | BOC L29 |
| Required Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 35 | | COB L30 |
| B Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L30 |
| A Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 15 | | COB L30 |
| Use of Git / Github | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 15 | | COB L31 |
| Code Style | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 15 | | COB L31 |
| README | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L31 |
| **Total** | | | **100** | | |

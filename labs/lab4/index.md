# Lab 4 - An LCD Device Driver

## Objectives

You've spent the last 5 lessons transitioning from programming in assembly language to C.  In this lab, you'll use C to write a device driver for the LCD you used in Lab 3.  You'll be expected to write clean, maintainable, modular code that is committed regularly to Git.

## Details

### The Basic Idea

Ever wonder how you plug a mouse into your computer and it "just works"?  That's due in large part to software called a device driver.  Device drivers are low-level software that interface directly with hardware.  In this lab, you'll write a device driver for the LCD in the Geek box.

Unlike Lab 3, you will not be given any code.  The [code from Lab 3](/labs/lab3/given_code.html) will prove useful - but you'll have to port it to C!

The [datasheets](/datasheets) you used in Lab 3, the [Lab 3 documentation](/labs/lab3), and relevant lesson notes will also prove useful.

### Required Functionality

Create an LCD device driver using the C programming language.

Scroll the message "ECE382 is my favorite class!" across the top line of the LCD.  Scroll a message of your choice across the bottom line.

You will want to interface with this LCD again (**in Lab 5**).  I expect you to create a reusable LCD library!  Design a good API in advance - you want this library to be easy to work with in the future.

Mind your coding standards!  Commit to git regularly with descriptive commit messages!

### B Functionality

Create an additional library to deal with buttons and button presses.  Allow the user to select between three different bottom line messages depending on which button they press.

B Functionality Program operation:

- Screen 1
    - Top Line: Message?
    - Bottom Line: Press123
- Screen 2
    - Top Line (scrolling): ECE382 is my favorite class!
    - Bottom Line (scrolling): *Chosen message*

Create a delay library.  It should be capable of generating delays of different length with a single subroutine (i.e. `delayMicroseconds(45)`).  Modify your program to use this library.

### A Functionality

You think your libraries for working with delays, buttons, and the LCD could prove useful to other programmers.  You've decided to release them on Github as open source.

You'll need a separate git repository for each of your libraries.  You'll need to create a README for each covering their API and usage.

You must show me each repo successfully hosted on Github to receive credit.

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

Design the API for your LCD library.

Consider how you'll port different assembly language constructs in the [Lab 3 template code](/labs/lab3/given_code.html) to C.

Consider how you'll create software delays in C.

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/admin/labs.html) thoroughly and follow it.

Use git and commit to it regularly with descriptive commit messages!  This is worth 10pts of your grade!

It might be helpful to start off by porting assembly code directly to C.  But this shouldn't be your final code!  Once you have it working, you should improve its structure using the programming techniques you've learned.

## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 5 | | BOC L25 |
| Required Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 35 | | COB L26 |
| B Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L26 |
| A Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L26 |
| Use of Git | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 10 | | BOC L27 |
| Lab Notebook | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ----- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 30 | | COB L27 |
| **Total** | | | **100** | | |

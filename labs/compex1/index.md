title = 'CompEx 1 - Introduction to the MSP430 and Code Composer Studio'
# CompEx 1 - Introduction to the MSP430 and Code Composer Studio

## Objectives

This computer exercise is designed to familiarize you with the programming environment you'll be using throughout the semester.  You will learn the fundamentals of your tools - the Launchpad development board and the Code Composer Studio Integrated Development Environment (IDE).  Although several commands/functions are presented in this computer exercise, there are many more; don't assume everything you need during the semester is provided in this computer exercise.

## Tasks

Complete the steps in the attached handout and answer the questions at the end of the computer exercise.  Turn in your computer exercise worksheet by **BOC, Lesson 6**.

## Background

Code Composer Studio is an IDE, which means it will help you write code, assemble the code, program the actual hardware, and debug the code in hardware.  It is based on [Eclipse](http://www.eclipse.org), a multi-language IDE that you maby be familiar with.

This computer exercise will take you through writing code, assembling it, flashing it to the MSP430, and using a debugger to step through and analyze your program.

First, we need to install Code Composer Studio.

## Installing Code Composer Studio (CCS)

**This step will be completed as a portion of the Skills Review.**

ECE382 uses the free version of Code Composer Studio, v5.4.x.  [It's available here](http://processors.wiki.ti.com/index.php/Download_CCS).

Download the Windows version of the latest CCS.  You'll have to create an account and fill out some information - it's pretty straightforward.  You'll be approved to receive the software, so download it!

**Follow these steps**

- Run the exe - it might warn you about McAfee running, just ignore that.
- Accept the terms of the license agreement and click Next.
- I accepted the default install folder since I don't have an existing Eclipse installation - modify the path to suit your needs and click Next.
- On the "Setup Type" screen, select Custom and click Next.
- On the "Processor Support" screen, select MSP430 Low Power MCUs and click Next.
- On the "Select Components" screen, select TI MSP430 Compiler Tools and TI Documention under Compiler Tools and MSP430ware Only and Grace (includes MSP430ware) under Device Software, click Next.
- On the "Select Emulators" screen, leave the defaults and click Next.
- On the "CCS Install Options" screen, click Next.

At this point, it will start installing - this will take a long time.

Once installation is complete, uncheck the Launch Code Composer Studio v5 box, but leave the other two checked.  Click finish.

## Creating a New Project in CCS

In this course, we'll use CCS to edit, assemble, flash, and debug programs.  For practice, you'll now write, assemble, flash, and debug a simple program.

Open CCS.

If it asks you to select your workspace, put it in a convenient location.  The default is fine for me.

If it presents the "License Setup Wizard", select the CODE SIZE LIMITED (MSP430) option, click Finish.

Click New Project.

Project settings:

- Name it something descriptive - I'll use Branchflower_CompEx1.
- Leave the output type as Executable.
- Next, you can choose where it will be saved - I'll use the default location.
- Next, we need to select our device.  We'll be using the MSP430G2553, from the MSP430Gxxx Family.  Make sure this is the chip in your Launchpad development board - the kit also comes with a MSP430G2452 chip - we won't be using that.
- Leave the connection as TI MSP430 USB1 [Default].
- Don't touch the advanced settings.
- Expand  "Project templates and examples" - select Empty Assembly-only Project.

Click finish.

This will place you in the "CCS Edit" perspective and give you some boilerplate in your main.asm.  There is some code that is already generated for you.  This is called bolierplate - keep it, this is your starting point.  

The first comment block at the top is your program header.  In that, you should specify the following:

- Lab Name
- Name / Rank / Date Started / Date Last Updated
- Brief (a few sentences) description of the purpose of the program / lab

Make it look something like this:
```
;-------------------------------------------------------------
; Lab 1 - Introduction to the MSP430 and Code Composer Studio
; Capt Todd Branchflower, USAF / 19 Jul 2013 / 19 Jul 2013
;
; This program is a demonstration of using the CCS IDE to
; program, assemble, flash, and debug the MSP430.
;-------------------------------------------------------------
```

This might be a good point to save your work.

## Your First Program

Alright, let's write some code.  Below the comment block that says "Main loop here", write this code:

```
            mov.w   #0xdfec, &0x0200        ;writes 0xdfec to memory location 0x0200
forever     jmp     forever                 ;traps CPU
```

Click the Project menu, then Build All (shortcut Ctl-B).  Fix any errors if necessary.  You'll get a bunch of warnings for unimplemented interrupt handler routines - disregard those for now, we'll talk about interrupts later in the course.

In the Run menu, select Debug (shortcut F11).  If you get an error saying it couldn't find your Launchpad development board, connect it to a USB port on your computer and Retry - you might need to wait a minute for the drivers to install.  *Note: upon initial connection, the LEDs at the bottom of the board will flash.  This is normal - it's a program pre-loaded by TI.*  You're now in the "CCS Debug" perspective.  At the top right of your screen, you should see a small toolbar that lets you change perspective - you'll move between Edit and Debug very often.

The first instruction of your code should be highlighted - `RESET        mov.w   #__STACK_END,SP`.  This initializes the stack pointer, which we'll learn about in a later lesson.  At the top, to the right of the red Stop button, there is a yellow arrow that indicates "Step Into".  Click the button and watch as the instruction is executed, and we move to the next line. 

At the top right, there's a window that has tabs for Variables, Expressions, and Registers.  Select Registers, then Core Registers.  This gives us insight into the values in each of the 16 data registers available on the MSP430.  Your Program Counter (PC) register should read 0xC004.  Click the "Step Into" button again, and watch as the PC changes to 0xC00A indicating the next instruction to be executed.

At this point, you should be on the `mov.w  #0xdfec, &0x0200` instruction.  When this instruction executes, we want to be sure that it works.  Click the View menu, then Memory Browser - this will put a window on the right side of your screen.  It allows us to monitor the contents of memory on the MSP430 in real time.  Enter 0x0200 in the text box at the top of the Memory Browser window - this will show you the contents of memory starting at 0x0200.  In the Memory Browser drop-down, select 8-bit Hex - C Style - this is the way data is actually stored on your chip.

Click the "Step Into" button.  You should see the contents of memory at 0x0200-0x0201 change to 0xEC and OxDF.  It works!  Look at the PC again - it should now read 0xC010.  Right click on it and select View Memory at Value - this will show you the instruction in memory.  Write down the machine code for the instruction - you'll need it to answer a question at the end of the CompEx.
<br>
<br>
<br>
<br>
<br>
We can also use the Memory Browser to change the contents of memory.  Go back to 0x0200, double-click on the memory locations and write in your own values.  You're actually altering the contents of RAM on the chip!

You can also fill blocks of memory.  Right click any memory address and select "Fill Memory...".  In the start address, enter 0x0200.  Length: 50.  Data Value: 0xAB.  Type-size: Char.  Select OK and watch as 50 bytes of RAM are filled!

Click the "Step Into" button - this will enter an infinite loop that will trap our CPU and prevent it from doing anything else.

Push the green Play button at the top of the screen - this will run our code continuously.  Since we've trapped the CPU with an infinite loop, it won't have any effect.  Push the yellow Pause button to pause execution.

Ok, we're done with this tiny piece of code - press the red Stop button.  This will put us back into our "CCS Edit" perspective.

## SCENARIO: Computer Forensics

A member of your unit was emailed a mysterious executable.  Your commander suspects it might be malicious and has asked you to investigate further.  You disassembled the file and recovered the following:
```
            mov.w   #0x0200, r9
            mov.w   #10, r10

            mov.w   #0, r11
            mov.w   r11, 0(r9)

            mov.w   #1, r12
            incd    r9
            mov.w   r12, 0(r9)

loop        tst     r10
            jz      forever

            incd    r9
            dec     r10

            mov.w   r12, r13
            add.w   r11, r12
            mov.w   r12, 0(r9)
            mov.w   r13, r11
            jmp     loop

forever     jmp     forever
```

Your job is to use the programming / debugging skills you've learned to ascertain its purpose.

I'll offer one final tool that you may find useful: **breakpoints**.

It's often tedious to step through code instruction by instruction, but simply running the program doesn't let you see what's happening at different stages in execution.  Breakpoints can help with that.  After building and debugging your program, right click on a line of code in the "CCS Debug" perspective.  Select Breakpoint (Code Composer Studio) and then Breakpoint.  This will set a breakpoint at the instruction you selected - indicated by a marker onthe left side.

Now, when you push the green Play button to run the code, it stops when it hits your breakpoint.  You can investigate the contents of memory, registers, etc. then hit Play again and your code will stop the next time it encounters the breakpoint.

Good luck!

## Questions

Name:
<br>
<br>
<br>
Section:
<br>
<br>
<br>

### Scenario

1. (20pts) What's the purpose of the mystery program?  Don't repeat what each step does, give me a **concise explanation of purpose**.  It should only be one sentence.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
2. (10pts) If you wanted to change the program to make it more readable and understandable, what changes would you make?  **Be specific**.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
3. (10pts) If you were an attacker and wanted to obfuscate (make unclear) the purpose of your code, what changes would you make?  **Be specific**.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### General

4. (10pts) What's the purpose of a breakpoint?  Why are they useful?  Give an example of a situation where you'd use a breakpoint.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
5. (10pts) Consider the `forever    jmp forever` instruction from the simple program you wrote first.  What type of instruction is this?  Hand-assemble the instruction (show your work!).  Is the result the same as the machine code you recorded?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
6. (10pts) Are the values in memory stored in little-endian or big-endian format?  Using the debugger, how can you tell?  If they were stored in the other format, what would it look like?  Give me an example from your code.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
7. (10pts) What additional capabilities does a Hardware Breakpoint offer from a standard breakpoint?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
8. (20pts) Write a program that fills RAM (0x0200 - 0x03ff) with words starting at 0 and counting upward by 2.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

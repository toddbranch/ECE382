title = 'Labs'

# Labs

## General

The labs make up a significant portion of both your prog and final grades.  You must complete each one (even for zero credit) to pass the course.  A disciplined approach to design, implementation, and testing are key to your success!  Wiring and coding the entire lab and then trying to figure out why it doesn't work (they almost never do) can be incredibly painful and time-consuming.  Our experience shows that students who get behind on the labs need to catch up immediately, else the burden of uncompleted labs builds to inescapable levels.

## Lab Notebooks

Lab notebooks will be graded on the CheckPlus / Check / CheckMinus / 0 scale - see the [Grading Policy](grading.html) for details.

Lab notebooks are heavily emphasized in this course and constitute a large portion of lab grades.  Their format must follow the *DFEE Standard for Writing Lab Notebooks*.  The lab notebook is maintained as a journal of your lab experience and should allow you, or any knowledgeable engineer, to recreate your project.  For this course, your notebook should contain at least the following (as applicable to the particular lab):

- Descriptive title
- Objectives or purpose
- Preliminary design
- Software flow chart / algorithms
- Well-formatted code
- Hardware schematic
- Testing methodology / results
- Observations and Conclusions
- Documentation

The actual format is flexible, so don't be afraid to add something later.  All lab reports must stand up to the **"hit by a bus"** standard.  Should you die, another engineer must be able to continue your work without trouble.

You are expected to keep your lab notebooks current as you work on a lab.  You will lose substantial points if sections of the lab notebook which should be part of your documentation before the demonstration (such as prelab, approach, flowcharts, testing, debugging, etc.) are entered afterwards.  Your conclusion section, lessons learned, and your final formatted code are not required before your demo.

### Physical Lab Notebooks

Although handwritten (and in ink), it must be neat.  Erroneous entries (and large amounts of whitespace) must be lined out with a single line, never obliterated.  Each page of the lab notebook must be signed and dated by you.  Papers such as computer printouts may be pasted or taped in the lab notebook with the following restrictions: do not cover up any writing, be sure the edges of the pasted paper don't hang out beyond the edge of the notebook page.  If tape is used, it must completely cover all four edges of the item being affixed to the notebook.  Cut and paste the grading criteria on the first page of the lab.  In general, the lab handout may be cut and pasted in as the first two bullets from the list above.

### Electronic Lab Notebooks

If you choose to use an electronic lab notebook, we'll be using the version control software **git** and your code must be hosted on [Github](http://www.github.com).  Here is the directory structure that must be used:

- /LabX
    - /code
        - Include all source code here
    - /images
        - Include all images you use in your notebook here
    - notebook.md
        - Lab notes not included in your git commit history

Your commit history will be used as verification that you've been keeping your lab notebook up to date as you progress.  You should commit early and often.

You'll still need to paste the grading rubric in your lab notebook so I can record grades as you go.

## Coding Standards

### General

You are expected to use the same structured programming techniques that you were taught in CS110.

You must comment your code where appropriate.  This doesn't mean commenting every line you write - that's distracting and unproductive.  Comments should be used to convey the general purpose of a block of code or explain a section that may be unclear.  You can assume the reader is a knowledgeable engineer.

Use meaningful, readable variable names - variable1 or var1 or loop1 or L1 are unacceptable.

**Don't repeat yourself!**  If you find yourself using the same code over and over, you should abstract it into a subroutine or function.

### Assembly

For constants, you must use `.equ` statements and assign them a meaningful, readable name.

Labels should be used in place of memory addresses and assigned a meaningful, reable name.

You should organize your code in such a way that it's easily readable.  While not required, a good structure would be:

- Headers
- Constants
- Variables
- Main program
- Subroutines
- Interrupt service routines
- Interrupts vectors

Other guidance:

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
    - Don't want to see magic numbers!
- Instruction Choice
    - Use the instruction that makes your code readable!
        - `JHS` rather than `JC`
        - `INCD` rather than `ADD #2`
    - Well-written code requires few comments
- Spacing
    - Align your code to make it readable
    - Put whitespace between logical blocks of code

### C

[Check out the C style guide.](c_style_guide.html)

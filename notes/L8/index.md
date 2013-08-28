# Lesson 8 Notes

## Readings

- [Modularity](http://www.examiner.com/article/programming-concepts-the-benefits-of-modular-programming)
- [Skim the MSP430 Assembly Language Tools datasheet](/datasheets/msp430_assembly_language_tools.pdf)

## Assignment

- [Lab 1](/labs/lab1/index.html) Prelab

## Lesson Outline
- Instruction Execution Time
- More Assembly Process
- Sections
- Directives
- Structured Design and Test
- Lab Guidance
- Lab 1 Introduction

## Admin

- Talk about the HW
    - Anyone get under 25 instructions?
    - Any problems people ran into that they want to talk about?
    - Make sure you turn it in before you leave today.
- Lab 1 next time!
    - Class will meet in the lab
    - Prelab due next time - I'll come around while you're working to check it off.
    - Come prepared and ready to work!
    - Review timeline, key dates on syllabus

What did we talk about last time?  Lots of different instructions: arithmetic ops, logical ops, rotate / shift.  You'll need these instructions to accomplish Lab 1 - which is an assembly calculator.  I'll cover the details at the end of class.

Some notes / corrections:

- Better explanation for SUBC - flip the carry bit!  If C=0, will subtract one more.  If C=1, will not subtract one more.
- What was DADD?  What would happen if `r5 = 0x99` and I `DADD #1, r5`?  Let's find out!  Executing instructions on hardware is a great way to test what they do under different circumstances.

What else did we talk about?  Watchdog timer!  What does that do?  What's its purpose?  How long do we have to deal with it before it resets our chip?  What happens if we mess with `WDTCTL` without using `WDTPW`?

Any questions about stuff from last time?

OK, today is kind of a hodge-podge lesson.  We'll talk a little about instruction execution time in terms of clock cycles.  We'll go into a little more depth about the assembly process.  Then, I'll give you some tools that you'll need for this and future labs: assembly directives, structured design and test, and lab guidance.  Finally, I'll introduce Lab 1 and give you some pointers.  If there's time, I'll let you get going on it.

## Instruction Execution Time

Anyone remember how fast I said the clock on the MSP430 is?  Roughly 1MHz.  It varies from chip to chip, depending on the results of the fabrication process.  The chips are actually factory calibrated - in a future lesson, we'll learn how to access that data off the chip and tune our clocks to precise known frequencies.

If I have a 1MHz clock, what is the length of a single clock cycle?  1 / 1E6 = 1 microsecond.

So how long does this block of code take to execute?

```
        mov     #0x0200, r5
        mov     #0xbeef, 0(r5)
forever jmp     forever    
```

We need more information - how many clock cycles different instructions take to execute!

To the datasheet! (pp60)

### Single Operand Instruction - Cycles and Lengths

![Single Operand Instruction Cycles and Lengths Table](single_operand_cycles.jpg)

### Two Operand Instruction - Cycles and Lengths

![Two Operand Instruction Cycles and Lengths Table](two_operand_cycles.jpg)

### Jump Instruction - Cycles and Lengths

![Jump Instruction Cycles and Lengths Table](jmp_cycles.jpg)

**Ok, back to our program!**

```
        mov     #0x0200, r5
        mov     #0xbeef, 0(r5)
forever jmp     forever    
```

How many cycles?

Ok, let's check out that first instruction.  What type of instruction?  What addressing modes is it using?

Source - immediate
Destination - register direct

Number of cycles? 2!

Second instruction.  What type of instruction?  What addressing modes is it using?

Source - immediate
Destination - register indexed

Number of cycles? 5!

Final instruction.  What type of instruction?  Does it have an addressing mode?

Number of cycles? 2!

Total cycles in the program?  9 - so this would take 9 microseconds to execute.

Any questions about this?  This is just an intro - it will mean more to you in the future when we start to talk about software delays, etc.

## More Assembly Process

On L2, I talked about assembly and machine languages - and we discussed how the assembly process works.  Let's review it quickly.

*[Assembly Language Prog -> Assembler -> Relocatable Object Code -> Linker -> Executable]*

What does the assembler do?  Converts assembly to machine code, creates relocatable object file.

It actually does a bit more for you.  See how in our code we can reference components or values by name?  Like `P1DIR`, `P1OUT`, `WDTCTL`, `WDTPW`, `WDTHOLD`, etc.  How does it do that?  Check out the `.cdecls` line in your boilerplate.  This allows you to cheat a little bit - by including pre-written C header files that have all of these values predefined.

You'll often want to use this header to reference various components on your chip.  It's automagically included in your project directory.  Let's check it out!

Another cool feature is the ability to use C-style preprocessor syntax.  Like `#WDTPW|WDTHOLD`.  That's not a pure assembly statement.  But you can use it in your assembly programs.  Cool!

What does the linker do?  Combines multiple object code files, puts them at correct place in memory, creates executable.

How does the linker know where to put your code?  It executes a linker script!  This tells it exactly where in the memory map to put each section of your code.  There is a different linker script for each script, specific to its own memory map.  It is automagically included in your project directory.  Let's check it out!

### Sections

This begs the question of what sections actually are.  They are groupings of code that you define using assembler directives!

```
.text           ;this directive tells the assembler to put the following code in the text section (ROM) - it contains executable code

.data           ;this directive tells the assembler to put the following code in the data section (RAM) - it contains variables

.sect ""        ;this should be interrupt vectors
.sect ""        ;this should be the stack
```

So we are telling the linker explicitly where to put our code in the memory map with these section directives.

## Directives

### Assemble code and data into specified sections

```
.text
.data

.byte
.word
.string
.char
.space

```

### Reserve space in memory for uninitialized variables

```

```

- Control the appearance of listings
- Initialize memory
- Assemble conditional blocks
- Define global variables
- Specify libraries from which the assembler can obtain macros
- Examine symbolic debugging information


```
.byte
.word
.cstring
```

## Structured Design and Test

*[Emphasize modular design, design standards, etc]*

We're coming up on your first assignment that will require you to design / code a solution independently.  Even though it's a small project, we have to be disciplined in our approach.

For small projects, a structured approach to designing and testing your solution seems like overkill.  It seems like a lot of additional work with very little payoff.

But the larger your project becomes, the more difficult it is to fit the entire thing in your head simultaneously.

## Lab Guidance

### Lab Notebook Expectations

[Lab Noteboook Standards](/admin/labs.html)

### Assembly Code Style Guidelines

[Coding Standards](/admin/labs.html)

## Lab 1 Introduction

The goal of this lab is to implement a simple calculator using assembly language.

[Lab 1](/labs/lab1/index.html)

**Talk about modularity / structured design and test with respect to the lab**

**Remainder of class they can get started on it.**

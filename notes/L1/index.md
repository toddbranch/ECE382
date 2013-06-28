# Lesson 1 Notes

## Readings
- [Embedded System](http://en.wikipedia.org/wiki/Embedded_system)
- [RISC vs CISC](http://www-cs-faculty.stanford.edu/~eroberts/courses/soco/projects/risc/risccisc/)

## Lesson Outline
- Course Intro
- Instructor Intro
- Admin
- Structure of a Computer
- Architecture vs Microarchitecture

## Course Intro
Welcome to ECE382, Embedded Systems I.  In this class, we'll learn about computers - how they work and how we use them to accomplish tasks.
My goal is for you to leave this course with enough excitement and knowledge to be dangerous.

What are embedded systems?  You're familiar with general-purpose computers - devices that are designed to be flexible and accomodate a wide range of needs.  Embedded systems are built to interact with the real-world and perform very specific functions, often with difficult contraints (timing, power, etc).  These are the systems that monitor the engine temperature in your car, power your digital watch, the brains of your microwave, etc.


I think that this area of computing is going to be a big part of the future.  
[Lemnos Labs / Momentum Machines](http://www.trendhunter.com/trends/machine-that-makes-burgers)

But even if you don't agree with this vision, learning about computers at a low level gives you a great insight into how these machines actually work.  You'll develop skills that will make you a better engineer, regardless of your ultimate focus.

We're going to get very hands-on and expect you to build things that actually work.  By the end of the semester, you'll program this robot to navigate this maze. 

*[DEMO - show robot navigating maze]*

## Instructor Intro

[Capt Todd Branchflower](branchflower.html) - Course Director  
[Dr. George York](york.html)  

Capt Branchflower - I have an interest in Linux and low-level systems programming.  The stuff we teach in this course is extremely relevant to that.  The knowledge you'll learn about low-level computers is the same stuff that higher-level computers operate on.

## Admin
- Show course website, walk through structure - goal is to have everything you need on here
- Go over course goals
- Go through rough block structure of course - brief overview of each
    - Stuff due every lesson
    - 2 GRs, 7 Labs, 3 Computer Exercises, HW / Quizzes
        - Must complete every Lab / CompEx!
    - There is a final - no validations
- Course policies:
    - Lab
        - After hours, sign in / out on log
        - Sign out equipment!  Work with Mr. Evans
        - Lockers
        - Lab Cleanliness
    - Lab Notebooks
        - From ECE281, you nkow the standard - grading will be less forgiving in this course
        - "Securely Affixed" - tape all around, glue
        - "Hit by a Bus" standard
    - Late Policy
    - Course Text
- Instructor policies:
    - Go over teaching schedule
    - Encouraged to bring computer to class - if you'll do useful work with it
- Skills Review!
    - Due L3?

## Structure of a Computer
Let's start with some perspective.  What are the key components of a computer?  
*[DEMO with home-built computer]*

- CPU
- Memory (RAM)
- Motherboard - encompasses lots of different stuff
- Nonvolataile storage

### System on a Chip
If you take the core components from this computer, shrink them, and integrate them on a single die, you have what's known as a [System on a Chip (SoC)](http://en.wikipedia.org/wiki/System_on_a_chip).  This is what powers your cell phones.  The Galaxy S4, for instance, has two models - one uses Qualcomm SnapDragon 600 and other Samsung Exynos 5 Octa.  They can include additional components based on application.

![Galaxy S4](GalaxyS4.png)

These SoCs have powerful CPUs and are capable of running modern software like Linux / Windows.  Typically they need external memory chips (flash, RAM) to support this software - so they're not completely single-chip. 

### Microcontrollers
When you scale this down even further (100kB of RAM or less), you reach the world of [microcontrollers](http://en.wikipedia.org/wiki/Microcontroller).  That's where we'll live this semester.  Microcontrollers typically are completely single-chip.  They're extremely low power and low cost.  But they typically come with some limitations - memory, CPU speed, onboard subsystems, etc.

## Architecture vs Microarchitecture
Now, let's see where we are in the overall hierarchy of ECE - and talk about CPUs a bit more.

![EE Hierarchy](EE_hierarchy.png)

[Instruction Set Architecture (ISA)](https://en.wikipedia.org/wiki/Instruction_set)  
The ISA is the programmer's view of the processor.  Processors with the same ISA share the same data types, assembly lanugage instructions, registers, addressing modes, memory architecture, interrupts, IO, etc.  This is the API into the processor for the programmer.

Are all processors that implement an ISA the same?  Are the Intel and AMD chips that implement x86 the same (Pentium, Athlon)?  NO - different microarchitectures.

[Microarchitecture](http://en.wikipedia.org/wiki/Microarchitecture)  
The microarchitecture is the hardware implementation of a given ISA.  An ISA can be implemented with different microarchitectures.

Does anyone know what instruction set / processor their computer is running?  
Mine runs x86_64:

![Capt Branchflower's Architecture](ISA.jpg)

Can anyone name any more instruction set architectures (ISA)?

- x86 - both 32 and 64 bit
- MIPS - taught in 281 book, will be in future course offerings
- PowerPC
- SPARC
- ARM
- 68S12 - used in this course last semester
- MSP430 - ISA we'll use in this course
- PRISM - what you learned in ECE281

Aside from maybe PRISM, these aren't toy architectures - they're used in all sorts of devices we used everyday.

In fact, the router I use at home runs MIPS and embedded Linux.  
*[DEMO SSH into router, show processor that it's running]*

### RISC vs CISC
ISAs fall into two different categories, RISC and CISC.

**TODO: add RISC vs CISC section**

In the past, we worked with the Motorola 68S12, which used a CISC architecture.  
*[Show old S12 reference book as example of volume of instructions]*

This semester, we'll be working with the MSP430.  It uses a RISC architecture.  It has a grand total of 27 instructions.

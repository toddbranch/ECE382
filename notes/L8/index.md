# Lesson 8 Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Assembly Process
- Directives
- Structured Design and Test
- Debugging
- CompEx2 Introduction

## Assembly Process

On L2, I talked about assembly and machine languages - and we discussed how the assembly process works.  Starting next lesson, you're going to be writing your own assembly language programs with little help from me - and running them on the MSP430 using this process.  Let's review it quickly and maybe add a little bit to our knowledge.



*[Discuss linking pre-compiled object files, etc]*

## Directives

The directives you've seen so far in the notes are in the GNU assembler style.  

```
.text           ;this directive tells the assembler to put the following code in the text section (ROM) - it contains executable code

.data           ;this directive tells the assembler to put the following code in the data section (RAM) - it contains variables



```

If you're using Code Composer Studio, the directives you use will be different.

```
```
## Structured Design and Test

*[Emphasize modular design, design standards, etc]*

We're coming up on your first assignment that will require you to design / code a solution independently.  Even though it's a small project, we have to be disciplined in our approach.

For small projects, a structured approach to designing and testing your solution seems like overkill.  It seems like a lot of additional work with very little payoff.

But the larger your project becomes, the more difficult it is to fit the entire thing in your head simultaneously.

## Debugging

The additional work we put in up front will pay off in the event that we make a few mistakes - and we invariably do.  

Talk about the usefulness of the debugger.

## CompEx2 Introduction

The goal of this lab is to implement a simple calculator using assembly language.

**Remainder of class they can get started on it.**

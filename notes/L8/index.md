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
- Lab notebook expectations
- Lab 1 Introduction

## Instruction Execution Time

## More Assembly Process

On L2, I talked about assembly and machine languages - and we discussed how the assembly process works.  Starting next lesson, you're going to be writing your own assembly language programs with little help from me - and running them on the MSP430 using this process.  Let's review it quickly.

*[Quick review of Assembly Language Prog -> Assembler -> Relocatable Object Code -> Linker -> Executable]*

### Sections

The directives you've seen so far in the notes are in the GNU assembler style.

```
.text           ;this directive tells the assembler to put the following code in the text section (ROM) - it contains executable code

.data           ;this directive tells the assembler to put the following code in the data section (RAM) - it contains variables
```

## Directives

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

## Lab Notebook Expectations

## Lab 1 Introduction

The goal of this lab is to implement a simple calculator using assembly language.

[Lab 1](/labs/lab1/index.html)

**Talk about modularity / structured design and test with respect to the lab**

**Remainder of class they can get started on it.**

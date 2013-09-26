# Lesson 28 Notes

## Readings
- [Family Users Guide](/datasheets) pp437 - USCI SPI Mode Block Diagram
- [Family Users Guide](/datasheets) pp355-373 - Timer_A

## Assignment

## Lesson Outline
- Review GPIO Interrupts
- Hardware Block Diagrams
- Timer_A (Interval Timing)
- Lab 5 Introduction

## Review GPIO Interrupts

## Hardware Block Diagrams

Does this look familiar?  It's your first reading from last night!

![USCI SPI Block Diagram](spi_block_diagram.jpg)

This is the (simplified) hardware representation of the SPI subsystem you configured.

Things to note:

- UCSSEL bits
    - These selected the clock the SPI master provided the slave!
    - In actuality, selects one of four inputs to a multiplexer
- 

## Timer_A (Interval Timing)

Let's take a look at the Timer_A Block Diagram and try to figure out how it works.

## Lab 5 Introduction

Let's take a look at Lab 5.

This won't be as hard as the last two labs - but you don't get as much time!  Only one in-class lesson, two out-of-class lessons.

The goal of this lab is to give you experience using interrupts.  You can't poll the buttons!  You must handle button pushes via interrupts.  You must use interrupts and Timer_A to keep track of the 2-second between-move time limit.

This lab always gives cadets problems with debouncing.  Think about this and do a good job - I won't sign off required functionality if I notice button bouncing or unresponsiveness.

A Functionality requires you to place the MSP430 in a low power mode.  We haven't talked about that yet.  You can reference the [Lesson 30 Notes](/notes/L30/) for more information or consult the [User's Guide](/datasheets/).

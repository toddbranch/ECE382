title = 'Lab 7 - A/D Conversion - "Robot Sensing"'

# Lab 7 - A/D Conversion - "Robot Sensing"

**[A Note On Robot Sharing](/labs/lab6/other_peoples_robots.html)**

## Overview

This lab is designed to assist you in learning the concepts associated with the analog-to-digital converter (ADC) for your MSP430.  A set of three infrared (IR) emitter and detector pairs on your robot is used to bring in analog voltage values for the ADC.  You will program your MSP430 to interpret these incoming voltages to determine whether your mobile robot is approaching a wall in front or on one of its sides.  The skills you will learn from this lab will come in handy in the future – especially for your senior design project since many designs require you to interface analog systems with digital systems.

## Sensor Boards

Each robot has three IR emitter/detector pairs.  By using the headers available to you on the top of the robot PCB, you can read a value between 0 V and 5 V that is proportional to the distance to an object in front of the IR sensor.  The left/right directions are relative to a person standing behind the robot.

## Required Functionality

Use the ADC subsystem to light LEDs based on the presence of a wall.  The presence of a wall next to the left sensor should light LED1 on your Launchpad board.  The presence of a wall next to the right sensor should light LED2 on your Launchpad board.  Demonstrate that the LEDs do not light until they come into close proximity with a wall.

## B Functionality

Create a standalone library for your ATD code and release it on Github.  This should be separate from your lab code.  It should have a thoughtful interface and README, capable of being reused in the robot maze laboratory.

## A Functionality

Since each robot’s sensors are a little bit different, you need to fully characterize the sensor for your robot.  Create a table and graphical plot that shows the ATD values for a variety of distances from a maze wall.  This table/graph must be generated for each IR sensor.  Use these values to determine how the IR sensors work so you can properly use them to solve the maze.

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

Test your sensors with a DMM.  Ensure they are functional.  What would good reference values be?

Consider how you'll setup the ADC10 subsystem.  What are the registers you'll need to use?  Which bits in those registers are important?  What's the initialization sequence you'll need?

Consider the hardware interface.  Which ADC10 channels will you use?  Which pins correspond to those channels?

Consider the interface you'll create to your sensors.  Will you block or use interrupts?  Will you convert one sensor at a time or multiple?

## Lab Hints

- You must provide 5V and ground to the IR sensors!
- Be mindful of loading!
  - To combat it, sample as slowly as possible
- Be sure you write a quality header/implementation file so you can easily import this code for the maze competition.
- You may want to use your moving average library to smooth the output from your sensors.

## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 10 | | BOC L37 |
| Required Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 40 | | COB L38 |
| B Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L38 |
| A Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L38 |
| Use of Git / Github | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L40 |
| Code Style | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L40 |
| README | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L40 |
| **Total** | | | **100** | | |

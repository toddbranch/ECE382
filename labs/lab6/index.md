title = 'Lab 6 - PWM - "Robot Motion"'

# Lab 6 - PWM - "Robot Motion"

## Lab Overview

This lab is designed to provide you with experience using the pulse-width modulation features of the MSP430.  You will need to program the MSP430 to generate pulse-width-modulated waveforms to control the speed / direction of your robot's motors.  In this lab, you will make your robot move forward, backwards, a small (< 45 degree) turn left/right, and a large (> 45 dgree) turn left/right.

## Driving Motors

Our mobile robots have DC motors to drive the wheels.  The amount of torque provided by the motor is directly proportional to the amount of voltage provided.  Therefore, there are two ways of varying the speed of the DC motors:

1. Provide an analog voltage where the magnitude is proportional to the output torque desired.
2. Provide a PWM signal where the duty cycle provides an "average" voltage proportional to the output torque desired.  This is shown if Figure 1.

![PWM to Motor](pwm_to_motor.png)

Figure 1: The PWM signal creates a certain duty cycle which will provide an "average" voltage to the motor.  This average voltage is proportional to the motor's output torque.

The motor can move in two directions.  If you ground one terminal of the motor and connect the PWM signal to the other side of the terminal, then the motor shaft moves in one direction.  If you swap the terminals, the motor will move in the opposite direction.

You might want to program your robot so it turns like a tank; one wheel moves forward while the other one reverses.  You will have to experiment with your robot to find out how long the PWM signal needs to be provided to turn an appropriate amount.

## Required Functionality

Demonstrate movement forward, backwards, a small (< 45 degree) turn left/right, and a large (> 45 dgree) turn left/right.  The robot should perform these movements sequentially, completely disconnected from a computer (no USB cord).

## B Functionality

Release a robot movement library on Github.  Document your interface and provide sample code using the library functions in a README.

## A Functionality

Use input capture to count PWM periods instead of `_delay_cycles()` to determine the length of your movement elements.

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

**Note that the prelab is worth 15pts on this lab - allocate your efforts accordingly!**

Consider your hardware (timer subsystems, chip pinout, etc.) and how you will use it to achieve robot control.  Which pins will output which signals you need?  Which side of the motor will you attach these signals to?  How will you use these signals to achieve forward / back / left / right movement?  Do you want to use GPIO or the PWM signals directly?  **Spend some time here, as these decisions will dictate much of how difficult this lab is for you.**

Consider how you will setup the PWM subsytem to achieve this control.  What are the registers you'll need to use?  Which bits in those registers are important?  What's the initialization sequence you'll need?

Consider what additional hardware you'll need (regulator, motor driver chip, decoupling capacitor, etc.) and how you'll configure / connect it.

Consider the interface you'll want to create to your motors.  Do you want to move each motor invidiually (`moveLeftMotorForward()`)?  Or do you want to move them together (`moveRobotForward()`)?

## Notes

### Using the MSP430 and Launchpad with the Robot

[See the writeup available in the datasheets section of the site.](/datasheets/robot.html)

### Motor Driver Chip

The robot motors require ~12V and a high amount of current – both of which would immediately burn out your microcontroller if it were directly connected to the motors.  The motor driver chip (SN754410) takes a 5V input and produces a ~12V output.  Each chip has up to four channels of 5V inputs (1A, 2A, 3A, and 4A) and four corresponding 12 V outputs (1Y, 2Y, 3Y, and 4Y).

Meausre voltage across the 12V rail to determine what is actually being supplied by your battery.

**The motor driver chip can only supply 1A per circuit!  Do not exceed that!**

You can test your 12 V PWM motor driver chip output by connecting it to the oscilloscope.  Do not use the logic analyzer for the 12 V PWM signals!

### Motor Stall Current

To ensure you never exceed 1A drawn from your motor driver chip, you have to determine the worst-case current draw from your motors.  This is called the **motor stall current** and usually occurs when your robot is pushing against an object it can't move (i.e. a wall).

To measure motor stall current, connect your robot to a power supply in series with an ammeter.  Allow the wheel to run freely and apply a voltage you expect to use.  Then, stop the wheel with your hand and monitor the current.  This is your worst-case expected current draw.  If it exceeds 1A, you can't run your motor at that voltage or risk burning your motor driver chip on motor stall.  Reduce the voltage until the stall current is below 1A to see a safe voltage you can drive your motor at.

On my robot, the stall current does not go below one amp until my motor is being driven at 8V or less - roughly 60% duty cycle.  Exceed this at your own risk!

### Decoupling Capacitors

Because the switching action of the robot motors can load the 5V rail and cause the microcontroller to reset, you need to install capacitors to ensure a stable power supply to the microcontroller.  Placing a large capacitor across the 5V rail should be able to absorb any current fluctuations and keep your robot from reseting.

## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 15 | | BOC L33 |
| Required Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 35 | | COB L35 |
| B Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L35 |
| A Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L35 |
| Use of Git / Github | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L36 |
| Code Style | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L36 |
| README | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L36 |
| **Total** | | | **100** | | |

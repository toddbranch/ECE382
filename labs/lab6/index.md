# Lab 6 - Robot Motion

## Lab Overview

This lab is designed to provide you with experience using the input capture and pulse-width modulation features of the MSP430.  You will need to program the MSP430 to generate pulse-width-modulated waveforms to control your robot’s speed.  In this lab, you will make your robot move forward, backwards, a small (< 45 degree) turn left/right, and a large (> 45 dgree) turn left/right.

## Driving Motors

Our mobile robots have DC motors to driving the wheels.  The amount of torque provided by the motor is directly proportional to the amount of voltage provided.  Therefore, there are two ways of varying the speed of the DC motors:

1. Provide an analog voltage where the magnitude is proportional to the output torque desired.
2. Provide a PWM signal where the duty cycle provides an “average” voltage proportional to the output torque desired.  This is shown if Figure 1.

Figure 1: The PWM signal creates a certain duty cycle which will provide an “average” voltage to the motor.  This average voltage is proportional to the motor’s output torque.

The motor can move in two directions.  If you ground one terminal of the motor and connect the PWM signal to the terminal side, then the motor shaft moves in one direction.  If you swap the terminals, the motor will move in the opposite direction.

As one of your pre-lab assignments, you have to create the Boolean equations that map the inputs (your PWM signal and the desired direction) to your outputs (motor terminal 1 and motor terminal 2).  This must be done for both motors – the equations will be nearly identical, only the Boolean variable subscripts will change.

## Speed Profile

In this lab, you must use a trapezoidal speed profile to control your robot.  An example of what you will demo is provided in Figure 2.  The signal has three 5-second stages: ramp-up, level, and ramp-down.  The total duration of the signal is 15 seconds.  This speed profile reduces the strain on the motor shaft that would be significantly higher if you directly output your target torque duty cycle.

Figure 2: To correctly drive the motors, your PWM signal’s duty cycle will change as a function of time.  It must “ramp up” for five seconds to the desired torque value, stay steady for as long as you want the movement to last, and then “ramp down” for five seconds.

For the oscilloscope demo with the changing PWM duty cycle, you must have the signal vary from 5% to 20% duty cycle.  You should make these parameters in your code because your robot will need different values for efficient movement.  Also, your code should allow for an arbitrarily long “steady” PWM output (rather than just the required five seconds) so you can easily reuse this code in the maze competition.

Once you demo the trapezoidal speed profile on the oscilloscope, you will be issued a robot.

## Counting Pulses

Use the input capture system to generate an interrupt for each pulse sent out by the PWM system.  At each interrupt, you need to adjust the PWM duty cycle as appropriate.  You should use a static or global variable to track how many pulses have been generated.  This will allow you to keep track of time for transitioning between the ramp-up, steady, and ramp-down stages.  You do not need to use any PWM interrupts.

## Robot Movement

All robot motion must use trapezoidal speed profiles.  You can adjust the parameters (min/max duty cycle, length of stages, etc.   but you cannot exceed 60% duty cycle!  To do so will burn out your motor driver chip.  If you need more than 60% duty cycle, each motor must have a dedicated motor driver chip.

You want to program your robot so it turns like a tank; one wheel moves forward while the other one reverses.  This means the microcontroller must provide direction signals to the motors.  You will have to experiment with your robot to find out how long the PWM signal needs to be provided to turn an appropriate amount.

## Motor Driver Chip

The motors require 12V and a high amount of current – both of which would immediately burn out your microcontroller if it were directly connected to the motors.  The motor driver chip (SN754410) takes a 5 V input and produces a 12 V output.  Each chip has up to four channels of 5 V inputs (1A, 2A, 3A, and 4A) and four corresponding 12 V outputs (1Y, 2Y, 3Y, and 4Y).

To interface with the chip, you must provide four grounds, and two 12 V power supplies.  There are two chip enable pins that are each assigned to two of the channels.  Your microcontroller will output a PWM signal and the desired direction (0/1 for forward/backward).  Using a GAL, you will convert these signals into two signals for the two motor terminals.  This GAL output is connected to the motor driver chip, which will drive the motors.

You will want to use a pin from the GAL (controlled by the microcontroller) to control the enable pins on your motor driver chip.

You can test your 12 V PWM motor driver chip output by connecting it to the oscilloscope.  Do not use the logic analyzer for the 12 V PWM signals!

## Decoupling Capacitors

Because of the switching action of the robot motors can load the 5 V rail and cause the microcontroller to reset, you need to install capacitors to ensure a stable power supply to the microcontroller.  Place a 100 μF capacitor on the 5 V rail and a 0.  μF capacitor on each output of the motor driver chip.

## Lab Hints

- Don’t forget to use decoupling capacitors.
- You may need to use larger capacitors than the ones listed here if you continue to have resetting issues.  Remember, the short capacitor terminal is ground.

- Only make minor modifications before testing your design.  The following steps are an example approach to this lab:

    - Generate constant duty-cycle PWM signal
    - Generate rising portion of speed profile
    - Add logic for the steady state portion
    - Add logic for the falling portion
    - Program the Boolean equations into the GAL and verify they work on the CADET trainer.
    - Connect GAL to the MCU and verify PWM output of GAL.
    - Connect GAL output to motor driver chip and verify 12 V PWM output on oscilloscope.
    - Connect motor driver output to motors to move them.
    - Verify motors can change direction
    - ...

## Extra Credit

Add additional features to this lab for extra credit.  Here are a few ideas, but you can come up with your own as well:

- Use switches/buttons to control whether the robot will move forward/backward/left/right.

- Use switches to control large/small turns.



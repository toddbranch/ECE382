title = 'Analog-to-Digital and Digital-to-Analog Conversion. Lab 7 / 8 Intro.'

# Lesson 36 Notes

## Readings
- [Reading 1](/path/to/reading)

## Assignment
- Lab 7 Prelab

## Lesson Outline
- Analog-to-Digital Conversion
- Digital-to-Analog Conversion
- Lab 7 / 8 Introduction

Your robot has three sets of sensors that you'll use to navigate the maze.  They're on the front, left, and right. *[Show on robot]*

Each has an IR emitter and IR sensor.  The idea is that the closer the wall gets, the more radiation from the emitter will be reflected off the wall and into the sensor.  The amount of radiation detected is proportional to the amount of voltage the sensor emits.

So voltage will increase as the wall gets closer and decrease as it gets farther away.

You get access to these readings via pins on your robot.

*[Demo with multimeter and moving toward and away from the center sensor]*

See how the voltage changes?

Another important thing to note - the reflectivity of the surface the radiation is bouncing off of matters **a lot** for how much will be picked up by the emitter

*[Demo with black box, then with white paper]*

In Lab 7, you'll have to use Analog-to-Digital conversion to take these readings into your chip.  Then, you'll have to take measurements throughout the maze so you know the distance from the wall that different voltages mean.

## Example Code First!

## Analog-to-Digital Conversion

- Generate a digital value that represents the input voltage "level"
- Levels usually range from (0 to 2^b) or (-2^(b-1) to 2^(b-1)-1)
- *Clipping* - above / below Vrh / Vrl voltages

**Example here**

### ATD Technologies

## Digital-to-Analog Conversion

## Lab 7 / 8 Introduction

# Lesson 27 Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Interrupts
- Interrupt Service Routines (ISRs)

## Interrupts

![MSP430G2553 Interrupt Vectors](MSP430G2553_interrupts.jpg)

## Interrupt Service Routines (ISRs)

```
#pragma vector=XXXXX_VECTOR
__interrupt void XXXXX_ISR(void)
{
    // do some stuff
}
```

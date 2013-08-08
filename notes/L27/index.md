# Lesson 27 Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Interrupts
- Interrupt Service Routines (ISRs)

## Interrupts

In L15 and on Lab 3, we used **polling** as our method to query the state of our device.  What's the problem with that?

**It's inefficient!**  In the time we spent polling the state of our device, the CPU could be freed to do more useful work.  It could also be put in a low-power mode until activity on our device wakes it back up.

Polling is like me spending the entire class period asking if each student in class has a question.

The alternative to polling is **interrupts**.  It's closer to you raising your hand when you have a question.  I'm freed to do other things until you interrupt me, at which time I can handle your question before picking up where I left off.

Interrupts signal an event that requires an immediate response.  When an interrupt is requested (typically by hardware, but can be triggered in software), the processor stops what it's doing, stores enough information so it an restore its current state, and handles the interrupt.  When it's finished handling the interrupt.  It then executes some predefined piece of code called an **Interrupt Service Routine**.  Once it's finished, the CPU restores its previous state and moves on.

Interrupts serve two main purposes:

- To execute some predefined subroutine based on an event
- To wake up the MSP430 from a low-power mode

### Interrupt Vectors

### MSP430 Interrupts

![MSP430G2553 Interrupt Vectors](MSP430G2553_interrupts.jpg)

Talk about interrupt priority.

### Non-maskable Interrupts

### Maskable Interrupts

Talk about GIE bit in status register.

## Interrupt Service Routines (ISRs)

```
#pragma vector=XXXXX_VECTOR
__interrupt void XXXXX_ISR(void)
{
    // do some stuff
}
```


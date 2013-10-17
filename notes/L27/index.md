# Lesson 27 Notes

## Readings
- [Interrupts](http://en.wikipedia.org/wiki/Interrupt)
- [Interrupt Handler](http://en.wikipedia.org/wiki/Interrupt_handler)

## Assignment

## Lesson Outline
- Interrupts
- Interrupt Service Routines (ISRs)
- MSP430 Interrupts

## Interrupts

In L15 and on Lab 3, we used **polling** as our method to query the state of our device.

What's the problem with that?

**It's inefficient!**  In the time we spent polling the state of our device, the CPU could be freed to do more useful work.  It could also be put in a low-power mode until activity on our device wakes it back up - critical in devices that must conserve power.

Polling is like me spending the entire class period asking if each student in class has a question.

What's the alternative?

**Interrupts**.  Interrupts are closer to you raising your hand when you have a question.  I'm freed to do other things until you interrupt me, at which time I can handle your question before picking up where I left off.

Interrupts signal an event that requires an immediate response.  Some examples:

- Your network interface received a data packet that must be processed before the next arrives
- A hardware timer has overflowed, indicating your device must awake from sleep and perform a task

When an interrupt is requested (typically by hardware, but can be triggered in software), the processor stops what it's doing, stores enough information so it an restore its current state, and handles the interrupt.  It then executes some predefined piece of code called an **Interrupt Service Routine (ISR)**.  Once it's finished, the CPU restores its previous state and continues what it was previously doing.  ISRs are like subroutines called at unpredictable (to the CPU, at least) times.

Interrupts serve two main purposes:

- To execute some predefined subroutine based on an event
- To wake up the MSP430 from a low-power mode

### What Happens On Reset

What happens when you push the Reset button on your chip?

It triggers an interrupt!

The CPU notices that the Reset interrupt has occurred.  In response to the interrupt, the CPU consults its Interrupt Vector Table.  This is the table that holds the addresses of the ISR to be executed as a result of each interrupt.  It finds the vector that corresponds to the pending interrupt and executes the code there.

Remember this code that automatically was generated in your assembly projects?

```
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;
;           YOUR CODE
;

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
```

This is storing the RESET label (the address of the start of your code) as the vector for reset interrupt!  It tells the MSP430 to start executing your code whenever that interrupt is triggered.

### Interrupt Vectors

But there are a whole bunch more interrupt vectors we have access to!  Back to our trust memory map!

![MSP430 Memory Map](/notes/L2/memory_map.jpg)

At the highest addresses, there is a block reserved for the Interrupt Vector Table.

Here's some more detail on that block for the MSP430G2553:  
![MSP430G2553 Interrupt Vectors](MSP430G2553_interrupts.jpg)

- GPIO
- Analog-to-Digital Conversion
- Communications Interfaces (USCI)
- Timers

So when a given interrupt is triggered, the CPU knows to go to its associated vector to find the address of the subroutine to be executed in response.

## Interrupt Service Routines (ISRs)

```
#pragma vector=XXXXX_VECTOR
__interrupt void XXXXX_ISR(void)
{
    // do some stuff
}
```

## MSP430 Interrupts 

Talk about interrupt priority.

### Non-maskable Interrupts

### Maskable Interrupts

Talk about GIE bit in status register.


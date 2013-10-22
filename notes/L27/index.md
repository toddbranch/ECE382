# Lesson 27 Notes

## Readings
- [Interrupts](http://en.wikipedia.org/wiki/Interrupt)
- [Interrupt Handler](http://en.wikipedia.org/wiki/Interrupt_handler)

## Assignment

## Lesson Outline
- Interrupts
- Interrupt Service Routines (ISRs)
- MSP430 Interrupts
- Somes Examples

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

When an interrupt is requested (typically by hardware, but can be triggered in software), the processor stops what it's doing, stores enough information so it can restore its current state, and handles the interrupt.  It then executes some predefined piece of code called an **Interrupt Service Routine (ISR)** designed to respond to the event.  Once it's finished, the CPU restores its previous state and continues what it was previously doing.  ISRs are like subroutines called at unpredictable (to the CPU, at least) times.

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

This is storing the RESET label (the address of the start of your code) as the vector for the reset interrupt!  It tells the MSP430 to execute your code whenever that interrupt is triggered.

### Interrupt Vectors

There are a whole bunch more interrupt vectors we have access to!  Back to our memory map:

![MSP430 Memory Map](/notes/L2/memory_map.jpg)

At the highest addresses, there is a block reserved for the Interrupt Vector Table.

Here's some more detail on that block for the MSP430G2553:

![MSP430G2553 Interrupt Vectors](MSP430G2553_interrupts.jpg)

Interrupts we can respond to:
- GPIO
- Analog-to-Digital Conversion
- Communications Interfaces (USCI)
- Timers

So when a given interrupt is triggered, the CPU knows to go to the associated vector to find the address of the ISR to be executed in response.

## Interrupt Service Routines (ISRs)

So what does an ISR look like?

```
#pragma vector=XXXXX_VECTOR
__interrupt void XXXXX_ISR(void)
{
    // do some stuff
}
```

```
#pragma vector=PORT1_VECTOR
__interrupt void Port_1(void)
{
  P1OUT ^= BIT0;                            // P1.0 = toggle
  P1IFG &= ~BIT3;                           // P1.3 IFG cleared
}

```

## MSP430 Interrupts 

Talk about interrupt priority.

### Non-maskable Interrupts

### Maskable Interrupts

Talk about GIE bit in status register.

## Some Examples

### Interrupt-Driven LEDs Controlled by Push Button

I want to write some code that will toggle the LEDs each time I push the Launchpad's pushbutton.  I want to use the PORT1 interrupt to sense the button push and toggle the LEDs within the PORT1 ISR.

```
int main(void)
{
    WDTCTL = WDTPW|WDTHOLD;                 // stop the watchdog timer

    P1DIR |= BIT0|BIT6;                     // set LEDs to output

    P1IE |= BIT3;                           // enable the interrupt for P1.3
    P1IES |= BIT3;                          // configure interrupt to sense falling edges

    P1REN |= BIT3;                          // enable internal pull-up/pull-down network
    P1OUT |= BIT3;                          // configure as pull-up

    P1IFG &= ~BIT3;                         // clear P1.3 interrupt flag

    return 0;
}

interrupt(PORT1_VECTOR) PORT1_ISR()
{
    P1OUT ^= BIT0|BIT6;                     // toggle LEDs
    P1IFG &= ~BIT3;                         // clear P1.3 interrupt flag
}
```

### A Use Case for Global Variables

How can I communicate information from my ISR back to my main program loop?  The only way is through global variables - this is the only use-case where I'll encourage the use of globals.

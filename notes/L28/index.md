# Lesson 28 Notes

## Readings
- [Family Users Guide](/datasheets) pp355-373 - Timer_A

## Assignment
- Lab 5 Prelab

## Lesson Outline
- Review GPIO Interrupts
- Hardware Block Diagrams
- Timer_A (Interval Timing)
- Lab 5 Introduction

## Review GPIO Interrupts

## Hardware Block Diagrams

Remember this block diagram?  This is the implementation of the SPI subsystem within your chip.

![USCI SPI Block Diagram](spi_block_diagram.jpg)


Things to note:

- UCSSEL bits
    - These selected the clock the SPI master provided the slave!
    - In actuality, selects one of four inputs to a multiplexer
- 

## Timer_A


### Block Diagram

Let's take a look at the Timer_A Block Diagram and try to figure out how it works.

![Timer A Block Diagram](timerA_block_diagram.jpg)

Note MUXs, AND gates, OR gates, flip flops.

### Interval Timing

### Example - Flash LEDs

```
char flag = 0;

int main(void)
{
    WDTCTL = WDTPW|WDTHOLD;                 // stop the watchdog timer

    P1DIR |= BIT0|BIT6;

    // configure TIMER0_A0
    // clr TAR to reset state
    // stops timer - MCx = 00
    TACTL |= TACLR;

    TACTL |= TASSEL1;           // configure for SMCLK

    TACTL |= ID1|ID0;

    TACTL &= ~TAIFG;            // clear interrupt flag

    TACTL |= TAIE;              // enable interrupt

    TACTL |= MC1;

    // enable timer - MCx = 10 - Continuous mode
    
    __enable_interrupt();

    int count = 0;

    while(1)
    {
        // do other useful stuff

        // respond to interrupt if it occurred
        if (flag)
        {
            flag = 0;
            P1OUT ^= BIT0;
            if (count)
            {
                P1OUT ^= BIT6;
                count = 0;
            } else
                count++;
        }
    }

    return 0;
}

// Flag for continuous counting is TAIFG
interrupt(TIMER0_A1_VECTOR) TIMER0_A1_ISR()
{
    TACTL &= ~TAIFG;            // clear interrupt flag
    flag = 1;
}
```

## Lab 5 Introduction

**TODO: Update writeup based on lab changes**

Let's take a look at Lab 5.

This won't be as hard as the last two labs - but you don't get as much time!  Only one in-class lesson, two out-of-class lessons.

The goal of this lab is to give you experience using interrupts.  You can't poll the buttons!  You must handle button pushes via interrupts.  You must use interrupts and Timer_A to keep track of the 2-second between-move time limit.

This lab always gives cadets problems with debouncing.  Think about this and do a good job - I won't sign off required functionality if I notice button bouncing or unresponsiveness.

A Functionality requires you to place the MSP430 in a low power mode.  We haven't talked about that yet.  You can reference the [Lesson 30 Notes](/notes/L30/) for more information or consult the [User's Guide](/datasheets/).

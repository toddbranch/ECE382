#include <msp430g2553.h>
#include <legacymsp430.h>

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

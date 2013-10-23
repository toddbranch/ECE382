#include <msp430g2553.h>
#include <legacymsp430.h>

int main(void)
{
    WDTCTL = WDTPW|WDTHOLD;                 // stop the watchdog timer

    P1DIR |= BIT0|BIT6;                     // set LEDs to output

    P1IE |= BIT3;                           // enable the interrupt for P1.3
    P1IES |= BIT3;                          // configure interrupt to sense falling edges

    P1REN |= BIT3;                          // enable internal pull-up/pull-down network
    P1OUT |= BIT3;                          // configure as pull-up

    P1IFG &= ~BIT3;                         // clear P1.3 interrupt flag

    __enable_interrupt();

    return 0;
}

interrupt(PORT1_VECTOR) PORT1_ISR()
{
    P1IFG &= ~BIT3;                         // clear P1.3 interrupt flag
    P1OUT ^= BIT0|BIT6;                     // toggle LEDs
}

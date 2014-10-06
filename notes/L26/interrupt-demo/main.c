#include <msp430g2553.h>
#include <legacymsp430.h>

int main(void)
{
    WDTCTL = WDTPW|WDTHOLD;                 // stop the watchdog timer

    P1DIR |= BIT0|BIT6;                     // set LEDs to output
    P1DIR &= ~(BIT1|BIT2|BIT3);				// set buttons to input

    P1IE |= BIT1|BIT2|BIT3; 				// enable the interrupt for P1.3
    P1IES |= BIT1|BIT2|BIT3;               	// configure interrupt to sense falling edges

    P1REN |= BIT1|BIT2|BIT3;               	// enable internal pull-up/pull-down network
    P1OUT |= BIT1|BIT2|BIT3;               	// configure as pull-up

    P1IFG &= ~(BIT1|BIT2|BIT3);            	// clear P1.3 interrupt flag

    __enable_interrupt();

	while (1) {}

    return 0;
}

interrupt(PORT1_VECTOR) PORT1_ISR()
{
	if (P1IFG & BIT1)
	{
		P1IFG &= ~BIT1;							// clear flag
		P1OUT ^= BIT6;							// toggle LED 2
	}

	if (P1IFG & BIT2)
	{
		P1IFG &= ~BIT2;                         // clear flag
		P1OUT ^= BIT0;							// toggle LED 1
	}

	if (P1IFG & BIT3)
	{
		P1IFG &= ~BIT3;                         // clear P1.3 interrupt flag
		P1OUT ^= BIT0|BIT6;                     // toggle both LEDs
	}
}

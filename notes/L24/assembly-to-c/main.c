#include <msp430g2553.h>

#define TRUE 1

void main(void)
{
    P1DIR |= BIT0|BIT6;
    P1DIR &= ~BIT3;
    P1REN |= BIT3;
    P1OUT |= BIT3;

    while (TRUE)
    {
        if (P1IN & BIT3)
            P1OUT &= ~(BIT0|BIT6);
        else
            P1OUT |= BIT0|BIT6;
    }
}

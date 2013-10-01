#include <msp430.h>

int main(void)
{
    char readRxBuf;

    WDTCTL = (WDTPW|WDTHOLD);

    UCA0CTL1 |= UCSWRST;

    UCA0CTL0 |= (UCCKPH|UCCKPL|UCMSB|UCMST|UCSYNC);

    UCA0CTL1 |= (UCSSEL1);

    P1SEL |= (BIT1|BIT2|BIT4);
    P1SEL2 |= (BIT1|BIT2|BIT4);

    UCA0CTL1 &= ~UCSWRST;

    while (1) {
        UCA0TXBUF = 0xA7;

        while (!(UCA0RXIFG & IFG2)) {}

        readRxBuf = UCA0RXBUF;
    }

    return 0;
}

#include <msp430g2553.h>
#include <legacymsp430.h>

int main(void)
{
    WDTCTL = WDTPW|WDTHOLD;                 // stop the watchdog timer

	P1DIR |= BIT2;
	P1SEL |= BIT2;

	TACTL &= ~MC1|MC0;			// stop timer

    TACTL |= TACLR;

    TACTL |= TASSEL1;           // configure for SMCLK

	TACCR0 = 100;
	TACCR1 = 25;

	TACCTL1 |= OUTMOD_7;

    TACTL |= MC0;				// count up

	while (1) {
		__delay_cycles(1000000);
		TACCR1 = 50;
		__delay_cycles(1000000);
		TACCR1 = 75;
		__delay_cycles(1000000);
		TACCR1 = 100;
		__delay_cycles(1000000);
		TACCR1 = 25;
	}

    return 0;
}

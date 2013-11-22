#include <msp430g2553.h>
// if you need interrupts
#include <legacymsp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT
  ADC10CTL0 = ADC10SHT_3 + ADC10ON + ADC10IE; // ADC10ON, interrupt enabled
  ADC10CTL1 = INCH_4;                       // input A1
  ADC10AE0 |= BIT4;
	ADC10CTL1 |= ADC10SSEL1|ADC10SSEL0;				// Select SMCLK
  ADC10CTL1 |= ADC10DIV2|ADC10DIV1|ADC10DIV0;
  P1DIR |= 0x01;                            // Set P1.0 to output direction

  for (;;)
  {
    ADC10CTL0 |= ENC + ADC10SC;             // Sampling and conversion start
    __bis_SR_register(CPUOFF + GIE);        // LPM0, ADC10_ISR will force exit
    if (ADC10MEM < 0x1FF)
      P1OUT &= ~0x01;                       // Clear P1.0 LED off
    else
      P1OUT |= 0x01;                        // Set P1.0 LED on
  }

	return 0;
}

// ADC10 interrupt service routine
// #pragma vector=ADC10_VECTOR
// __interrupt void ADC10_ISR(void)
interrupt(ADC10_VECTOR) ADC_ISR()
{
  __bic_SR_register_on_exit(CPUOFF);        // Clear CPUOFF bit from 0(SR)
}

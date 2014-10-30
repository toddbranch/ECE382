//-----------------------------------------------------------------
// Name:	Coulston
// File:	test5.c
// Date:	Fall 2014
// Purp:	Measure IR pulses
//-----------------------------------------------------------------
#include <msp430g2553.h>

typedef		unsigned char		int8;
typedef		unsigned short		int16;

#define SAMPLE_SIZE			48
#define	IR_DECODER_PIN		(P2IN & BIT6)
void initMSP430();

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
void main(void) {

	int16 time1[SAMPLE_SIZE], time0[SAMPLE_SIZE];
	int8  i;

	initMSP430();				// Setup MSP to process IR and buttons


    while (1)  {

		while(IR_DECODER_PIN != 0);			// IR input is nominally logic 1

		for(i=0; i<SAMPLE_SIZE; i++) {

			TAR = 0;						// reset timer and
			while(IR_DECODER_PIN==0);		// wait while IR is logic 0
			time0[i] = TAR;					// and store timer A

			TAR = 0;						// reset timer and
			while(IR_DECODER_PIN != 0);		// wait while IR is logic 1
			time1[i] = TAR;					// and store timer A

		} // end for
    } // end while
} // end main


// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
void initMSP430() {

	IFG1=0; 					// clear interrupt flag1
	WDTCTL=WDTPW+WDTHOLD; 		// stop WD

	BCSCTL1 = CALBC1_8MHZ;
	DCOCTL = CALDCO_8MHZ;

	TAR = 0x0000;						// time measurements are based at time 0
	TA0CCR0 = 0xFFFF;					// create a 16mS roll-over period
	TACTL &= ~TAIFG;					// clear flag before enabling interrupts = good practice
	TACTL = ID_3 | TASSEL_2 | MC_1;		// Use 1:1 presclar off MCLK and enable interrupts

	P2SEL  &= ~BIT6;						// Setup P2.6 as GPIO not XIN
	P2SEL2 &= ~BIT6;
	P2DIR &= ~BIT6;

} // end initMSP430
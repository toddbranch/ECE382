```
/*******************************************
 * Author: 
 * Created: 9 Oct 2013
 * Description: Assignment 5 basic C functionality
 *******************************************/
#include <msp430.h> 
#define THRESH_HOLD 0x38

/*
 * main.c
 */
int main(void) {
	WDTCTL = WDTPW | WDTHOLD;	// Stop watchdog timer

	char val1, val2, val3; //Declare 3 values
	val1 = 0x40;
	val2 = 0x35;
	val3 = 0x42;

	char result1, result2, result3; //set a place for the results
	result1 = 0;
	result2 = 0;
	result3 = 0;

	char a = 0; //fibonacci helper variables
	char b = 1;
	char c;

	int i; //loop index

	if (THRESH_HOLD - val1 < 0) {
		for (i = 1; i < 9; i++) { //loops for fibonacci
			c = a + b;
			a = b;
			b = c;
			result1 = a + b;
		}
	} else {
		result1 = 0;
	}

	if (THRESH_HOLD - val2 < 0) {
		result2 = 0xAF;
	} else {
		result2 = 0;
	}

	if (THRESH_HOLD - val3 < 0) {
		result3 = val2 - 0x10;
	} else {
		result3 = 0;
	}


	while (1) {

	}
	return 0;
}
```

```
/*******************************************
  * Author: 
  * Created: 9 Oct 2013
  * Description: This program assigns a char value to three different variables
  * and compares those variables to a constant value. If the variable is greater
  * than the constant value than it will assign a value to its corresponding result
  * that is originally initialized to zero. These values include the tenth value in
  * the Fibonacci sequence, 0xAF, and val2 - 0x10. The program concludes by trapping
  * itself within a while loop.
  * Documentation: I acknowledge that I received help from c2c Scout Wallace on figuring
  * out how to do the Fibonacci sequence in the for loop and discussing where the
  * variables are stored.
*******************************************/


#include <msp430.h> 

#define THRESHOLD 0x38  //constant value


void main(void) {
     WDTCTL = WDTPW | WDTHOLD;	// Stop watchdog timer
	 volatile unsigned char val1, val2, val3;
	 val1 = 0x40;
	 val2 = 0x35;
	 val3 = 0x42;
	
	 volatile unsigned char result1, result2, result3;
	 result1 = 0x0;
	 result2 = 0x0;
	 result3 = 0x0;

	if (val1 > THRESHOLD) {
		int i;
		volatile unsigned char a,b;
		a = 0x0;
		b = 0x1;
		for(i = 1; i < 10; i++) {   //for loop to compute the Fibonacci sequence
			result1 = a + b;
	        a = b;
	        b= result1;
		}
	}

	if(val2 > THRESHOLD)
	{
    	result2 = 0xAF;
    }

	if(val3 > THRESHOLD)
    {
    	result3 = val2 - 0x10;
    }


    while(1) {}   // traps the CPU
}
```

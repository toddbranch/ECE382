```
#include <msp430.h> 
#define threshold 0x38
/*
* Author: 
* Created: 8 Oct 2013
* Description: A Simple C Program
*/
int main(void) {
    WDTCTL = WDTPW | WDTHOLD;           // Stop watchdog timer
                unsigned char val1 = 0x40;
                unsigned char val2 = 0x35;
                unsigned char val3 = 0x42;
                unsigned char result1 = 0;
                unsigned char result2 = 0;
                unsigned char result3 = 0;
                unsigned char var1 = 0;
                unsigned char var2 = 1;
                unsigned char var3 = 0;
                int i;
                if (val1 > threshold){
                                for (i = 0; i < 9; i++){
                                                var3 = var1 + var2;
                                                var1 = var2;
                                                var2= var3;
                                }
                                result1 = var3;
                }
                if (val2 > threshold){
                                result2 = 0xAF;  //doesn't output because less than
                }
                if (val3 > threshold){
                                result3 = val2 - 0x10;
                }


                while(1){}

}
```

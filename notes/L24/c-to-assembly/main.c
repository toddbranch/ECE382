#include <msp430g2553.h>

int recursiveSummation(int numberToSum);

void main(void)
{
    int numberToSum = 10;

    numberToSum = recursiveSummation(numberToSum);
}

int recursiveSummation(int numberToSum)
{
    if (numberToSum <= 0)
        return 0;
    else 
        return numberToSum + recursiveSummation(numberToSum - 1);
}

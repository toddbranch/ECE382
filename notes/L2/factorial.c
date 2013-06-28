#include <msp430.h>

int factorial(int number)
{
    if ((number == 0) || (number == 1))
        return 1;
    else
        return number * factorial(number - 1);
}

int main(void)
{
    int emptyArray[20];
    emptyArray[0] = factorial(5);
    emptyArray[19] = factorial(9);
    return 0;
}

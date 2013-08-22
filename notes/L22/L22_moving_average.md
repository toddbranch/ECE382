# L22 Assignment - Moving Average

## Moving Average

- Write a function that computes the "moving average" for a stream of data points it is receiving.
    - A moving average computes the average of the last `N_AVG_SAMPLES` (a constant in your header file) points.
    - Initialize values in the "average" array to be 0.
    - For example: (`N_AVG_SAMPLES` = 2), sample stream = (2, 4, 6, 8).
        - First sample moving average: 1
        - Second sample moving average: 3
        - Third sample moving average: 5
        - Fourth sample moving average: 7
    - Use the following data streams to test your moving average function:
        - Test these streams with (`N_AVG_SAMPLES` = 2) and (`N_AVG_SAMPLES` = 4).
        - (45, 42, 41, 40, 43, 45, 46, 47, 49, 45)
        - (174, 162, 149, 85, 130, 149, 153, 164, 169, 173)
        - Note; you should store the "moving average" values into an array to make your simulation and verification stages simpler.
- Write two other functions that compute the maximum and minimum values in a given array.  You can "terminate" (last element is some predefined constant to simplify your loop) or pass in the length of the array as a parameter.
- Write another function that computes the range of values in an array.
- You *may* use the following function to generate a new pseudo random number each time it is called.  You can use this as your input stream to test your other functions.  This is based on the method described in "The C Programming Language" by Kernighan and Ritchie.
```
unsigned long int rand(void)
{
    static unsigned long int random_seed = INITIAL_RANDOM_SEED;
    random_seed = random_seed * 1103515245 + 12345;
    return (unsigned long int)(random_seed / 65536) % 32768;
}
```

## Turn-In Requirements (E-mail)

- Source code files (`main.c`, header, and implementation).
- Simulator screenshots.
- Answers to the following questions:
    - What data type did you choose for your arrays?  Why?
    - How did you test each of your functions to verify they were functioning correctly?

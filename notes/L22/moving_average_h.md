```
/*
 * moving_average.h
 * Author: Todd Branchflower
 * Date: 11 Oct 2013
 * Description: Functions to update and monitor a moving average
 */

#ifndef _MOV_AVG_H
#define _MOV_AVG_H

// Moving average functions
int getAverage(int array[], unsigned int arrayLength);
void addSample(int sample, int array[], unsigned int arrayLength);

// Array functions
int max(int array[], unsigned int arrayLength);
int min(int array[], unsigned int arrayLength);
unsigned int range(int array[], unsigned int arrayLength);

#endif
```

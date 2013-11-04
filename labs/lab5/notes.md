# Lab 5 Notes

From now on, I'm not going to look at your lab notebooks aside from prelabs.  I'm only going to assess use of git / github, code style, and the quality of your READMEs.  A good example README is my button library: https://github.com/toddbranch/buttons .

I've given you a lot of skeleton code - you're not required to use it, but you can if you want to.

There are libraries available for buttons / LCD / random number generation on Github - use them!  It will save you time and effort!  Clone them and `#include` them, don't copy / paste code!

I've forked the random number library and modified it to work better with CCS - use my forked version.

I've given you code that will help with using interrupts to drive buttons under B functionality.

The size of your ISRs is a design decision.  Typically, we want to keep them short so we don't miss other interrupts - but this is a guideline, not a rule.  If it makes sense in your application to do more work in ISRs, that's your prerogative.

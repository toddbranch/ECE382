# Lesson 10 Notes

## Readings
[Reading 1](/path/to/reading)
[Stacks](http://en.wikipedia.org/wiki/Stack_(abstract_data_type/))

## Assignment
[Subroutines]()

## Lesson Outline
- The Stack
- Subroutines
- CompEx 3 Introduction

## The Stack

There's one special function register that I've alluded to a couple of times, but we haven't covered yet - the Stack Pointer (SP), r1.  The SP holds the address of the top of the stack.  To figure out what that means, we've got to learn a little more about what stacks are.

A stack is a Last In First Out (LIFO) queue.  The last item you **pushed** onto the stack is the first item you'll **pop** off of it.

*[Draw picture of a stack, add a few items, then show how they're popped off]*

As you push more items onto the stack, the more space in memory it occupies - it grows.  As you pop items off of the stack, it shrinks.  The core purpose of stacks is to allow for the temporary storage of values at runtime for later retrieval.

In the MSP430, the stack grows upward - from higher locations in memory to lower locations in memory.  The SP is typically initialized to 0x400 because that is the address following the end of RAM.

Consider the following example:
```
mov.w       #0x0400, r1         ;initialize stack pointer

push.w      #0xdfec             ;push the value 0xdfec onto the stack. this increments the SP by two to 0x03fe and stores EC at 0x03fe and DF at 0x03ff - as we'd expect with a little-endian system
pop.w       r10                 ;pop the value we just pushed off of the stack and into r10 - this decrements the SP by two, back to 0x0400.
```

*[Run through in debugger]*

**What would happen if we didn't initialize the stack program at the start of our program?**

## Subroutines

The stack is crucial in allowing us to implement the programming construct of subroutines.

**What would happen if we didn't initialize the stack program at the start of our program?**

## CompEx 3 Introduction



# Lesson 10 Notes

## Readings
[Reading 1](/path/to/reading)
[Stacks](http://en.wikipedia.org/wiki/Stack_(abstract_data_type/))

## Assignment
[Subroutines]()

## Lesson Outline
- The Stack
- Subroutines
- Lab 2 Introduction

## The Stack

There's one special function register that I've alluded to a couple of times, but we haven't covered yet - the Stack Pointer (SP), r1.  The SP holds the address of the top of the stack.  To figure out what that means, we've got to learn a little more about what stacks are.

A stack is a Last In First Out (LIFO) queue.  The last item you **pushed** onto the stack is the first item you'll **pop** off of it.

*[Draw picture of a stack, add a few items, then show how they're popped off]*

As you push more items onto the stack, the more space in memory it occupies - it grows.  As you pop items off of the stack, it shrinks.  The core purpose of stacks is to allow for the temporary storage of values at runtime for later retrieval.

In the MSP430, the stack grows upward - from higher locations in memory to lower locations in memory.  The SP is typically initialized to 0x400 because that is the address following the end of RAM.

Here are the relevant instructions:

| Opcode | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 100 | PUSH(.B) |  Push operand on stack. Push byte decrements SP by 2. Most significant byte not overwritten.  CPU BUG: PUSH #4 and PUSH #8 do not work when the short encoding using @r2 and @r2+ is used. The workaround, to use a 16-bit immediate, is trivial, so TI do not plan to fix this bug. |

| Emulated Instruction | Assembly Instruction | Notes |
| :---: | :---: | :---: |
| POP dst | MOV @SP+, dst | |

Consider the following example:
```
mov.w       #0x0400, r1         ;initialize stack pointer

push.w      #0xdfec             ;push the value 0xdfec onto the stack. this decrements the SP by two to 0x03fe and stores EC at 0x03fe and DF at 0x03ff - as we'd expect with a little-endian system
pop.w       r10                 ;pop the value we just pushed off of the stack and into r10 - this decrements the SP by two, back to 0x0400.
```

*[Run through in debugger]*

Let's consider how I might use the stack if I wanted to swap the values in two registers:
```
push.w      r10
mov.w       r11, r10
pop.w       r11
```

Pretty simple, right?

**What would happen if we didn't initialize the stack program at the start of our program?**

We'd have no way of knowing where the SP is.  There's a good chance it could be in ROM - in that case, we can't write that memory at runtime, so we'd have no way of retrieving variables stored there.  It could be in unimplemented memory - in which case an access would trigger a Power-Up Clear (PUC) and reset our chip.  It could be in our peripherals, in which case writing could have all sorts of unpredictable results.

Let's say we remember to initialize the stack.  **What would happen if we pushed too many variable onto it?**

We could find ourselves overwriting a section of RAM that we're storing program variables in.  We could also totally go through our RAM and into our peripherals.

## Subroutines

The stack is crucial in allowing us to implement the programming construct of subroutines.  Subroutines allow us to modularize our code - create self-contained blocks of code that perform a specific function.  We can **call** these subroutines, allow them to perform their function, and then **return** to our main program.  This makes our code easier to read and also allows us to reuse certain subroutines in future programs.  It's never bad to save a little work!

Here are the MSP430 instructions that relate to subroutines:

| Opcode | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 101 | CALL |  Fetch operand, push PC, then assign operand value to PC. Note the immediate form is the most commonly used. There is no easy way to perform a PC-relative call; the PC-relative addressing mode fetches a word and uses it as an absolute address. This has no byte form. |

**Important:** You should call all subroutines using the immediate addressing mode - there's no easy way to do it PC-relative.  A call should be of the form `call  #mySubroutine`.

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| RET | MOV @SP+, PC |

**What would happen if we didn't initialize the stack program at the start of our program and tried to call a subroutine?**

### Our First Subroutine

```
main:
    mov.w   #2, r10
    mow.w   #4, r11
    call    #addition

addition:
    add.w   r10, r11 
    ret
```

*[Run through this in the debugger, monitor stack]*

### Arguments

Often, subroutines require data in order to perform their functions.  This data is passed in via registers.  These pieces of data are called the **arguments** to a subroutine.

A subroutine must specify which registers it expects arguments to passed in and which it expects arguments to be passed out.  It should also say which registers it destroys across subroutine calls so the programmer is aware.  It should say that in a comment header above the subroutine.  Here's a header for our addition subroutine:
```
;---------------------------------------------------
;Subroutine Name: Addition
;Author: Capt Todd Branchflower, USAF
;Function: Adds two numbers, returns the result
;Inputs: operand1 in r10, operand2 in r11
;Outputs: result in r11
;Registers destroyed: r11
;---------------------------------------------------

addition:
    add.w   r10, r11 
    ret
```

If your subroutine needs to use registers, but the programmer needs them to be preserved between function calls, the stack is a good way to handle that.  Note, popping registers will overwrite their contents - make sure you aren't trying to pass a result back in a register you're trying to preserve.  Also, note that you must pop registers in the opposite order you pushed them.

```
mySubroutine:
    push.w  r5
    push.w  r6
    push.w  r7

    pop.w   r7
    pop.w   r6
    pop.w   r5
    ret
```

### Pass-by-Value

There are two methods of passing arguments to a subroutine - the first is pass-by-value, whereby we pass the actual values of the arguments to a subroutine.  That's what we used in the addition example.  The actual values we wanted to add were passed in the relevant registers.

### Pass-by-Reference

The second method is pass-by-reference - whereby we pass a reference to the data (it's address) to the subroutine.  This is useful when we want to when we're taking arguments for memory or want to modify some memory within the subroutine.

Let's modify our addition subroutine to take arguments in memory locations.

```
;---------------------------------------------------
;Subroutine Name: Addition
;Authoer: Capt Todd Branchflower, USAF
;Function: Adds two numbers, returns the result
;Inputs: address of operand1 in r10, address of operand2 in r11
;Outputs; result in r11
;Registers destroyed: r11
;---------------------------------------------------

addition:
    push.w  r12
    mov.w   @r11, r12
    add.w   @r10, r12 
    mov.w   r12, r11
    pop     r12
    ret
```

I had to do a bit of work to preserve r12.  It would have been easier to just pass the result out in r12, but I want to be true to the subroutine header.

### Application Binary Interface (ABI)

Even modern operating systems must obey the convention of specifying which registers are used for arguments passed in to a subroutine and which are used to pass back results.  This convention is known as the Application Binary Interface (ABI).

## Lab 2 Introduction



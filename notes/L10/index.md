title = 'The Stack. Subroutines. Lab 2 Introduction.'

# Lesson 10 Notes

## Readings
- <a href="http://en.wikipedia.org/wiki/Stack_(abstract_data_type)">Stacks</a>  
- [Stack Overflow](http://en.wikipedia.org/wiki/Stack_overflow)

## Lesson Outline
- Admin
- The Stack
- Subroutines
- Lab 2 Introduction

## Admin

- Demo your Lab 1 functionality by COB today!  
- Be prepared to walk me through the program you've written to test your own lab.
- Any quick questions?


## The Stack

There's one special function register that I've alluded to a couple of times, but we haven't covered yet - the Stack Pointer (SP), r1.  The SP holds the address of the top of the stack.  To figure out what that means, we've got to learn a little more about what stacks are.

A stack is a Last In First Out (LIFO) queue.  Push and Pop are our two operations for dealing with the stack.  The last item you **pushed** onto the stack is the first item you'll **pop** off of it.

*[Draw picture of a stack, add a few items, then show how they're popped off]*

As you push more items onto the stack, the more space in memory it occupies - it grows.  As you pop items off of the stack, it shrinks.  The core purpose of stacks is to allow for the temporary storage of values at runtime for later retrieval.

In the MSP430, the stack grows upward - from higher locations in memory to lower locations in memory.

**Draw memory map.**

**Where in memory is the stack located?**

The SP is typically initialized to 0x400 because that is the address following the end of RAM.

Here are the relevant instructions:

| Opcode | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 100 | PUSH(.B) |  Push operand on stack. Push byte decrements SP by 2. Most significant byte not overwritten.  CPU BUG: PUSH #4 and PUSH #8 do not work when the short encoding using @r2 and @r2+ is used. The workaround, to use a 16-bit immediate, is trivial, so TI do not plan to fix this bug. |

| Emulated Instruction | Assembly Instruction | Notes |
| :---: | :---: | :---: |
| POP dst | MOV @SP+, dst | |

**Draw picture of stack when executing.**

Consider the following example:
```
        mov.w       #0x0400, r1         ;initialize stack pointer

        push.w      #0xdfec             ;push the value 0xdfec onto the stack. this decrements the SP by two to 0x03fe and stores EC at 0x03fe and DF at 0x03ff - as we'd expect with a little-endian system
        pop.w       r10                 ;pop the value we just pushed off of the stack and into r10 - this decrements the SP by two, back to 0x0400.

        push        #0xbeef
        push.b      #0xcc
        push        #0xdfec

        pop         r5
        pop.b       r6
        pop         r7

        push        #0xfade
        push.b      #0xaa
        push        #0xdeaf

        pop.b       r5
        pop         r6
        pop.b       r7
```

*[Run through in debugger]*

- Notice how the stack doesn't erase values on pop.
- Notice how the most significant byte isn't overwritten in a `push.b` operation.
- You must remember order and the size of the data you pushed onto the stack when popping!

Let's consider how I might use the stack if I wanted to swap the values in two registers:
```
push.w      r10
mov.w       r11, r10
pop.w       r11
```

Pretty simple, right?

**What would happen if we didn't initialize the stack pointer at the start of our program?**

We'd have no way of knowing where the SP is.  There's a good chance it could be in ROM - in that case, we can't write that memory at runtime, so we'd have no way of storing variables there - we'd pop unpredictable values.  It could be in unimplemented memory - in which case an access would return unpredictable values.  It could be in our peripherals, in which case writing could have all sorts of unpredictable results.

Let's say we remember to initialize the stack.  **What would happen if we pushed too many variables onto it?**

We could find ourselves overwriting a section of RAM that we're storing program variables in.  We could also totally go through our RAM and into our peripherals.  This is called a **stack overflow**.

## Subroutines

The stack is crucial in allowing us to implement the programming construct of subroutines.  Jumps aren't very modular - they're tough to reuse because labels are specific to each program and we're jumping to the same locations in the program.  Subroutines don't have this limitation.  We can **call** a subroutine, allow it to perform its function, and then **return** to wherever we left off in our main program.  This makes our code easier to read and also allows us to reuse certain subroutines in future programs.  It's never bad to save a little work!

Here are the MSP430 instructions that relate to subroutines:

| Opcode | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 101 | CALL |  Fetch operand, push PC, then assign operand value to PC. Note the immediate form is the most commonly used. There is no easy way to perform a PC-relative call; the PC-relative addressing mode fetches a word and uses it as an absolute address. This has no byte form. |

The act of calling saves our return location!

**Important:** You should call all subroutines using the immediate addressing mode - there's no easy way to do it PC-relative.  A call should be of the form `call  #mySubroutine`.

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| RET | MOV @SP+, PC |

Pops the return location off of the stack, into the PC.

**What would happen if we didn't initialize the stack pointer at the start of our program and tried to call a subroutine?**

There's a good chance we'd never be able to return to our main program!  I bet we'd crash the chip.

### Our First Subroutine

```
main:
    mov.w   #2, r10
    mov.w   #4, r11
    call    #addition
    nop
    nop
    nop
    nop

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
;Function: Adds two numbers
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

In our example, we passed in the value 2 in r10 and the value 4 in r11, then returned the result in r11.

### Pass-by-Reference

The second method is pass-by-reference - where we pass a reference to the data (its address) to the subroutine.  This is useful when we're taking arguments from memory or want to modify some memory within the subroutine.

Let's modify our addition subroutine to take arguments in memory locations.

```
;---------------------------------------------------
;Subroutine Name: Addition
;Authoer: Capt Todd Branchflower, USAF
;Function: Adds two numbers, returns the result
;Inputs: address of operand1 in r10, address of operand2 in r11
;Outputs: result in r11
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

### Key Subroutine Rules

**Always return from a subroutine!**

You should never enter a forever loop in a subroutine.  You should never jump out of a subroutine.  The final instruction in every subroutine should be `ret`.  You should only return from one place in your subroutine.

**Subroutines only receive information via registers!**

The whole point of subroutines is modularity.  Meaning they should be reusable in many different programs.  In that regard, independence is key.  Subroutines should not rely on specific label names, which are usually unique to individual programs.  You can declare your own constants (via `.equ` statements) in subroutines, but these should never change across programs.

**Subroutines should be reusable!**

So split your problems into parts that logically belong together and could be reused independently.  Don't make your subroutines so unique that they could never be reused unless for the exact application you're working on.  Put the application-specific parts in their own subroutine.

### Application Binary Interface (ABI)

Even modern operating systems must obey the convention of specifying which registers are used for arguments passed in to a subroutine and which are used to pass back results.  This convention is known as the Application Binary Interface (ABI).


## Lab 2 Introduction

For Lab 2, you're going to use your new knowledge of subroutines to decrypt some encrypted messages with keys of different lengths.  This is the first semester this lab has ever been done!

[Lab 2](/labs/lab2/index.html)

- Basics of `XOR` encryption
    - `XOR` message with key to encrypt
    - `XOR` again to decrypt
    - Do basic example
        - 10101011 data (0xab)
        - 01010101 key (0x55)
- ASCII Characters
    - ASCII is an encoding for English characters and punctuation
    - It encodes each character in a single byte
- Functionality
    - Required: byte length key
    - B: word length key
    - A: arbitrary length key
    - Bonus: crack message without knowledge of key
- Restrictions on program
    - decrypt_message routine is pass-by-reference
    - decrypt_character routine is pass-by-value
    - Follow the structure outlined in the lab!
- 2 Lessons to accomplish this

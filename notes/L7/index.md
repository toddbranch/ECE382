title = 'Arithmetic / Logic, Shift / Rotate Instructions.  Watchdog Timer.' 

# Lesson 7 Notes

## Readings
- [Watchdog Timer](http://en.wikipedia.org/wiki/Watchdog_timer)
- [MSP430 Family Users Guide pp341-348](/datasheets/msp430_msp430x2xx_family_users_guide.pdf)
- [ppt](Lsn7.pptx)

## Assignment

- [Control Flow](L7_control_flow.html)

## Lesson Outline
- Arithmetic Instructions
- Logic Instructions
- Shift / Rotate Instructions
- Watchdog Timer

## Admin

- Video
- Parents weekend
    - Who has parents coming on Friday?
    - Any DVs I should know about?
    - Friday is your lab day - you need to come prepared to work.  Parents can help you - but this needs to be a productive period or you'll be behind.  You  only get one lab day for Lab 1.
- Pass out lab notebooks
    - We'll discuss expectations next class.
- Questions about stuff we did last lesson?  Earlier?
- CompEx
    - When I say "write a program that...", that is NOT an abstract exercise.  You have the development board - write in CCS, run, and debug!
- Datasheets
    - Has anyone looked at the datasheets on the datasheets section of the website?
    - **These are crucial** - the definitive guide to the chip.
    - You'll reference these all the time - they have information about every feature and subsytem on the chip.
    - Look at Family Users Guide
        - Has info common to all chips in MSP430x2xx family
        - Show:
            - Memory map
            - Addressing modes
            - Registers, status register
            - Instruction set
    - Look at chip-specific datasheet
        - Show pinout

[Link to all code](all_code.html)

What did we talk about last time?

Last time, we discussed the Status Register and how it's used in conditional code exectuion in assembly language programs.  We saw how we could use it and relative jump instructions to implement higher level code constructs like if/then and looping.  This time, we're going to learn about a lot more of the available MSP430 instructions - what they do, what flags they set, etc. - it will be our last lesson on the instruction set.  After today, I'll expect that you're all comfortable using these instructions to write your own assembly programs.

### Warning

Remember our memory map from L2.  We saw that there was a large portion (0x1100 - 0xbfff) that was unused - the msp430g2553 doesn't have memory at those addresses.  If you try to execute these unimplemented sections of memory, that will trigger a Power-Up Clear (PUC) and reset your chip.  Bugs like these can be tough to diagnose if you're not looking for them.  This typically is the result of PC-relative addressing problems - similar to the one we talked about on the hand-assembly assignment.  Remember the problem there?

## Arithmetic Instructions

Ok, let's take a look at a few more instructions.

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 0101 | ADD src, dest | dest += src | |
| 0110 | ADDC src, dest | dest += src + C | |

Make error - get class to diagnose - forget `0x`.

```
    mov     #0xabab, r10
    add     #0xabab, r10    ; sets C and V

    addc    #2, r10         

```

Look at Family Users Guide - if no carry, treated as borrow.

For `SUBC`, think about it as flipping the carry bit!  If C=1, it won't subtract the carry.  If C=0, it will.

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 0111 | SUBC src, dest | dest += ~src + C | |
| 1001 | SUB src, dest | dest -= src | Implemented as dest += ~src + 1 |

```
    mov     #5, r10
    sub     #8, r10         ; which flags will be set?  carry because we're adding the 2's complement!  Remember - 2's complement is 1 + bitwise not

    subc    #1, r10         ; expected result

    mov     #5, r10
    sub     #4, r10

    subc    #1, r10         ; weird result - what's going on here?  Watch out for SUBC - can be confusing!
```

Show DADD in datasheet to illustrate use of carry bit.

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 1001 | CMP src, dest | dest - src | Sets status only; the destination is not written. |
| 1010 | DADD src, dest | dest += src + C, BCD (Binary Coded Decimal) | |

Compare sets the flags based on subtracting the destination from the source - but it does not write to the destination.  It can be a little tricky to wrap your head around.

```
    mov     #5, r10
    cmp     #10, r10        ;evaluates 1-10, sets negative flag - remember, subtraction involves adding the 2's complement (a bit-wise invert + 1)

    subc    #1, r10         ; still weird!

    mov     #10, r10
    cmp     #1, r10         ;evaluates 10-1, sets carry flag - remember, subtraction involves adding the 2's complement (a bit-wise invert + 1)
```

DADD does binary coded decimal (BCD) addition.  In BCD, each nibble represents a binary digit.  So if I used DADD to add 0x0009 and 0x1, the result would be 0x0010 - not 0x000A.  This can actually be very useful if you're recording a value for later output in decimal.  Another note - DADD also adds the carry bit!  If you want a pure add, clear the carry first.

```
    clrc
    mov     #0x99, r10
    dadd    #1, r10
    setc
    dadd    #1, r10         ; DADD uses the carry bit!
```

These are great for going up or down a word or byte.

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| DEC(.B) dst | SUB(.B) #1, dst |
| DECD(.B) dst | SUB(.B) #2, dst |
| INC(.B) dst | ADD(.B) #1, dst |
| INCD(.B) dst | ADD(.B) #2, dst |

The assembler provides some emulated increment / decrement commands.  The D postfix means double - so it will increment or decrement by 2.

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| ADC(.B) dst | ADDC(.B) #0, dst |
| DADC(.B) dst | DADD(.B) #0, dst |
| SBC(.B) dst | SUBC(.B) #0, dst |

SBC only works when the carry is clear!

This final set of emulated instructions allows you to add or subtract the carry bit by itself.

```
    incd    r10
    dec     r10

    sbc     r10             ;why doesn't this subtract one?  think about what the operation is doing

    clrc

    sbc     r10

    setc
    adc    r10
```

## Logic Instructions

These instructions can be very useful for manipulating / testing individual bits.  They're the foundation for the emulated instructions we talked about last time that set or clear flags in the Status Register.

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 1011 | BIT src, dest | dest & src | Sets status only; the destination is not written. |
| 1100 | BIC src, dest | dest &= ~src | The status flags are NOT set. |
| 1101 | BIS src, dest | dest &#124;=src | The status flags are NOT set. |

```
    mov     #1, r5

    bit     #1b, r5
    bit     #10b, r5
    bit     #100b, r5

    mov.b   #0xff, &P1OUT 
    mov.b   #0xff, &P1DIR

    bic     #1b, &P1OUT
    bic     #1000000b, &P1OUT
    bis     #1b, &P1OUT
    bis     #1000000b, &P1OUT
```

Logical operators AND and XOR are available as well.  These operations set status flags, while the BIC / BIS operators don't.

| Opcode | Assembly Instruction | Description | Notes |
| :---: | :---: | :---: | :---: |
| 1110 | XOR src, dest | dest ^= src | |
| 1111 | AND src, dest | dest &= src | |

```
    mov     #0xdfec, r12
    mov     #0, r11
    setc
    and     r11, r12
    mov     #0x5555, r11
    xor     #0xffff, r11
```

There are a few emulated logical instructions: INV, CLR, and TST.  TST has unique behavior in that it always clears the V flag and set the C flag.  N and Z are set as expected.

INV will flip all of the bits, CLR sets all bits to 0, TST compares the dst to 0.

| Emulated Instruction | Assembly Instruction | Notes |
| :---: | :---: | :---: | :---: |
| INV(.B) dst | XOR(.B) #-1, dst | Sets overflow if result sign is different than inputs |
| CLR(.B) dst | MOV(.B) #0, dst | No flags set, since it's a MOV |
| TST(.B) dst | CMP(.B) #0, dst | V always clear, C always set |

```
    mov     #0xec00, r10
    inv     r10                 ;$r10 is 0x13ff, set overflow and carry flags
    bic     #100000000b, r2     ;clear overflow bit
    mov     #0x8000, r10
    inv     r10                 ;$r10 is 0x7fff, set overflow and carry flags

    clr     r10                 ;$r10 is 0 - status flags not set because this is a mov instruction
    tst     r10                 ;set zero, carry flags
    inv     r10                 ;$r10 is 0xffff, set negative and carry flags
    tst     r10                 ;set negative, carry flags  
```

## Shift / Rotate Instructions

RRC is great for divide by 2 - if carry clear.  RRA is great for signed divide by 2.

| Opcode | Assembly Instruction | Description |
| :---: | :---: | :---: |
| 000 | RRC(.B) |  9-bit rotate right through carry. C->msbit->...->lsbit->C. Clear the carry bit beforehand to do a logical right shift. |
| 001 | SWPB | Swap 8-bit register halves.  No byte form. |
| 010 | RRA(.B) | Badly named, this is an arithmetic right shift - meaning the most significant bit is preserved. LSB moves into carry. |
| 011 | SXT | Sign extend 8 bits to 16.  No byte form. |

If the carry is cleared, RRC is a logical right shift.  RRA is an arithmetic right shift.  Since the MSB is preserved, this is a way to divide by 2.  Since the LSB is discarded, the result is always rounded down.

SXT sign extends the MSB of the lower byte into the upper byte.  SWPB sways 8-bit register halves.

```
    clrc
    mov     #10010101b, r10
    rrc.b     r10                     ;r10 is now 01001010, carry is set 
    rrc.b     r10                     ;r10 is now 10100101, carry bit is clear

    rra.b     r10                     ;r10 is now 11010010, carry bit is set 
    rra.b   r10                     ;r10 is now 11101001, carry bit is clear

    swpb    r10
    swpb    r10

    sxt     r10
```

Rotate left is emulated by addition.  A rotate left is the equivalent of multiplication by two, so it is emulated by adding the destination to itself.

RLA is not arithmetic - doesn't preserve most significant bit.  Carry comes in on the right for RLC.

| Emulated Instruction | Assembly Instruction |
| :---: | :---: | :---: |
| RLA(.B) | ADD(.B) dst, dst |
| RLC(.B) | ADDC(.B) dst, dst |

```
    mov     #2, r10

    rla     r10         ;$r10 is now 0x4
    rla     r10         ;$r10 is now 0x8 
    setc
    rlc     r10         ;$r10 is now 0b10001, or 0x11
```

## Watchdog Timer (WDT)
Microcontrollers like the MSP430 are typically used in embedded applications - meaning they are meant to function within devices without human intervention.  You often can't easily access the MCU to restart it if necessary.

Because of this, MCUs need to be able to monitor themselves for problems and restart if necessary.

**Demo in software - set breakpoint on reset, comment out WDT line**

This job is performed by the Watchdog Timer (WDT) on the MSP430 or computer operating properly (COP) on other devices.  It's a timer that, if not reset in a timely fashion, resets the chip.  The idea is that if code execution is faulty, it will neglect to reset the WDT and will eventually be reset, fixing the problem.  Properly executing code must regularly reset the WDT or the chip will constantly restart.

In the MSP430, after a PUC condition, the WDT enters watchdog mode with a period of 32768 cycles.  The user must setup / halt / clear the WDT prior to the end of this period, or it will generate a PUC.  Periodically clearing the timer is known as petting the dog or kicking the dog.  The default clock speed for the MSP430 is in the 1MHz range.

So how long do you have before your chip resets?

So you have approximately 32 milliseconds to reset it.  It needs to be one of the first things you do in your program.

We'll cover this more later, but special functions / peripherals are manipulated by registers in memory.  Remember our memory map - 8-bit peripherals from 0x10-0xff, 16-bit peripherals from 0x100-0x1ff.  The Watchdog Timer Control Register (WDTCTL) is manipulated this way.

**Show in datasheet!**

Here's the structure of the register:

| 15 | 14 | 13 | 12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| WDTPW	colspan=8 | WDTHOLD | WDTNMIES | WDTNMI | WDTTMSEL | WDTCNTCL | WDTSSEL | WDTISx colspan=2 |

User's guide page 355.

WDTPW - the WDT uses a password to prevent inadvertent writing - it's 0x5a.  You must write that in the upper 8 bits for a write to work - otherwise you'll get a PUC.
WDTHLD - setting this bit stops the watchdog timer.

Other registers are unnecessary for our purposes at this point, but explore them more if you want.

Here's some code that disables the watchdog:
```
    ;disable watchdog timer
    mov     #WDTPW, r10         ;to prevent inadvertent writing, the watchdog has a password - if you write without the password in the upper 8 bits, you'll initiate a PUC.
                                ;the password is 0x5a in the upper 8 bits.  if you read from the password, you'll read 0x69.
    bis     #WDTHOLD, r10       ;next, we need to bis the password with the bit that tells the timer to hold, not count
    mov     r10, &WDTCTL        ;next, we need to write that value to the WDTCTL - this is a static address in memory (not relative to our code), so we need 
```

## Wrap Up

You've got homework tonight - and it is programming!  You'll have to use the conditional code execution and arithmetic ops we talked about the last two lessons to be successful.  My solution is 26 instructions long - extra credit to people who can write a shorter program that fulfills the requirements.

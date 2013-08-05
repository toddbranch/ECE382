# Lesson 13 Notes

## Readings
[Memory-mapped IO](http://en.wikipedia.org/wiki/Memory-mapped_I/O)

## Assignment

## Lesson Outline
- Peripherals
- Memory-Mapped IO
- Ports
- GPIO
- Multiplexing

What did you think of the encryption lab?  That's brand new for this year - so give me any feedback you've got and I'll incorporate it for next year's class.

So through that lab, we showed that the CPU on the MSP430 can be used to accomplish any type of general purpose programming task via its instruction set architecture (ISA).

But the power of an MCU isn't in its ability to accomplish general-purpose computing. It's meant to be embedded in the real world, interacting with peripherals without human intervention - and MCU design is finely tuned for those functions. In that regard, there's a ton of built-in hardware support to make common embedded functions fast and easy for the programmer.

## Peripherals

Here's a rundown of some of the features that the MSP430G2xx has hardware support for *(show MSP430 wikipedia)*:

- Watchdog Timer
- Universal Serial Communication Interface (USCI) - implements SPI and I2C protocols
    - We'll use SPI to interface with the LCD in your black box
- Pulse Width Modulation (PWM) - we'll use this later to drive the robot
- Temperature Sensor
- Capacitive Touch I/O
    - For working with touch screens, etc.

Different variants of the MSP430 support a huge array of peripherals.

Even within the MSP430, there is a ton of diversity in the peripherals that different variants support. That's where scoping the problem you're trying to solve is important. You want all of the features you need, but don't want to pay for additional hardware that you'll never use. More features = more expensive.

If you look in the User's Guide, you'll notice a range of peripherals that the MSP430G2553 doesn't support - but other members of the family do.

Remember how you had to implement multiplication in software in Lab 1 - "Calculator" - (for A Functionality)? There are variants of the MSP430 that come with hardware multipliers that support multiply instructions.

Most of these features are beyond the scope of this class. But we'll introduce you to a couple and give you the tools to learn more about the peripherals you'll need for future projects.

## Ports

A port is in interface between the computer and other computers or peripheral devices.  What are some ports you've heard of?  (USB, ethernet, VGA, HDMI, RS-232, etc.)

In the MSP430, a port is a grouping of pins used for interfacing with other devices.  By default, on your Launchpad board you've got access to Port 1 Pin 0 - Pin 7 and Port 2 Pin 0 to Pin 5.  Port 2 actually has 8 total pins, but the DIP packaging doesn't give you access to all of them by default.  If we need, we can get access to the others using multiplexing (which I'll talk about later).  The largest MSP430 devices go up to P11.

The different features of MSP430 chips we just talked about are made available to peripherals through these pins.

## Two Techniques for IO

So how do we interact with these ports / features?  In the MSP430, we use specialized registers that have their own locations in the MSP430 memory map.  This is known as memory-mapped IO.

### Memory-Mapped IO

IO and memory share the same address space.  Peripherals are mapped to specific addresses in the MCU address space.

![MSP430 Memory Map](../L2/memory_map.jpg)

Advantage: 
    - Fewer instructions
    - Can use the same addressing modes for IO as for other instructions

Disadvantage: Lose memory to IO.

### Isolated IO or Port-mapped IO

Speical set of instructions for manipulating IO - found on Intel microprocessors.  IO also resides in its own, separate address space.

Advangtage: Don't lose memory for IO

Disadvantage: Need more instructions.

## GPIO

Ports are often used for implementing specific interfaces.  When they're not used for that, you can use them for whatever you want 

General Purpose Input Output (GPIO) is the default peripheral available on your ports.  When configured in output mode, this allows you to drive each bit / pin individually to logic high or low.  When configured in input mode, you can read logic high or low from an external source.  It's perfectly acceptable to have some pins be output and others input on the same port.

The registers used to configure GPIO are PxDIR, PxOUT, and PxIN.

- PxDIR configures which pins are input and which pins are output - 1 corresponds to output, 0 to input
- Writing to PxOUT controls the output of each pin
- PxIN allows you to read the values on these pins

*[Look them up in the Family User's Guide]*

- Show default values that GPIO resets to

There are additional registers that control other characteristics of GPIO, but we'll stick with these for now.

Let's say I wanted to configure P1.0-3 to be output and P1.4-7 to be input.  Code would look like this:
```
mov.b   #0b00001111, &P1DIR

; drive P1.0-3 all high
bis.b   #0b00001111, &P1OUT

; this would work also
mov.b   #0xff, &P1OUT

; read from P1.4-7 to a register
mov.b   &P1IN, r5
```

**PITFALL!**
```
mov.b   #0xff, P1DIR        ; PC-relative addressing is a **bad idea** for addressing peripheral registers
```

Since you have complete control, GPIO is infinitely flexible.  If the MCU you're using lacks a peripheral implementing a certain protocol and it's impractical to get one that has it, it's always possible to bit-bang the protocol.  That involves driving GPIO to achieve the individual bits you need to communicate.

## Multiplexing

Pins are expensive - and most applications won't use all of the features available in a chip for a single application. So designers save on cost by making many different functions available on the same pin.

Some dev boards give you a ton of pins *[show S12 dev board]*.  Ours does not.

Remember the pinout for our MSP430G2553:

![MSP430G2553 Pinout](msp430g2553_dip20_pinout.jpg)

We can only use a port for one purpose at a time. So we need a way to select the particular function we want a pin to perform. We accomplish that via the PxSEL and PxSEL1 registers. Different combinations of these bits make different functions available on a pin. The details are in the [MSP430G2x53 2x13 Mixed Signal MCU Datasheet](/datasheets/msp430g2x53_2x13_mixed_sig_mcu.pdf).

Here's an example from the datasheet:

![P1.0-2 Multiplexing Control Bits / Signals](p1_multiplexing_control_bits.jpg)

Let's say I wanted to make the UCA0SOMI function available on P1.1. Here's the code I'd use:

```
; 'from USCI' means this bit is set automatically by the USCI when enabled
bis.b   #BIT1, P1SEL   
bis.b   #BIT1, P1SEL2

; others are set correctly by default - you should set them if previous code used them
```

Next lesson, we'll learn about using a technique called polling to accept input from peripherals.

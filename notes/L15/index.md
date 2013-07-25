# Lesson 15 Notes

## Readings
[Serial Peripheral Interface (SPI)](http://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus)
[[Lab 3](/labs/lab3/index.html)](/labs/lab3/index.html)

## Assignment
[[Lab 3](/labs/lab3/index.html)](/labs/lab3/index.html) Prelab

## Lesson Outline
- Serial Comm Fundamentals
- Serial Peripheral Interface (SPI)
- SPI on the MSP430
- [Lab 3](/labs/lab3/index.html) Introduction
- Logic Analyzer Demo

*[Syllabus on big screen.]*  Three full lessons for [Lab 3](/labs/lab3/index.html)!  This doesn't mean that you've got some time to relax - this means that [Lab 3](/labs/lab3/index.html) is a lot of work.  I'll discuss it more at the end of the lesson, but you'll be interfacing with external hardware for the first time in this lab.  *[Show lab demo on big screen]*.  To interface with the LCD, you need to use a protocol call SPI - the Serial Peripheral Interface.  That's what we'll talk about today.

Everything we do today will prepare you for [Lab 3](/labs/lab3/index.html).

## Serial Comm Fundamentals

Serial Communications typically involve using a single wire for data transmission as opposed to multiple wires in Parallel Communications.  This has the benefit of simplicity in the interface, resulting in economy of hardware (particularly valuable pins).  You can also typically drive these interfaces at faster clock speeds (don't have to worry about crosstalk, etc).  A downside is the need for on-chip hardware or software to decode the serial signal.

Can anyone name any serial protocols?

Our MSP430 is very pin-limited.  A serial protocol is beneficial in this circumstance because it uses many fewer precious pins that could be devoted to other purposes.  Attempting to drive a parallel interface would use up almost all of our available pins.

*[Show parallel interface for the LCD - discuss how many pins we'd have left after implementing this with our MSP430]*

## Serial Peripheral Interface (SPI)

In Lab 3, we're going to drive our LCD using the Serial Peripheral Interface (SPI).  SPI is probably the simplest peripheral interface there is.  It involves chaining shift registers on two devices together along with a clock.  With each clock cycle, a single bit transferred from the MSB of one shift register to the LSB of the other.  After 8 clock cycles, an entire byte has been transferred between the chips.

It involves two devices - a master and a slave - and four signals:

- Master Out Slave In (MOSI)
- Master In Slave Out (MISO)
- Clock
- Slave Select (SS)

It's the job of the master to provide the clock signal to the slave so that transmissions can be synchronized.  Depending on configuration, data can be read or written on either the rising or falling edge.

The Slave Select signal allows the master to potentially use the same interface to potentially interact with multiple slaves.

Here's a sample of how you might wire up a SPI interface:  
![SPI Interface](spi_interface.jpg)

And here's a peak into its internals:  
![SPI Internals](spi_internals.jpg)

Hardware support for SPI on MCUs is usually very flexible.  There are configuration bits in the SPI control registers that can control all of these characteristics.  This is because peripherals use a wide range of SPI configurations - it's critical that you read the datasheet for the SPI component you're trying to interface with and match its expectations. 

**Talk about different configurable elements**

## SPI on the MSP430

### Universal Serial Communication Interface (USCI)

Your MSP430G2553 comes configured with two Univeral Serial Communication Interfaces (USCI), A and B.  These are essentially hardware state machines that can be used for either SPI or I2C - making it extremely easy to implement the protocols.  Their function is configured using a couple of control registers.

**Talk about control registers**

### Configuring the USCI for SPI

In the MSP430 Family Users Guide, they offer a suggested SPI initialization sequence:

![MSP430 SPI Initialization Sequence](msp430_spi_init_sequence.jpg)

**Step 1**

Setting the UCSWRST bit in the appropriate UCSI control register resets the subsystem into a known state.  All the registers will hold their default values.

**Step 2**

Now we need to 

**Step 3**

All the ports on our MSP430 are multiplexed!  We need to set the PxSEL and PxSEL2 ports so that we have access to the SPI signals we need!

**Step 4**


**Step 5**

Registers

Flags - the Tx flag does not mean that the transmission itself is complete, just that it's ready for the next byte!

### Monitoring SPI Status

The MSP430 uses a double-buffered system to implement SPI - meaning you do not have direct access to the SPI shift registers.

The buffers you write to for transmission (UCA0TXBUF, UCB0TXBUF) are copied into the shift register when it's ready for the next byte.  This does NOT mean that the transmission has completed - just that the buffer is ready to accept another byte.

The buffers you receive from (UCA0RXBUF, UCB0RXBUF) are copied from the shift register when a full byte has been received.  This indicates that the full byte has been transmitted and received.

Their status can be monitored using flags UCA0TXIFG/ UCB0TXIFG and UCA0RXIFG/UCB0RXIFG, both in IFG2.  If you're trying to wait until the entire byte has been transmitted, you want to monitor the UCA0RXIFG or UCB0RXIFG flags, depending on the USCI you're using.  If you don't care and just need to fill the TX buffer whenever it's ready for my data, you should monitor the UCA0TXIFG or UCB0TXIFG.  The SPISEND subroutine in Lab 3 demonstrates this.

*[Demo this with Logic Analyzer if there's time]*

## [Lab 3](/labs/lab3/index.html) Introduction

[Lab 3](/labs/lab3/index.html) is your first opportunity to interface the MSP430 with external hardware - we'll be using pushbuttons and an LCD.  **It's a long lab**.  You'll need all the time, so make sure you don't fall behind.

You're going to be using push buttons to select a key and message, then use your subroutines from Lab 2 to attempt to decrypt the selected message with the selected key.

*[Demo of final product]*.

There is a lot of information on the lab handout and in the links included in the lab handout - **you'll need it**.  Follow it closely.

Describe required functionality.

Describe B functionality.

Describe A functionality.

## Logic Analyzer Demo

I'm going to walk you through the majority of your prelab right now by showing you how to do Step 1 of [Lab 3](/labs/lab3/index.html).  Here's what it says:

> **Step 1**: The Subsystem Master Clock (SMCLK) is the same speed as the Master Clock (MCLK) that runs your CPU.  Measure its period via logic analyzer - you'll want to screen capture / print this for your lab notebook.  There will be a table on the board for all students to record their CPU speed - record yours there.  **Never forget to ground your logic analyzer**.

Remember, the pins on our MSP430 are multiplexed because we don't have many.  We need to write some code to make it available on one of our pins so we can measure it.  Here's the MSP430G2553 pinout:

![MSP430G2553 DIP20 Pinout](/notes/L13/msp430g2553_dip20_pinout.jpg)

Looks like the SMCLK is available on P1.4 if I set the P1DIR, P1SEL, and P1SEL2 registers properly.  To the Users Guide!

![P1.4 Pin Functions](p1_4_pin_functions.jpg)

Using this, here's the code we need to get access to SMCLK:
```
mov.b   #0b00010000, &P1DIR
mov.b   #0b00010000, &P1SEL
```

After we program our device, we'll use the Logic Analyzer to look at the signal and do some measurements.

I'll hook up the black Ground wire on Pod 1 to ground on the MSP430.  I'll hook up Pod 1 Wire 0 to P1.4 - the signal I'm trying to measure.

I'll go into the XXXXXXX screen and select Pod 1 Wire 0 as the signal I'm trying to look at, then name the signal P1.4.

Next, I'll go into the XXXXXXXXX screen and set the sampling speed to be the fastest possible (once every 2ns).  Since this is a fast signal, I want to get the most accurate data possible.

Finally, I'll go into the Waveform screen and set the trigger on my signal to be falling edge.  I'll push the Run Single button and the trigger should hit instantaneously.

Now, I can see the shape and period of the SMCLK signal.  I'll drag my markers to measure falling edge to falling edge - and the distance between the markers will show at the top of my screen.  That's the period of my SMCLK.

1/period = frequency - now I know the frequency of my SMCLK!

Your clock speed will most likely be slightly different from mine because there is variability across MSP430 chips - so you'll have to perform this process yourself and record your results.  You'll also have to use this process to measure the length of your delays to ensure they satisfy the Lab requirements.

More information on using the [Logic Analyzer is available here](/labs/lab3/logic_analyzer.html).

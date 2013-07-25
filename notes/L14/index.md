# Lesson 14 Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Polling
- Debouncing
- Software Delay Routines

## Polling

*[Go around the room repeatedly asking each student if they have a question]*

That's an example of polling.  Polling is the act of repeatedly querying a peripheral to see if it has information for you.

Does that seem particularly efficient?  What's a better method?  Waiting for someone to **interrupt** me by raising their hand and handling the request then.  We'll learn about interrupts later in the semester, on Lesson 27.

But if the CPU doesn't need to be doing anything else, polling is a straightforward and effective method.  Let's say I wanted to write a little code to poll my Launchpad for when the button is pushed.  Here's what it might look like:
```
; polling example code
; set the appropriate port to input
poll_button:
    bit.b    #0b00000001, &P1IN             ; this assumes active high
    jz      poll_button

forever     jmp     forever
```

In Lab 3, you're going to be polling buttons for presses from a person to capture inputs.

## Debouncing

### Bouncing

The buttons you'll be using in Lab 3 are mechanical - and they have the tendency to bounce up and down before reaching a steady state.

*[Draw picture on the board]*

That's the concept, but let's look at how the concept manifests itself in the real world with a tool called the Logic Analyzer.

*[Use logic analyzer to demonstrate what button bouncing looks like, how unpredictable it can be]*

What's a potential problem that could arise from this button bouncing?

Your MSP430 is extremely fast - you could interpret a single button push as multiple pushes of the same button.  This error is extremely common.  How can we deal with it?

### Debouncing Strategies

**Delay until bouncing has stopped**

**Wait for steady state**

## Software Delay Routines

To implement its clock, the MSP430 uses a Digitally Controlled Oscillator (DCO).  An advantage is that it's tunable and can run at many different frequencies.  But it's an RC oscillator, so it can be inaccurate - a problem when we need to know the length of a clock cycle to the nanosecond. The default frequency is around 1MHz, but there's significant variance (0.8MHz - 1.5MHz) across chips.  This is remedied by calibrating it with a more accurate quarz crystal resonator (like the ones used in your watches) at the factory.  TI stores the proper calibrated values for DCOCTL and BCSCTL1 for 1MHz, 8MHz, 12MHz, and 16MHz in protected memory.

Here's how you'd use the calibrated values to ensure your chip is running at 1MHz:
```
mov.b   &CALDCO_1MHZ, &CALDCO
mov.b   &CALBC1_1MHZ, &BCSCTL1
```

I have measured the speed of the clock on this chip and it is XXXX.  As a part of Lab 3, you'll have to measure the precise frequency of your own MSP430.

Now that I know the frequency of my chip, how do I determine period?  Period = 1 / frequency.

*[Demo on logic analyzer that the period is correct]*

Next lesson, we'll learn about the Serial Peripheral Interface (SPI) - which the MSP430 has hardware support for.  You'll need all of this knowledge to configure / use the SPI subsytem on Lab 3.

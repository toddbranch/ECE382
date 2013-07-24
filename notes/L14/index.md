# Lesson 14 Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Polling
- Debouncing
- Software Delay Routines

## Polling

## Debouncing

## Software Delay Routines

To implement its clock, the MSP430 uses a Digitally Controlled Oscillator (DCO).  An advantage is that it's tunable and can run at many different frequencies.  But it's an RC oscillator, so it can be inaccurate - a problem when we need to know the length of a clock cycle to the nanosecond. The default frequency is around 1MHz, but there's significant variance (0.8MHz - 1.5MHz) across chips.  This is remedied by calibrating it with a more accurate quarz crystal resonator (like the ones used in your watches) at the factory.  TI stores the proper calibrated values for DCOCTL and BCSCTL1 for 1MHz, 8MHz, 12MHz, and 16MHz in protected memory.

Here's how you'd use the calibrated values to ensure your chip is running at 1MHz:
```
mov.b   &CALDCO_1MHZ, &CALDCO
mov.b   &CALBC1_1MHZ, &BCSCTL1
```

*[Demo on logic analyzer that the period is correct]*

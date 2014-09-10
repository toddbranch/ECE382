# L7 Assignment - Control Flow
Name:
Section:
Documentation:

## The Program

Write a program that reads an **unsigned** word from `0x0216`.

- If the value is greater than `0x1234`: 
    - Use a loop to add `20+19+18+...+1` (decimal)
    - Store the result (as a word) in `0x0206`
    - Note: don't add `20+19+18+...+1` to `0x1234`, just sum the sequence by itself and store in memory.
- If the value is less than or equal to `0x1234`:
    - If the value is greater than `0x1000`:
        - Add `0xEEC0` to the value
        - Store the value of the carry flag (as a byte) in `0x0202`
    - If the value is less than or equal to `0x1000`:
        - If the value is even:
            - Divide the value by 2
        - If the value is odd:
            - Multiply the value by 2
        - Store the result (as a word) in `0x0212`
- Once you've accomplished the appropriate task, trap the CPU

**Extra credit goes to the student who creates the shortest program.  My solution is 26 instructions long.**

## Questions

Run the following starting values through your program and record the results.

`0x1235`:
<br>
<br>
<br>
<br>
`0x1234`:
<br>
<br>
<br>
<br>
`0x1001`:
<br>
<br>
<br>
<br>
`0x0800`:
<br>
<br>
<br>
<br>
`0x801`:
<br>
<br>
<br>
<br>

In the MSP430G2553 detailed Tech Doc (75 pages): <br>
a)	What is the range of recommended operating voltages for the MSP430G2553? <br> <br> <br> <br>
b)	What is the absolute maximum and minimum voltage that should be applied to any pin? <br> <br> <br> <br>
c)	Running at 3.5v, what is the operating current of the MSP430G2553 at <br>
i)	Fdco = 16Mhz <br> <br>
ii)	 Fdco = 12Mhz <br> <br>
iii)	  Fdco = 8Mhz <br> <br> 
iv)	 Fdco = 1Mhz <br> <br>
<br>	
For the following question consult page 25.<br>
a) Assume your MSP430 is operating at room temperature and 3v supply.  You need to draw a large amount of current from an MSP430 I/O pin while not allowing the output voltage to fall below Vcc = 2.5v at high-level output voltage and rise above Vss = 0.5v at low-level output voltage.  How much current can you draw from the I/O pin in each case? <br> <br> <br> <br> <br> <br>
b) Pin P1.0 can be functionally multiplexed between digital output (I/O function) and an analog to digital converter input (A function).  Describe the settings of P1DIR.0, P1SEL.0, and P1SEL2.0 required to make this happen for these two situations.  Hint, consult page 43. <br> <br> <br> <br> <br> <br> <br> <br>

## Turn-in Requirements

- Email your instructor your final assembly program.
- Turn in this sheet with answers to the questions.

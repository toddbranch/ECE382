# Lesson 4 Notes

## Readings
Davies 5.2 (125 - 131)
[MSP430 Addressing Modes](http://mspgcc.sourceforge.net/manual/x147.html)

Note: Davies is great for walking through each addressing mode step-by-step and showing how it's relevant to higher-level programming.  MSP430 Addressing Modes addresses some of the nuances and conversion to machine code.

## Lesson Outline
- Addressing Modes
- CompEx1 Intro

## Addressing Modes

WARNING - potential pitfall:
```
mov.b   P1OUT,r7
```
Is not the same as:
```
mov.b   &P1OUT,r7
```

## CompEx1 Intro

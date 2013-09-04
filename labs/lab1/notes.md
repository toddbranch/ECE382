# Lab 1 Notes

## Use Assembler Directives!

Your program is going to be reading a series of operands and operations from memory.  Use the `.byte` directive to store them!

```
                .text
myProgram:      .byte      0x13,0x22,0x14,0x11,0x37
```

Your program is going to be storing results to memory.  Use the `.space` directive to store space for them!

```
                .data
myResults:      .space      20                          ; reserving 20 bytes of space
```

Hex values code for operations.  I better not see any magic numbers!
```
ADD_OP:         .equ        0x11
SUB_OP:         .equ        0x22
```

## Use Good Code Style!

- Comments
    - Assume the reader is a competent assembly language programmer
    - Comment above blocks of code to convey **purpose**
    - Only comment individual lines when purpose is unclear
- Labels
    - Descriptive!
        - loop or loop1 or l1 or blah - not acceptable!
    - Used for all memory location, jumps, etc. 
- Constants
    - Use `.equ` syntax for all constants!
    - Don't want to see naked values
- Instruction Choice
    - Use the instruction that makes your code readable!
        - `JHS` rather than `JC`
        - `INCD` rather than `ADD #2`
    - Well-written code requires few comments
- Spacing
    - Align your code to make it readable
    - Put whitespace between logical blocks of code

## Remember Design Principles!

**Get one small thing working first.**

**Break a big project up into smaller, more manageable tasks.**

**Test your code!  Better yet, write your tests before you write your code.**


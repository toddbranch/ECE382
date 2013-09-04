# Lab 2 - Subroutines - "Cryptography"

## Objectives

You'll practice your programming skills by writing some subroutines.  You'll need to use both the call-by-value and call-by-reference techniques to pass arguments to your subroutines.

## Details

### The Basic Idea

You'll write a program that decrypts an encrypted message using a simple encryption technique.  To achieve A-level functionality, you'll have to decrypt a message with an arbitrary length key.

A simple, yet effective encryption technique is to ``XOR`` a piece of information with a key and send the result.  The receiver must have the key in order to decrypt the message - which is accomplished simply by `XOR`ing the encrypted data with the key.  Let's say I wanted to send the binary byte `0b01100011` and my key was `0b11001010`.  To encrypt, I `XOR` the two - the resulting byte is `0b10101001`.  To decrypt, I `XOR` it with the key again - the resulting byte is `0b01100011` - the same as the original byte!

An encrypted message of arbitrary length is stored in ROM.  Your job is to decrypt it, given a key - which is also stored in ROM.  The contents of the message are [ASCII characters](http://en.wikipedia.org/wiki/ASCII) - each character is encoded in a single byte.  You know that the final decrypted byte of every message is `0x23`, the `#` character in ASCII.  You must write two subroutines.  The job of the first is to decrypt an individual piece of information.  It should use the pass-by-value technique and take in the encrypted value and the key and pass out the decrypted value.  The job of the second is to leverage the first subroutine to decrypt the entire message.  It should use the pass-by-reference technique to take in the address of the beginning of the message, the address of the key, and the address in RAM where the decrypted message will be placed.  It will pass the encrypted message byte-by-byte to the first subroutine, then store the decrypted results in RAM.

Almost all of the work of your program will be performed in your two subroutines.  Your main program should look something like this:
```
;initialize stack
;disable watchdog

;load addresses into registers to pass to decrypt_message subroutine

call        #decrypt_message

forever     jmp     forever     ;trap CPU
```

Sometimes the key isn't conveniently the same length as the unit of information you're trying to decrypt.  To achieve B functionality, you'll have to adjust your implementation to handle word-length keys.

To achieve A Functionality, extend this idea to decrypt messages with arbitrary length keys.

To achieve unbreakable encryption, the key and the message must be the same length.  For long messages, this is often impractical and a key substantially shorter than the message is used.  Thus, the key must be applied repeatedly to decrypt the message.  You can exploit this repition to crack the message.  This is even easier if you have knowledge of the contents of the message (ASCII text, for instance).  To complete the Bonus Challenge, you'll have to use this technique to decrypt a message without knowledge of the key.

### Required Functionality

- The encrypted and decrypted message will be in memory locations.  The encrypted message and key will be stored in ROM - any location in ROM is acceptable.  The message will be of arbitrary length, but the key will be one byte long.  The decrypted message will be stored in RAM starting at 0x0200.  Labels shall be used to to refer to the location of the encrypted message, decrypted message, and key.
- The key and encrypted message will be given to you.  The final decrypted byte of every message is `0x23`, the ASCII `#` character.
- Good coding standards, in accordance with the [Lab guidelines](/admin/labs.html), must be used throughout.

Encrypted Message:  
```
0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9
0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d
0x8c,0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9
0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c
0xd8,0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f
0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9
0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd,0xcb
0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf
0xc4,0xc5,0xc9,0xda,0xc9,0xc8,0x8c,0xde
0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c
0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2
0xcd,0xc0,0xc5,0xd8,0xd5,0x8d,0x8f
```

Key: `0xac`

### B Functionality

In addition to the Required Functionality, your program must decrypt messages with word-length keys.

Encrypted Message:  
```
0x91,0x85,0xbc,0x89,0xff,0x86,0xb0,0x8e
0xfe,0xcc,0xff,0xb5,0xb0,0x99,0xf8,0x9a
0xba,0xcc,0xac,0x99,0xbc,0x8f,0xba,0x9f
0xac,0x8a,0xaa,0x80,0xb3,0x95,0xff,0x89
0xb1,0x8f,0xad,0x95,0xaf,0x98,0xba,0x88
0xff,0x8d,0xff,0x81,0xba,0x9f,0xac,0x8d
0xb8,0x89,0xff,0x99,0xac,0x85,0xb1,0x8b
0xff,0x8d,0xff,0x9b,0xb0,0x9e,0xbb,0xc1
0xb3,0x89,0xb1,0x8b,0xab,0x84,0xff,0x87
0xba,0x95,0xff,0x8d,0xb1,0x88,0xff,0x8d
0xbc,0x84,0xb6,0x89,0xa9,0x89,0xbb,0xcc
0x9d,0xcc,0x99,0x99,0xb1,0x8f,0xab,0x85
0xb0,0x82,0xbe,0x80,0xb6,0x98,0xa6,0xcd
0xfc
```

Key: `0xdfec`  

### A Functionality

In addition to the B Functionality, your program must decrypt messages with arbitrarily long keys.  The keys are arbitrarily long series of bytes.

The length of the key should be a parameter passed into your subroutine.

Your subroutines don't have to exclusively pass-by-reference or pass-by-value - it's perfectly acceptable to make a subroutine that uses both.

Encrypted Message:  
```
0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac
0x42,0xcb,0xba,0x03,0xc7,0xba,0x5a,0x8c
0xb3,0x46,0xc2,0xb8,0x57,0xc4,0xff,0x4a
0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab
0x50,0x82,0xff,0x03,0xe5,0xab,0x03,0xc3
0xb1,0x4f,0xd5,0xff,0x40,0xc3,0xb1,0x57
0xcd,0xb6,0x4d,0xdf,0xff,0x4f,0xc9,0xab
0x57,0xc9,0xad,0x50,0x80,0xff,0x53,0xc9
0xad,0x4a,0xc3,0xbb,0x50,0x80,0xff,0x42
0xc2,0xbb,0x03,0xdf,0xaf,0x42,0xcf,0xba
0x50,0x82,0xfc
```

Key: `0xacdf23`

Successfully decrypting this message will give you useful information to solve the Bonus Challenge.

### Bonus Challenge

In addition to A Functionality, you must decrypt the following message without knowledge of its key:

Additional information: 

- the message is exactly 43 characters long - you can tell by counting the bytes.
- cracking the message will take substantially more CPU time than your previous programs - the CPU is doing a lot of work!

```
0x35,0xdf,0x00,0xca,0x5d,0x9e,0x3d,0xdb
0x12,0xca,0x5d,0x9e,0x32,0xc8,0x16,0xcc
0x12,0xd9,0x16,0x90,0x53,0xf8,0x01,0xd7
0x16,0xd0,0x17,0xd2,0x0a,0x90,0x53,0xf9
0x1c,0xd1,0x17,0x90,0x53,0xf9,0x1c,0xd1
0x17,0x90,0x50
```

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

Think about how you'll implement your subroutines.  Draw a flowchart of how it will operate - include pseudocode, as well as the interfaces to your subroutines (which registers contain inputs, which registers contain ouputs, etc.).

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/admin/labs.html) thoroughly and follow it.

If you want, decrypt the first word of the message by hand so you get the idea of how it works.  If the ASCII characters you're getting don't make sense, you're probably thinking about the problem wrong.

The MCU is fast - your program should execute almost instantaneously.  Set a breakpoint at the point in your code where you trap the CPU - if it isn't hit quickly, you've got a problem.

In CCS, it's possible to view memory as Characters - this will be helpful in determining whether you successfully decrypted a message.

Since decryption and encryption are the same operation, you can encrypt test messages using the same subroutines you'll use to decrypt them.  This would be a great way to test functionality of your code.

Use assembler directives for placing strings / byte sequences in memory:
```
stringLabel     .string     "This is a string!"
byteLabel       .byte       0xab,0xcd,0xef
wordLabel       .word       0xbeef
```

## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 5 | | BOC L9 |
| Required Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 35 | | COB L10 |
| B Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L10 |
| A Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L10 |
| Bonus Challenge | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L10 |
| Lab Notebook | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ----- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 40 | | COB L11 |
| **Total** | | | **100** | | |

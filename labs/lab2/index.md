# Lab 2 - Subroutines - "Cryptography"

## Objectives

You'll practice your programming skills by writing some subroutines.  You'll need to use both the call-by-value and call-by-reference techniques to pass arguments to your subroutines.

## Details

### The Basic Idea

You'll write a program that decrypts an encrypted message using a simple encryption technique.  To achieve A-level functionality, you'll have to decrypt a message without knowledge of the key that was used to encrypt it.

A simple, yet effective encryption technique is to ``XOR`` a piece of information with a key and send the result.  The receiver must have the key in order to decrypt the message - which is accomplished simply by `XOR`ing the encrypted data with the key.  Let's say I wanted to send the binary byte `0b01100011` and my key was `0b11001010`.  To encrypt, I `XOR` the two - the resulting byte is `0b10101001`.  To decrypt, I `XOR` it with the key again - the resulting byte is `0b01100011` - the same as the original byte!

An encrypted message of arbitrary length is stored in ROM.  Your job is to decrypt it, given a key - which is also stored in ROM.  The contents of the message are [ASCII characters](http://en.wikipedia.org/wiki/ASCII) - each character is encoded in a single byte.  You know that the final decrypted byte of every message is `0x23`, the `#` character in ASCII.  You must write two subroutines.  The job of the first is to decrypt an individual piece of information.  It should use the pass-by-value technique and take in the encrypted value and the key and pass out the decrypted value.  The job of the second is to leverage the first subroutine to decrypt the entire message.  It should use the pass-by-reference technique to take in the address of the beginning of the message, the address of the key, and the address in RAM where the decrypted message will be placed.  It will pass the encrypted message byte-by-byte to the first subroutine, then stores the decrypted results in RAM.

Almost all of the work of your program will be performed in your two subroutines.  Your main program should look something like this:
```
;initialize stack
;disable watchdog

;load addresses into registers to pass to decrypt_message subroutine

call        decrypt_message

forever     jmp     forever     ;trap CPU
```

Sometimes the key isn't conveniently the same length as the unit of information you're trying to decrypt.  To achieve B functionality, you'll have to adjust your implementation to handle arbitrarily long keys.

To achieve unbreakable encryption, the key and the message must be the same length.  For long messages, this is often impractical and a key substantially shorter than the message is used.  Thus, the key must be applied repeatedly to decrypt the message.  If you have knowledge of the contents of the message (you know it's English ASCII text, for instance), you can exploit this repetition to determine the key.  To achieve A-level functionality, you'll have to use this technique to decrypt a message without knowledge of the key.

### Required Functionality

- The encrypted and decrypted message will be in memory locations.  The encrypted message and key will be stored in ROM - any location in ROM is acceptable.  The message will be of arbitrary length, but the key will be one byte long.  The decrypted message will be stored in RAM starting at 0x0200.  Labels shall be used to to refer to the location of the encrypted message, decrypted message, and key.
- The key and encrypted message will be given to you.  The final decrypted byte of every message is `0x23`, the ASCII `#` character.
- Good coding standards, in accordance with the [Lab guidelines](/admin/labs.html), must be used throughout.

Encrypted Message:  
```
0x86,0x86,0x86,0x86,0x86,0xef,0xc3,0xc2
0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8
0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5
0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5
0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,0xc9
0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c
0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1
0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd
0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9
0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9
0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2
0xcf,0xd8,0xc5,0xc3,0xc2,0xcd,0xc0,0xc5
0xd8,0xd5,0x8d,0x86,0x86,0x86,0x86,0x86
0x8f
```

Key: `0xac`

Your decryptor will be tested with various combinations of encrypted messages and keys.  Results will be verified using the debugger.

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
0x86,0xf5,0x09,0x86,0xf5,0x77,0xc4,0xba
0x03,0xc1,0xba,0x50,0xdf,0xbe,0x44,0xc9
0xff,0x48,0xc9,0xa6,0x03,0xc0,0xba,0x4d
0xcb,0xab,0x4b,0x8c,0xb6,0x50,0x8c,0xee
0x15,0x8c,0xbd,0x4a,0xd8,0xac,0x0d,0x8c
0xff,0x6a,0xd8,0xff,0x4a,0xdf,0xff,0x42
0xc2,0xff,0x66,0xc2,0xb8,0x4f,0xc5,0xac
0x4b,0x8c,0xac,0x46,0xc2,0xab,0x46,0xc2
0xbc,0x46,0x82,0xf5,0x09,0x86,0xf5,0x09
0x8f
```

Key: `0xacdf23`

Successfully decrypting this message will give you useful information to solve the Bonus Challenge.

### Bonus Challenge

In addition to A Functionality, you must decrypt the following message without knowledge of its key:

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

Think about how you'll implement your subroutines.  Draw a flowchart of how it will operate - include pseudocode, as well as the interfaces to your subroutines (which registers contain inputs, which registers contain ouputs, etc.).

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/ECE382/notes/labs.html) thoroughly and follow it.

The MCU is fast - your program should execute almost instantaneously.  Set a breakpoint at the point in your code where you trap the CPU - if it isn't hit quickly, you've got a problem.

In CCS, it's possible to view memory as Characters - this will be helpful in determining whether you successfully decrypted a message.

Since decryption and encryption are the same operation, you can encrypt test messages using the same subroutines you'll use to decrypt them.  This would be a great way to test functionality of your code.

Use assembler directives for placing strings / byte sequences in memory:
```
stringLabel     .string     "This is a string!"
byteLabel       .byte       0xab,0xcd,0xef
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

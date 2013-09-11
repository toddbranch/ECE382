# Lab 2 - Program Template

```
;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
 
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer
 
;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------
 
            ;
            ; load registers with necessary info for decryptMessage here
            ;

            call    #decryptMessage

forever:    jmp     forever
 
;-------------------------------------------------------------------------------
                                            ; Subroutines
;-------------------------------------------------------------------------------

;---------------------------------------------------
;Subroutine Name: decryptMessage
;Author: 
;Function: Decrypts a string of bytes and stores the result in memory.  Accepts the address of the encrypted message, 
;           address of the key, and address of the decrypted message (pass-by-reference).  Accepts the length of the 
;           message by value.  Uses the decryptCharacter subroutine to decrypt each byte of the message.  Stores the
;           results to the decrypted message location.
;Inputs: 
;Outputs: 
;Registers destroyed: 
;---------------------------------------------------

decryptMessage:

            ret

;---------------------------------------------------
;Subroutine Name: decryptCharacter
;Author: 
;Function: Decrypts a byte of data by XORing it with a key byte.  Returns the decrypted byte in the same register the 
;           encrypted byte was passed in.  Expects both the encrypted data and key to be passed by value.
;Inputs: 
;Outputs: 
;Registers destroyed: 
;---------------------------------------------------

decryptCharacter:

            ret

;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect    .stack
 
;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
```

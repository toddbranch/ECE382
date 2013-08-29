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
	mov.w #0x801, &0x0216		; moves the starting value in memory location 0x0216
	cmp  #0x1234, &0x0216		; compares the value 0X1234 to the value stored in 0x0216
	mov.w #0x14, r5				; moves the value 0x14 to r5


	jeq notgreater				; if the value in 0x0216 is 0x1234 then ti goes to the loop 'notgreater'
	jhs	greater					; the value in 0x0216 is greater than 0x1234 and goes to the loop 'greater'
	jmp notgreater				; goes to the loop 'notgreater'

greater:
 	add.w r5, &0x0216			; adds the value in r5 to the value in 0x0206
 	dec r5						; decrements the value in r5 by one
 	jnz greater					; if the zero flag is not set than go to the start of the loop 'greater'
	mov.w &0x0216, &0x0206		; moves the value from 0x0216 to 0x0206
	jmp forever                 ; jumps to the forever loop

notgreater:
	cmp #0x1000, &0x0216		; compares the value 0x1000 to the value stored in 0x0216
	jhs greater1				; the value in 0x0216 is greater than 0x1000 and goes to the loop 'greater1'
	jmp other					; goes to the loop other


greater1:
	add.w #0xEEC0, &0x0216		; adds the value 0xEEC0 to the value in 0x0216
	jnc nocarry					; if the carry flag is set to zero then go to the 'nocarry' loop
	jc carry					; if the carry flag is set to one then go to the 'carry' loop
nocarry:
	mov.w #0, &0x0202			; moves the value 0 to the 0x0202
	jmp forever					; jumps to the forever loop
carry:
	mov.w #01, &0x0202			; moves the value 1 to the 0x0202
	jmp forever					; jumps to the forever loop

other:
	bit #1b, &0x0216			; checks the value of the last bit in 0x0216
	jeq divide					; if the zero flag is 1 go to the 'divide' loop
	jne multiply				; if the zero flag is 0 go to the 'multiply' loop


divide:
	rrc &0x0216					; divide the value in 0x0216 by 2
	mov.w &0x0216, &0x0212		; move the new value into 0x0212
	jmp forever					; jumps to the forever loop
multiply:
	rla &0x0216					; multiply the value in 0x0216 by 2
	mov.w &0x0216, &0x0212		; move the new value into 0x0212
	jmp forever					; jumps to the forever loop
forever:
	jmp forever					; traps the CPU



;-------------------------------------------------------------------------------


;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
```

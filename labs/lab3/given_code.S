#include <msp430.h>

.data
LCDDATA:                                                            ; holder of four bits to send LCD
    .space  1
LCDSEND:                                                            ; holder of eight bits to send LCD
    .space  1
LCDCON:                                                             ; LCD control bits upper byte: E=0x80, RS=0x40, WR=0x20
    .space  1                                                               

.text
main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL
    ;initialize stack
    mov     #0x0400, r1
    ;code

    call    #INITSPI

    ; LCD Initialization - you'll know it works when your LCD goes blank
    call    #LCDINIT

forever:
    jmp     forever

; Initializes the SPI subsytem.
;
INITSPI:

    ; your SPI initialization code goes here

    ret

; Sets your slave select to high (disabled)
;
SET_SS_HI:

    ; your set SS high code goes here

    ret

; Sets your slave select to low (enabled)
;
SET_SS_LO:

    ; your set SS low code goes here

    ret


; Implements a 40.5 microsecond delay
;
LCDDELAY1:

    ; your 40.5 microsecond delay code goes here

    ret

; Implements a 1.65 millisecond delay
;
LCDDELAY2:

    ; your 1.65 millisecond delay code goes here

    ret

;---------------------------------------------------
; Subroutine Name: LCDCLR
; Author: Capt Todd Branchflower, USAF
; Function: Clears LCD, sets cursor to home
; Inputs: none
; Outputs: none
; Registers destroyed: none
; Subroutines used: LCDWRT8, LCDDELAY1, LCDDELAY2
;---------------------------------------------------
LCDCLR:
    mov.b   #0, &LCDCON                                             ; clear RS
    mov.b   #1, &LCDSEND                                            ; send clear
    call    #LCDWRT8
    call    #LCDDELAY1
    mov.b   #0x40, &LCDCON                                          ; set RS
    call    #LCDDELAY2

    ret

;---------------------------------------------------
; Subroutine Name: LCDINIT
; Author: Capt Todd Branchflower, USAF
; Function: Initializes the LCD on the Geek Box
; Inputs: none
; Outputs: none
; Registers destroyed: none
; Subroutines used: LCDWRT4, LCDWRT8, LCDDELAY1, LCDDELAY2
;---------------------------------------------------
LCDINIT:
    mov.b   #0, &LCDCON                                             ; initialize control bits

    mov.b   #0x03, &LCDDATA                                         ; function set
    call    #LCDWRT4
    call    #LCDDELAY2    

    mov.b   #0x03, &LCDDATA                                         ; function set
    call    #LCDWRT4
    call    #LCDDELAY1

    mov.b   #0x03, &LCDDATA                                         ; function set
    call    #LCDWRT4
    call    #LCDDELAY1

    mov.b   #0x02, &LCDDATA                                         ; set 4-bit interface
    call    #LCDWRT4
    call    #LCDDELAY1

    mov.b   #0x28, &LCDSEND                                         ; 2 lines, 5x7
    call    #LCDWRT8
    call    #LCDDELAY2    

    mov.b   #0x0C, &LCDSEND                                         ; display on, cursor, blink off
    call    #LCDWRT8
    call    #LCDDELAY2    

    mov.b   #0x01, &LCDSEND                                         ; clear, cursor home
    call    #LCDWRT8
    call    #LCDDELAY1    

    mov.b   #0x06, &LCDSEND                                         ; cursor increment, shift off
    call    #LCDWRT8
    call    #LCDDELAY2    

    mov.b   #0x01, &LCDSEND                                         ; clear, cursor home
    call    #LCDWRT8
    call    #LCDDELAY2    

    mov.b   #0x02, &LCDSEND                                         ; cursor home
    call    #LCDWRT8
    call    #LCDDELAY2    

    mov.b   #0, r5                                                  ; clear register
    call    #SPISEND
    call    #LCDDELAY1

    ret

;---------------------------------------------------
; Subroutine Name: LCDWRT8
; Author: Capt Todd Branchflower, USAF
; Function: Send full byte to LCD
; Inputs: LCDSEND
; Outputs: none
; Registers destroyed: none
; Subroutines used: LCDWRT4
;---------------------------------------------------
LCDWRT8:
    push.w  r5

    mov.b   &LCDSEND, r5                                            ; load full byte
    and.b   #0xf0, r5                                               ; shift in four zeros on the left
    rrc.b   r5
    rrc.b   r5
    rrc.b   r5
    rrc.b   r5
    mov.b   r5, &LCDDATA                                            ; store send data
    call    #LCDWRT4                                                ; write upper nibble
    mov.b   &LCDSEND, r5                                            ; load full byte
    and.b   #0x0f, r5                                               ; clear upper nibble 
    mov.b   r5, &LCDDATA                                        
    call    #LCDWRT4                                                ; write lower nibble

    pop.w   r5
    ret

;---------------------------------------------------
; Subroutine Name: LCDWRT4
; Author: Capt Todd Branchflower, USAF
; Function: Send 4 bits of data to LCD via SPI.
; sets upper four bits to match LCDCON.
; Inputs: LCDCON, LCDDATA
; Outputs: none
; Registers destroyed: none
; Subroutines used: LCDDELAY1
;---------------------------------------------------
LCDWRT4:
    push.w  r5

    mov.b   &LCDDATA, r5                                            ; load data to send
    and.b   #0x0f, r5                                               ; ensure upper half of byte is clear
    bis.b   &LCDCON, r5                                             ; set LCD control nibble
    and.b   #0x7f, r5                                               ; set E low
    call    #SPISEND
    call    #LCDDELAY1
    bis.b   #0x80, r5                                               ; set E high
    call    #SPISEND
    call    #LCDDELAY1
    and.b   #0x7f, r5                                               ; set E low
    call    #SPISEND
    call    #LCDDELAY1

    pop.w   r5
    ret

;---------------------------------------------------
; Subroutine Name: SPISEND
; Author: Capt Todd Branchflower, USAF
; Function: Sends contents of r5 to SPI.
; Waits for Rx flag, clears by reading.
; Sets slave select accordingly.
; Outputs: none
; Registers destroyed: none
; Subroutines used: LCDWRT8, LCDDELAY1, LCDDELAY2
;---------------------------------------------------
; Subroutine: SPISEND
;
; takes byte to send in r5
SPISEND:
    call    #SET_SS_LO

    mov.b   r5, &UCB0TXBUF                                          ; transfer byte

wait: 
    bit.b   #UCB0RXIFG, &IFG2                                       ; wait for transfer completion
    jz      wait

    mov.b   &UCB0RXBUF, r3                                          ; read value to clear flag

    call    #SET_SS_HI

    ret

.section    ".vectors", "a"
.org    0x1e
    .word   main

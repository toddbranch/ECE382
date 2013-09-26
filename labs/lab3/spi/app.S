#include <msp430.h>

.data
LCDDATA:
    .space  1
LCDSEND:
    .space  1
LCDCON:
    .space  1

.text
hello_string:   .string   "hello"
world_string:   .string   "world"

main:
    ;disable watchdog timer
    mov     #WDTPW, r10
    xor     #WDTHOLD, r10
    mov     r10, &WDTCTL
    ;initialize stack
    mov     #0x0400, r1
    ;code


    ; think I should init LCDCON to 0.
    mov.b   #0, &LCDCON

    call    #init_spi

    call    #LCDINIT

    call    #LCDCLR

    ; they should create the init_spi routine, set_SS_high, set_SS_low, and two delay routines

    mov.b   #0, &LCDCON                                             ; clear RS
    mov.b   #0x0F, &LCDSEND
    call    #LCDWRT8
    call    #LCDDELAY1

write:
    mov     #hello_string, r9
    call    #writeString

    call    #GotoLineTwo

    mov     #world_string, r9
    call    #writeString

    bic.b   #BIT1, &P1DIR

    call    #WaitButton

    call    #LCDCLR

    call    #WaitButton

    jmp     write

forever:
    jmp     forever

; Wait For Button Push Subroutine

WaitButton:
    bit.b   #BIT1, &P1IN
    jnz     WaitButton

wait_release:
    bit.b   #BIT1, &P1IN
    jz      wait_release    

    call    #LCDDELAY2

    ret

; Go To Line 2 Subroutine

GotoLineTwo:
    mov.b   #0, &LCDCON                                             ; clear RS
    mov.b   #0xC0, &LCDSEND
    call    #LCDWRT8
    call    #LCDDELAY1

    ret

; Write String Subroutine
; takes in address of string to print in r9
writeString:
getChar:
    mov.b   #0x40, &LCDCON                                          ; set RS
    mov.b   @r9, r8
    tst.b   r8
    jz      done
    call    #writeChar
    inc     r9

    jmp     getChar

done:
    ret

; Write Char Subroutine
; takes in char in r8

writeChar:
    mov.b   r8, &LCDSEND
    call    #LCDWRT8
    call    #LCDDELAY2

    ret

; Initializes the SPI subsytem.
; Doesn't impact any registers
init_spi:
    bis.b   #1,&P1DIR
    call    #SET_SS_HI

    bis.b   #UCSWRST, &UCB0CTL1

    bis.b   #(BIT4+BIT5+BIT6+BIT7), &P1SEL
    bis.b   #(BIT4+BIT5+BIT6+BIT7), &P1SEL2

    bis.b   #(UCCKPH + UCMSB + UCMST + UCSYNC), &UCB0CTL0
    
    bis.b   #UCSSEL_2, &UCB0CTL1

    bic.b   #UCSWRST, &UCB0CTL1
    ret

; Subroutine: SET_SS_HI
SET_SS_HI:
    bis.b   #1, &P1OUT

    ret
; Subroutine: SET_SS_LO
SET_SS_LO:
    bic.b   #1, &P1OUT

    ret


; Subroutine: LCDDELAY1
;
; 40.5 microsecond delay
; actually about 42.4 microsecond delay
LCDDELAY1:
    push.w  r5

    mov.w   #9, r5              ;9 for 42.4 us
continue_delay1:
    dec     r5
    jnz     continue_delay1

    pop.w   r5 
    ret

; Subroutine: LCDDELAY2
; 1.65 millisecond delay
; actually 1.6754 millisecond delay
LCDDELAY2:
    push.w  r5
    mov.w   #41, r5
continue_delay2:
    call    #LCDDELAY1
    dec     r5
    jnz     continue_delay2
     
    pop.w   r5 
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
    push    r4

    call    #SET_SS_LO

    mov.b   r5, &UCB0TXBUF                                          ; transfer byte

wait: 
    bit.b   #UCB0RXIFG, &IFG2                                       ; wait for transfer completion
    jz      wait

    mov.b   &UCB0RXBUF, r4                                          ; read value to clear flag

    call    #SET_SS_HI

    pop     r4
    ret

.section    ".vectors", "a"
.org    0x1e
    .word   main

;-------------------------------------------------------------------------------
;	Chris Coulston
;	Fall 2014
;	MSP430G2553
;	Put some pixels on the Nokia 1202 Diaplsy
;-------------------------------------------------------------------------------
	.cdecls C,LIST,"msp430.h"		; BOILERPLATE	Include device header file


LCD1202_SCLK_PIN:				.equ	20h		; P1.5
LCD1202_MOSI_PIN: 				.equ	80h		; P1.7
LCD1202_CS_PIN:					.equ	01h		; P1.0
LCD1202_BACKLIGHT_PIN:			.equ	10h
LCD1202_RESET_PIN:				.equ	01h
NOKIA_CMD:						.equ	00h
NOKIA_DATA:						.equ	01h

STE2007_RESET:					.equ	0xE2
STE2007_DISPLAYALLPOINTSOFF:	.equ	0xA4
STE2007_POWERCONTROL:			.equ	0x28
STE2007_POWERCTRL_ALL_ON:		.equ	0x07
STE2007_DISPLAYNORMAL:			.equ	0xA6
STE2007_DISPLAYON:				.equ	0xAF

 	.text								; BOILERPLATE	Assemble into program memory
	.retain								; BOILERPLATE	Override ELF conditional linking and retain current section
	.retainrefs							; BOILERPLATE	Retain any sections that have references to current section
	.global init
	.global initNokia
	.global clearDisplay
	.global drawBlock


;-------------------------------------------------------------------------------
;	Name:		initNokia		68(rows)x92(columns)
;	Inputs:		none
;	Outputs:	none
;	Purpose:	Reset and initialize the Nokia Display
;-------------------------------------------------------------------------------
initNokia:

	push	R12
	push	R13

	bis.b	#LCD1202_CS_PIN, &P1OUT

	; This loop creates a nice 20mS delay for the reset low pulse
	bic.b	#LCD1202_RESET_PIN, &P2OUT
	mov		#04FFh, R12
delayNokiaResetLow:
	dec		R12
	jne		delayNokiaResetLow
	bis.b	#LCD1202_RESET_PIN, &P2OUT

	; This loop creates a nice 20mS delay for the reset high pulse
	mov		#04FFh, R12
delayNokiaResetHigh:
	dec		R12
	jne		delayNokiaResetHigh
	bic.b	#LCD1202_CS_PIN, &P1OUT

	; First write seems to come out a bit garbled - not sure cause
	; but it can't hurt to write a reset command twice
	mov		#NOKIA_CMD, R12
	mov		#STE2007_RESET, R13
	call	#writeNokiaByte


	mov		#NOKIA_CMD, R12
	mov		#STE2007_RESET, R13
	call	#writeNokiaByte

	mov		#NOKIA_CMD, R12
	mov		#STE2007_DISPLAYALLPOINTSOFF, R13
	call	#writeNokiaByte

	mov		#NOKIA_CMD, R12
	mov		#STE2007_POWERCONTROL | STE2007_POWERCTRL_ALL_ON, R13
	call	#writeNokiaByte

	mov		#NOKIA_CMD, R12
	mov		#STE2007_DISPLAYNORMAL, R13
	call	#writeNokiaByte

	mov		#NOKIA_CMD, R12
	mov		#STE2007_DISPLAYON, R13
	call	#writeNokiaByte

	pop		R13
	pop		R12

	ret

;-------------------------------------------------------------------------------
;	Name:		init
;	Inputs:		none
;	Outputs:	none
;	Purpose:	Setup the MSP430 to operate the Nokia 1202 Display
;-------------------------------------------------------------------------------
init:
	mov.b	#CALBC1_8MHZ, &BCSCTL1				; Setup fast clock
	mov.b	#CALDCO_8MHZ, &DCOCTL

	bis.w	#TASSEL_1 | MC_2, &TACTL
	bic.w	#TAIFG, &TACTL

	mov.b	#LCD1202_CS_PIN|LCD1202_BACKLIGHT_PIN|LCD1202_SCLK_PIN|LCD1202_MOSI_PIN, &P1OUT
	mov.b	#LCD1202_CS_PIN|LCD1202_BACKLIGHT_PIN|LCD1202_SCLK_PIN|LCD1202_MOSI_PIN, &P1DIR
	mov.b	#LCD1202_RESET_PIN, &P2OUT
	mov.b	#LCD1202_RESET_PIN, &P2DIR
	bis.b	#LCD1202_SCLK_PIN|LCD1202_MOSI_PIN, &P1SEL			; Select Secondary peripheral module function
	bis.b	#LCD1202_SCLK_PIN|LCD1202_MOSI_PIN, &P1SEL2			; by setting P1SEL and P1SEL2 = 1

	bis.b	#UCCKPH|UCMSB|UCMST|UCSYNC, &UCB0CTL0				; 3-pin, 8-bit SPI master
	bis.b	#UCSSEL_2, &UCB0CTL1								; SMCLK
	mov.b	#0x01, &UCB0BR0 									; 1:1
	mov.b	#0x00, &UCB0BR1
	bic.b	#UCSWRST, &UCB0CTL1

	; Buttons on the Nokia 1202
	;	S1		P2.1		Right
	;	S2		P2.2		Left
	;	S3		P2.3		Aux
	;	S4		P2.4		Bottom
	;	S5		P2.5		Up
	;
	;	7 6 5 4 3 2 1 0
	;	0 0 1 1 1 1 1 0		0x3E

	bis.b	#0x3E, &P2REN					; Pullup/Pulldown Resistor Enabled on P2.1 - P2.5
	bis.b	#0x3E, &P2OUT					; Assert output to pull-ups pin P2.1 - P2.5
	bic.b	#0x3E, &P2DIR

	ret


;-------------------------------------------------------------------------------
;	Name:		writeNokiaByte
;	Inputs:		R12 selects between (1) Data or (0) Command string
;				R13 the data or command byte
;	Outputs:	none
;	Purpose:	Write a command or data byte to the display using 9-bit format
;-------------------------------------------------------------------------------
writeNokiaByte:

	push	R12
	push	R13

	bic.b	#LCD1202_CS_PIN, &P1OUT							; LCD1202_SELECT
	bic.b	#LCD1202_SCLK_PIN | LCD1202_MOSI_PIN, &P1SEL	; Enable I/O function by clearing
	bic.b	#LCD1202_SCLK_PIN | LCD1202_MOSI_PIN, &P1SEL2	; LCD1202_DISABLE_HARDWARE_SPI;

	bit.b	#01h, R12
	jeq		cmd

	bis.b	#LCD1202_MOSI_PIN, &P1OUT						; LCD1202_MOSI_LO
	jmp		clock

cmd:
	bic.b	#LCD1202_MOSI_PIN, &P1OUT						; LCD1202_MOSI_HIGH

clock:
	bis.b	#LCD1202_SCLK_PIN, &P1OUT						; LCD1202_CLOCK		positive edge
	nop
	bic.b	#LCD1202_SCLK_PIN, &P1OUT						;					negative edge

	bis.b	#LCD1202_SCLK_PIN | LCD1202_MOSI_PIN, &P1SEL	; LCD1202_ENABLE_HARDWARE_SPI;
	bis.b	#LCD1202_SCLK_PIN | LCD1202_MOSI_PIN, &P1SEL2	;

	mov.b	R13, UCB0TXBUF

pollSPI:
	bit.b	#UCBUSY, &UCB0STAT
	jz		pollSPI											; while (UCB0STAT & UCBUSY);

	bis.b	#LCD1202_CS_PIN, &P1OUT							; LCD1202_DESELECT

	pop		R13
	pop		R12

	ret


;-------------------------------------------------------------------------------
;	Name:		clearDisplay
;	Inputs:		none
;	Outputs:	none
;	Purpose:	Writes 0x360 blank 8-bit columns to the Nokia display
;-------------------------------------------------------------------------------
clearDisplay:
	push	R11
	push	R12
	push	R13

	mov.w	#0x00, R12			; set display address to 0,0
	mov.w	#0x00, R13
	call	#setAddress

	mov.w	#0x01, R12			; write a "clear" set of pixels
	mov.w	#0x00, R13			; to every byt on the display

	mov.w	#0x360, R11			; loop counter
clearLoop:
	call	#writeNokiaByte
	dec.w	R11
	jnz		clearLoop

	mov.w	#0x00, R12			; set display address to 0,0
	mov.w	#0x00, R13
	call	#setAddress

	pop		R13
	pop		R12
	pop		R11

	ret

;-------------------------------------------------------------------------------
;	Name:		setAddress
;	Inputs:		R12		row
;				R13		col
;	Outputs:	none
;	Purpose:	Sets the cursor address on the 9 row x 96 column display
;-------------------------------------------------------------------------------
setAddress:
	push	R12
	push	R13

	; Since there are only 9 rows on the 1202, we can select the row in 4-bits
	mov.w	R12, R13			; Write a command, setup call to
	mov.w	#0x00, R12
	and.w	#0x0F, R13			; mask out any weird upper nibble bits and
	bis.w	#0xB0, R13			; mask in "B0" as the prefix for a page address
	call	#writeNokiaByte

	; Since there are only 96 columns on the 1202, we need 2 sets of 4-bits
	mov.w	#0x00, R12
	pop		R13					; make a copy of the column address in R13 from the stack
	push	R13
	rra.w	R13					; shift right 4 bits
	rra.w	R13
	rra.w	R13
	rra.w	R13
	and.w	#0x0F, R13			; mask out upper nibble
	bis.w	#0x10, R13			; 10 is the prefix for a upper column address
	call	#writeNokiaByte

	mov.w	#0x00, R12			; Write a command, setup call to
	pop		R13					; make a copy of the top of the stack
	push	R13
	and.w	#0x0F, R13
	call	#writeNokiaByte

	pop		R13
	pop		R12

	ret


;-------------------------------------------------------------------------------
;	Name:		reDrawDisplay
;	Inputs:		R12 pointer to array[12] containing heights of bars
;	Outputs:	none
;	Purpose:	redraw the entire 96x68 display with 12 vertical bars, the
;				bar in column i has height 8xheight[i] pixels and is 8-bits
;				wide.  The bottom 4 pixels of each bar column are intentionally
;				left blank.  This space could be used for a blinking indicator
;	Registers:	R5	column counter
;				R6	row counter
;-------------------------------------------------------------------------------
reDrawDisplay:
		push	R5				; column counter
		push	R6
		push	R7
		push	R12				; row to draw the block		[0-7
		push	R13				; column to draw the block	[0-11]

		call	#clearDisplay	; start with a blank screen and then overlay bars

		; Since I have set the height array to a bunch of illegal values
		; causing this routine to crash, I thought that it would be a good
		; idea to test the array and saturate any illegal values to safe
		; values bounded by [0-7].
		mov		R12, R5			; R5 is now a tmp pointer to the height array
		mov.w	#11, R6			; loop count var
chkLowerDD:
		mov.b	@R5, R7
		cmp.b	#0,R7
		jhs		chkUpperDD
		mov.b	#0,0(R5)

chkUpperDD:
		cmp.b	#8,R7
		jlo		chkNextDD
		mov.b	#7,0(R5)

chkNextDD:
		inc		R5
		dec		R6
		jge		chkLowerDD

		mov		R12, R5			; copy the height array pointer so that we can call drawBlock
		clr		R13				; Draw columns (indexed by R13 in drawBlock) from left to right on the display

colDD:							; For each column, draw blocks from bottom to top
		clr.w	R6
		mov.b	@R5, R6			; load height[R5] into R6

rowDD:
		mov		R6, R12			; mov the decrementing height into R12
		inv.w	R12				; flip the bits and add one so that the negative can be
		inc.w	R12				; added to 7 to form the complement allowing the
		add.w	#7, R12			; blocks to be draw from bottom to top

		call	#drawBlock		; R12=row, R13=column
		dec		R6				; draw the next lower block - since we allow the
		jge		rowDD			; R6 to equal zero

nextDD:
		; you are now back into the outer loop of colDD
		inc		R5				; point to the next element in heightArray
		inc		R13				; prepare to start drawing the next column
		cmp		#12, R13		; check if we have drawn all 12 columns (if we are done)
		jnz		colDD

		pop		R13
		pop		R12
		pop		R7
		pop		R6
		pop		R5

		ret						; bye-bye


;-------------------------------------------------------------------------------
;	Name:		drawBlock
;	Inputs:		R12 row to draw block
;				R13	column to draw block
;	Outputs:	none
;	Purpose:	draw an 8x8 block of black pixels at screeen cordinates	8*row,8*col
;				The display screen, for the purposes of this routine, is divided
;				into 8x8 blocks.  Consequently the codinate system, for the purposes
;				of this routine, start in the upper left of the screen @ (0,0) and
;				end @ (11,7) in the lower right of the display.
;	Registers:	R5	column counter to draw all 8 pixel columns
;-------------------------------------------------------------------------------
drawBlock:
	push	R5
	push	R12
	push	R13

	rla.w	R13					; the column address needs multiplied
	rla.w	R13					; by 8in order to convert it into a
	rla.w	R13					; pixel address.
	call	#setAddress			; move cursor to upper left corner of block

	mov		#1, R12
	mov		#0xFF, R13
	mov.w	#0x08, R5			; loop all 8 pixel columns
loopdB:
	call	#writeNokiaByte		; draw the pixels
	dec.w	R5
	jnz		loopdB

	pop		R13
	pop		R12
	pop		R5

	ret							; return whence you came

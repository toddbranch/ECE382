factorial:
	push	r4
	mov	r1, r4
	add	#2, r4
	sub	#2, r1
	mov	r15, -4(r4)
	cmp	#0, -4(r4)
	jeq	.L2
	cmp	#1, -4(r4)
	jne	.L3
.L2:
	mov	#1, r15
	jmp	.L4
.L3:
	mov	-4(r4), r15
	add	#llo(-1), r15
	call	#factorial
	mov	-4(r4), r14
	call	#__mulhi3
.L4:
	add	#2, r1
	pop	r4
	ret
main:
	mov	r1, r4
	add	#2, r4
	add	#llo(-40), r1
	mov	#5, r15
	call	#factorial
	mov	r15, -42(r4)
	mov	#9, r15
	call	#factorial
	mov	r15, -4(r4)
	mov	#0, r15
	add	#40, r1

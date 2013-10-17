	.file	"main.c"
	.cpu 430
	.mpy none

	.section	.init9,"ax",@progbits
	.p2align 1,0
.global	main
	.type	main,@function
/***********************
 * Function `main' 
 ***********************/
main:
	mov	r1, r4
	add	#2, r4
	sub	#2, r1
	mov	#10, -4(r4)
	mov	-4(r4), r15
	call	#recursiveSummation
	mov	r15, -4(r4)
	add	#2, r1
.LIRD0:
.Lfe1:
	.size	main,.Lfe1-main
;; End of function 

	.text
	.p2align 1,0
.global	recursiveSummation
	.type	recursiveSummation,@function
/***********************
 * Function `recursiveSummation' 
 ***********************/
recursiveSummation:
	push	r4
	mov	r1, r4
	add	#2, r4
	sub	#2, r1
	mov	r15, -4(r4)
	cmp	#1, -4(r4)
	jge	.L3
	mov	#0, r15
	jmp	.L4
.L3:
	mov	-4(r4), r15
	add	#llo(-1), r15
	call	#recursiveSummation
	add	-4(r4), r15
.L4:
	add	#2, r1
	pop	r4
	ret
.Lfe2:
	.size	recursiveSummation,.Lfe2-recursiveSummation
;; End of function 


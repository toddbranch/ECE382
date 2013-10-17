	.file	"main1.c"
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
	add	#llo(-6), r1
	mov	#2007, -8(r4)
	mov	#100, -6(r4)
	mov	#200, -4(r4)
	add	#6, r1
.LIRD0:
.Lfe1:
	.size	main,.Lfe1-main
;; End of function 


# Lesson Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Electronic Lab Notebook
- Compiler-Generated Code

### The ECE382 Electronic Lab Notebook

[The template is available on my Github](https://github.com/toddbranch/electronic_lab_notebook).

*[Walk through the structure, etc.  Talk about cloning repos, etc.]*

Talk about homework, let them get started if there's time.

## Compiler-Generated Code

The compiler does a bunch of work to make our lives easier.  Normally, this code just sits in the background and goes unnoticed.  But it's important to understand what's going on underneath in case you run into errors or disassemble code and can't figure out where certain pieces are coming from.

Consider a simple piece of code like this:
```
int variable = 10000;

void main(void)
{
}
```

Here is the disassembly of the resulting executable:
```
a.out:     file format elf32-msp430


Disassembly of section .text:

0000c000 <__watchdog_support>:
    c000:	55 42 20 01 	mov.b	&0x0120,r5	
    c004:	35 d0 08 5a 	bis	#23048,	r5	;#0x5a08
    c008:	82 45 02 02 	mov	r5,	&0x0202	

0000c00c <__init_stack>:
    c00c:	31 40 00 04 	mov	#1024,	r1	;#0x0400

0000c010 <__do_copy_data>:
    c010:	3f 40 02 00 	mov	#2,	r15	;#0x0002
    c014:	0f 93       	tst	r15		
    c016:	08 24       	jz	$+18     	;abs 0xc028
    c018:	92 42 02 02 	mov	&0x0202,&0x0120	
    c01c:	20 01 
    c01e:	2f 83       	decd	r15		
    c020:	9f 4f 4e c0 	mov	-16306(r15),512(r15);0xc04e(r15), 0x0200(r15)
    c024:	00 02 
    c026:	f8 23       	jnz	$-14     	;abs 0xc018

0000c028 <__do_clear_bss>:
    c028:	3f 40 00 00 	mov	#0,	r15	;#0x0000
    c02c:	0f 93       	tst	r15		
    c02e:	07 24       	jz	$+16     	;abs 0xc03e
    c030:	92 42 02 02 	mov	&0x0202,&0x0120	
    c034:	20 01 
    c036:	1f 83       	dec	r15		
    c038:	cf 43 02 02 	mov.b	#0,	514(r15);r3 As==00, 0x0202(r15)
    c03c:	f9 23       	jnz	$-12     	;abs 0xc030

0000c03e <main>:
    c03e:	04 41       	mov	r1,	r4	
    c040:	24 53       	incd	r4		

0000c042 <__stop_progExec__>:
    c042:	32 d0 f0 00 	bis	#240,	r2	;#0x00f0
    c046:	fd 3f       	jmp	$-4      	;abs 0xc042

0000c048 <__ctors_end>:
    c048:	30 40 4c c0 	br	#0xc04c	

0000c04c <_unexpected_>:
    c04c:	00 13       	reti			

Disassembly of section .data:

00000200 <__data_start>:
 200:	ef be       	Address 0x0000000000000202 is out of bounds.
bit.b	@r14,	-1(r15)	;0xffff(r15)

Disassembly of section .noinit:

00000202 <__wdt_clear_value>:
	...

Disassembly of section .vectors:

0000ffe0 <__ivtbl_16>:
    ffe0:	48 c0       	bic.b	r0,	r8	
    ffe2:	48 c0       	bic.b	r0,	r8	
    ffe4:	48 c0       	bic.b	r0,	r8	
    ffe6:	48 c0       	bic.b	r0,	r8	
    ffe8:	48 c0       	bic.b	r0,	r8	
    ffea:	48 c0       	bic.b	r0,	r8	
    ffec:	48 c0       	bic.b	r0,	r8	
    ffee:	48 c0       	bic.b	r0,	r8	
    fff0:	48 c0       	bic.b	r0,	r8	
    fff2:	48 c0       	bic.b	r0,	r8	
    fff4:	48 c0       	bic.b	r0,	r8	
    fff6:	48 c0       	bic.b	r0,	r8	
    fff8:	48 c0       	bic.b	r0,	r8	
    fffa:	48 c0       	bic.b	r0,	r8	
    fffc:	48 c0       	bic.b	r0,	r8	
    fffe:	00 c0       	bic	r0,	r0	
```

C allows us to do certain things that don't necessarily make sense in the context of an MCU.  It allows us to initialize variables, for instance.

But RAM can't be flashed.  So how does this work?  The compiler takes all of the variables we want to initialize and copies them to the end of our executable - in flash ROM.  At runtime, before executing our code, it copies all of them into RAM so they're ready to go when we access them.  Here's what it looks like:

## Name That C Construct!

A game I've invented just for ECE382.  I've written code with some common C constructs, compiled it, and have the resulting assembly.  I want you to tell me what C construct created the following assembly code.

```
#include <msp430g2553.h>

void main(void)
{
    int a = 10;

    switch (a) {
        case 5:
            a += 5;
            break;
        case 10:
            a += 10;
            break;
        case 15:
            a += 15;
            break;
        case 20:
            a += 20;
            break;
        default:
            a++;
            break;
    }
}
```

Generated assembly:
```
	.file	"main.c"
	.arch msp430g2553
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
	cmp	#10, r15
	jeq	.L4
	cmp	#11, r15
	jge	.L7
	cmp	#5, r15
	jeq	.L3
	jmp	.L2
.L7:
	cmp	#15, r15
	jeq	.L5
	cmp	#20, r15
	jeq	.L6
	jmp	.L2
.L3:
	add	#5, -4(r4)
	jmp	.L1
.L4:
	add	#10, -4(r4)
	jmp	.L1
.L5:
	add	#15, -4(r4)
	jmp	.L1
.L6:
	add	#20, -4(r4)
	jmp	.L1
.L2:
	add	#1, -4(r4)
	nop
.L1:
	add	#2, r1
.LIRD0:
.Lfe1:
	.size	main,.Lfe1-main
;; End of function 

```

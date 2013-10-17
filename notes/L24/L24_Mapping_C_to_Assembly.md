# Mapping C to Assembly

When I first introduced it, I told you to think of C as a portable, higher-level assembly language.  My intention was to reinforce the connection between the two.  While it's easy to say to yourself that C is compiled into assembly, then assembly is assembled and linked into executable machine code, it's often easy to lose sight of that.  This reading and lesson are designed give you a better understanding of that connection.

Let's start with a simple C program:
```
#include <msp430g2553.h>

void main(void)
{
    int variable = 2007;
}
```

Using msp-gcc (the compiler I use), that C gets compiled into this assembly:
```
; NOTE: I've pulled out the assembler directives to make it clearer

main:
	mov	r1, r4
	add	#2, r4
	sub	#2, r1
	mov	#2007, -4(r4)
	add	#2, r1
```

Let's examine what's going on here.

The first line of code moves r1 (the stack pointer) into r4.  The compiler is using r4 as the **frame pointer**.  When you call a function (main() in this case), all of its local variables are allocated on the stack.  We call the space on the stack used by a function a **stack frame**.  However, the stack pointer changes as you allocate more variables on the stack.  So a variable that was at 4(r1) at one point in your function could later be at 8(r1) if the stack pointer changes.  The frame pointer ensures a consistent address for the same variable throughout the function.  If we store the address of the base of the stack frame in the frame pointer, each variable will always be stored at the same place relative to the frame pointer - so a variable at 4(r4) will always be accessible at 4(r4).

So the first line of code is setting the frame pointer.  Next, the compiler adds 2 to the frame pointer.  In most functions,  the first thing you do is push the frame pointer onto the stack via `push r4` - main is the exception.  Adding two puts the base of the stack frame below this value, which is what we want.

Next, the compiler subtracts two from the stack pointer.  This is because we're allocating our `int variable` on the stack, so we're giving it two bytes.  If we allocated two ints, the compiler would subtract 4 from the stack pointer.

Next, we're moving the value 2007 into the location we've reserved on the stack - this is `int variable` from our code!

After we're done, we'll add 2 to the stack pointer to deallocate `int variable` since we're done using it.

Make sense?  Alright, let's look at something a little more complicated:
```
#include <msp430g2553.h>

int recursiveSummation(int numberToSum);

void main(void)
{
    int numberToSum = 10;

    numberToSum = recursiveSummation(numberToSum);
}

int recursiveSummation(int numberToSum)
{
    if (numberToSum <= 0)
        return 0;
    else 
        return numberToSum + recursiveSummation(numberToSum - 1);
}
```

This is the recursive summation code we covered in the lesson on functions!

Here's the assembly it generates:
```
; NOTE: I've pulled out the assembler directives to make it clearer

main:
	mov	r1, r4
	add	#2, r4
	sub	#2, r1
	mov	#10, -4(r4)
	mov	-4(r4), r15
	call	#recursiveSummation
	mov	r15, -4(r4)
	add	#2, r1

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
	add	#llo(-1), r15               ; llo is a macro to get the least significant word from an expression
	call	#recursiveSummation
	add	-4(r4), r15
.L4:
	add	#2, r1
	pop	r4
	ret
```

Our first four instructions are identical to our original program.  We're setting up the frame pointer and allocating our variable on the stack.

Next, we're moving our variable into r15.  It looks like our Application Binary Interface (ABI) says that the first parameter to a function should be passed in through r15 - so we move our variable into r15.

Next, we call the recursiveSummation subroutine the compiler has created.

Once inside the recursiveSummation subroutine, we push the framePointer onto the stack so we don't destroy it.  Then, we establish a new frame pointer and allocate a variable on the stack - just like we did in main.

Next, the compiler moves the parameter we passed in r15 into the variable we established.  It compares the variable to 1.

If it's greater than or equal to 1, we jump to .L3 - the label that holds the code in our `else` case.  We move our parameter into r15 (the register that holds the first parameter we pass to functions), subtract one, and call our recursiveSummation subroutine again.  This code is the `recursiveSummation(numberToSum - 1)` piece of our code.  The final instruction adds the current parameter to the result passed back in r15.  This code is the `return numberToSum +` piece of our code.

If it's less than 1, we're finished.  We move 0 into r15, deallocate our variable from the stack, retrieve the frame pointer we pushed initially, and return.

If you're interested in learning more, check out [this Wikipedia reading on the Call Stack](http://en.wikipedia.org/wiki/Call_stack).

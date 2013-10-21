# Lesson Notes

## Readings
- [Mapping C to Assembly](L24_Mapping_C_to_Assembly.html)

## Assignment
- [Lab 4 Prelab](/labs/lab4/index.html)

## Lesson Outline
- Admin
- Git In-Class Exercise
- [Lab 4](/labs/lab4/index.html) Overview
- Electronic Lab Notebook
- Working with the C Headers
- Mapping C to Assembly

## Admin

- Lab next time!
- Not getting many Github links from HW!
    - If improved the git tutorial and added the link to the [datasheets page](/datasheets)
    - If you're having trouble, see me for EI - I'm in the lab!
    - Hopefully today's in-class exercise will help with your understanding

To practice the git skills you were introduced to last period, we're going to spend the first 20 minutes of class doing an in-class exercise.  Get your computers out, connected to the internet, and open up Git Bash!

## [Git In-Class Exercise](L24_git_in_class.html)

## [Lab 4](/labs/lab4/index.html) Overview

In this lab, you'll create a library for working with the LCD on the Geek Box - your very first *device driver*.  A good starting point might be the assembly code from Lab 3.  You can port that to C to get it up and running.  But, eventually, I'll expect you to create a reusable LCD library that you can use on future labs (you'll need it for Lab 5).

*[Walk through tiers of functionality.]*

In this and all future labs, I expect your code to be under version control with git throughout development.  I also expect it to be pushed to Github regularly so I can monitor it.  Commit early and often - I will look at your commit history!

*[Walk through prelab expectations.]*

I've provided my header as an example of an interface that I think is straightforward to work with.  I recommend designing your API (defined in header) before implementing your code!  You want to design an API that's convenient to work with!

## The ECE382 Electronic Lab Notebook

I'm open to electronic lab notebooks in this course.  I think git is an interesting way to accomplish this.  If you're interested in using an electronic lab notebook, here's a template I've created:

[Lab Notebook Template](https://github.com/toddbranch/electronic_lab_notebook).

*[Walk through the structure, etc.]*

I'd expect you to document software changes in your commit history.  Any higher level design stuff or hardware design should be included in your report.md.

This is the first time we'd be doing lab notebooks in this way, so you'd be trailblazers here.

I'd recommend you fork this template for each new lab you create.

If you want to continue using a physical lab notebook, that's totally fine as well.

## Working with the C Headers

We haven't really talked about using C with MSP430 subsystems.  In Lab 4, you'll need to combine your knowledge of C with your knowledge of the subsystems we learned about in Block 1 (i.e. SPI, GPIO, etc.) to be successful.

The headers we used with our assembly code are the same ones we'll use for C.  The code `#include <msp430.h>` that's included by default in CCS gives you access to the appropriate headers for your platform.

Here's the code we wrote in L13 to turn on the Launchpad lights when we push the button (similar to the final GR1 question):
```
                     bis.b  #BIT0|BIT6, &P1DIR
                     bic.b  #BIT3, &P1DIR
                     bis.b  #BIT3, &P1REN
                     bis.b  #BIT3, &P1OUT
 
check_btn:    bit.b  #BIT3, &P1IN
                     jz            set_lights
                     bic.b  #BIT0|BIT6, &P1OUT
                     jmp           check_btn
set_lights:   bis.b  #BIT0|BIT6, &P1OUT
                     jmp           check_btn
```

Let's port it to C:
```
#include <msp430g2553.h>

#define TRUE 1

void main(void)
{
    P1DIR |= BIT0|BIT6;
    P1DIR &= ~BIT3;
    P1REN |= BIT3;
    P1OUT |= BIT3;

    while (TRUE)
    {
        if (P1IN & BIT3)
            P1OUT &= ~(BIT0|BIT6);
        else
            P1OUT |= BIT0|BIT6;
    }
}
```

We talked about it in one of the early C lessons, but I want to emphasize it here: notice how we do bit-wise manipulation in C.

`bis` is performed by `|=` - or is the operation for setting bits.  `bic` is performed by `&= ~` - and not is the operator for clearing bits.

## Mapping C to Assembly

Who read?  You better have because I wrote this thing myself!

*[Walk through examples from reading]*

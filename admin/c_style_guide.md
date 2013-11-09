title = 'C Style Guide'

# C Style Guide

## General Guidelines

- Minimize use of global variables
- Main should be the first function implemented in `main.c`
	- Function prototypes used in main should be declared above main, but implemented below it
- Treat warnings as errors - fix them!
- Choose readability over brevity!
- Well-written code doesn't require many comments
- Don't comment bad code, rewrite it!
- If you find yourself writing the same code more than once, create a function!

## General Style

Don't comment bad code, rewrite it!

Use whitespace to group code logically:

```c

```

Use functions to make code more readable:

```c
// bad
if ((employeeAge >= 65) && (yearsOfService >= 10) && (isFullTime == TRUE))
{
	// confer benefits
}

// good
if (isEmployeeEligibleForBenefits())
{
	// confer benefits
}

char isEmployeeEligibleForBenefits()
{
	return (employeeAge >= 65) && (yearsOfService >= 10) && (isFullTime == TRUE);
}
```

## Common Warnings / Errors

- Implicit function declaration
	- You're using a function without a prototype
	- You're misspelling a function
- Interrupt vector will not fit in available memory
	- You're trying to put two things into the interrupt vector - delete one of them!
- Duplicate declaration
	- You're declaring the same variable / function in multiple files
- Couldn't resolve symbol
	- You're spelling the name of something wrong
	- You're referencing a variable that doesn't exist
	- You're referencing a function you haven't implemented

## The Right Tool for the Job

Use for loops where they make sense:

```c
// bad
int i = 0;
while (i < 10)
{
	// do iterative task
	i++;
}

// good
int i;
for (i = 0; i < 10; i++)
{
	// do iterative task
}
```

Use switch statements where they make sense:

```c
// bad
if (direction == UP)
{
	// move player up
} else if (direction == DOWN)
{
  // move player down
}

// good
switch (direction)
{
	case UP:
		// move player up
		break;
	case DOWN:
		// move player down
		break;
}
```


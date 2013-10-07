# L20 Assignment - Your First C Program

## A Simple C Program

Write a C program that does the following:

- Creates three unsigned chars (val1, val2, val3).  Initializes them to 0x40, 0x35, and 0x42.
- Creates three unsigned chars (result1, result2, result3).  Initializes them to 0.
- Checks each number against a threshold value of 0x55.
- If val1 is greater than the threshold value, stores the [10th Fibonacci number](http://en.wikipedia.org/wiki/Fibonacci_number) in result1 by using a for loop.
- If val2 is greater than the threshold value, stores 0xAF to result2.
- If val3 is greater than the threshold value, subtracts 0x10 from val2 and stores the result into result3.

Additional Requirements:

- The threshold value must be a properly defined constant (refer to the lesson notes if you are confused by this requirement).
- Comment your code.  In particular, provide a good file header (example provided in lesson notes).

## Turn-In Requirements (E-mail)

- Main source code file (`main.c`).
- Debugger screenshots to prove to the instructor that your code functions correctly.
- Answers to the following questions:
    - Exactly where in memory on the microcontroller are your variables stored?
    - How do you know?

## Hints

**How to create a C project in CCS**

You'll create the project the same way you create an assembly project, but under "Project templates and examples" you'll select "Empty project (with main.c)".  The shortcut to build is still `Ctrl+B`.  The shortcut to debug is still `F11`.

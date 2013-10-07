# L20 Assignment - Your First C Program

## A Simple C Program

Write a C program that does the following:

- Creates three unsigned chars (val1, val2, val3).  Initializes them to 0x40, 0x35, and 0x42.
- Creates three unsigned chars (result1, result2, result3).  Initializes them to 0.
- Checks each number against a threshold value of 0x38.
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

**Compiler Optimization Issue**

There's a good chance you'll run into a warning that says "variable XXXX was set but never used".

The compiler is seeing that you've created a variable and potentially set it to different values, but never tested the value or assigned it to another variable.  As far as the compiler is concerned, this code is useless - and it will delete it upon compilation.  It views this as an improvement - your program now does the same thing with less code.

Usually, this is the behavior we want.  In learning situations like this, we want to keep the compiler from making these sorts of optimizations.  There are two ways we can accomplish this.

1)  Prevent the compiler from optimizing anything: Go to Project -> Properties -> Build -> MSP430 Compiler -> Optimization and turn Optimization level to off.
2)  Tell the compiler not to optimize a varable.  We can do this by adding the `volatile` modifier to the variables it's optimizing out.  This tells the compiler that this varibale could be modified outside of the given code and not to optimize it away.

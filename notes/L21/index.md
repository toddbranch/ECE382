# Lesson 21 Notes

## Readings
- <a href="http://en.wikipedia.org/wiki/Struct_(C_programming_language)">structs</a>
- [MOTIVATIONAL: Self-assembling Robots](http://web.mit.edu/newsoffice/2013/simple-scheme-for-self-assembling-robots-1004.html)

## Assignment
- [Assignment - Pong!](/notes/L21/L21_pong.html)

## Lesson Outline
- Structs
- Functions
- Headers
- Example

## Structs

- Collection of multiple variables
- Can be of different types
- Similar to an OOP object, but only contains data (no methods)

*[Open up VIM, code to demo this]*

General case:
```
struct <name>
{
    <type> <var1>;
    <type> <var2>;
    ...
};

struct <name> <variable_name>;
<variable_name>.<var1> = <value>;
<variable_name>.<var2> = <value>;

```

Example:
```
struct point {
    unsigned char x,y;
};
struct circle {
    point center;
    char radius;
};

struct point center = {20, 07};
strict circle myCircle = {center, 5};
```

## Functions

### Function Prototype

- Promises the compiler that the function is implemented elsewhere
- You are allowed to "call" the function from your code
- The function prototype *must* be defined in a location physically *before* you call it (e.e. defined above `main()` in a `#include` file).

General case:
```
<output_type> func_name(<input type 1> <variable name 1>, ...);
```

**Note**: function parameters / output can be `void`.

Example:
```
unsigned int summation (unsigned char n);
```

### Function Call

General Case:
```
<variable> func_name(<variable 1>, ...);
```

Example:
```
unsigned int mySummation;
unsigned char maxN = 42;

mySummation = summation(23);
mySummation = summation(maxN);
```

### Function Definition

General Case:
```
<output_type> func_name(<input type 1> <variable name 1>, ...)
{
    // Some interesting stuff
    return <output variable>;
}
```

Example:
```
unsigned int summation(unsigned char n)
{
    // recursion!
    if (n <= 0)
        return 0;
    else
        return n + summation(n-1);
}
```

## Header and Implementation Files

### Preprocessor Commands

The preprocessor is executed before your code compiles.  It handles any lines that start with `#<some_comand> <params>`.  The following are the preprocessor commands you will use:

- `#include "file_name.h"`
    - Essentially a "copy and paste" of the `file_name.h` into your file
    - if the file name is surrounded by ":, the preprocessor will search in your project working directory
    - if the file name is surrounded by <>, the preprocessor will search your class path.
- `#define <SINGLE_WORD> <replacement_token>
    - Essentially a global "search and replace" within your code
    - Anytime the `<SINGLE_WORD>` token appears, it will be replaced by the `<replacement token>`
- `#ifndef <SOME_CONSTANT> ... <some code> .. #endif`
    - Code is only included if `<SOME_CONSTANT>` is not defined
    - Usually, your first line of code will be to `#define <SOME_CONSTANT>`
- **Note**: these lines do not end with a semicolon (;)!

### C Headers

- A separate file that contians a related set of:
    - Function _prototypes_
    - `typedef` declarations
    - `#define` constants
    - etc.
- File naming convention:
    - All lowercase
    - Use "_" to combine words
    - ".h" is the file extension
    - Example: `atd_helper.h`
- You must "wrap" the header in a `#ifndef` to prevent circular inclusions

```
#ifndef _ATD_HELPER_H_
#define _ATD_HELPER_H_

// Your header file code (typedefs, function prototypes, #defines, etc.)
// Use good comment headers to define each function (see example)
// ...

#endif // _ATD_HELPER_H
```

### C Implementation Files

- A separate C file that implements the header file
- Contains the function _definitions_
- `#include` the header file as your first line
- File naming convention:
    - Same name as the header file!
    - ".c" is the file extension
    - Example: `atd_helper.c`

```
#include "atd_helper.h"

// Function definitions
// ...
```

## Example

### Program Requirements

- Build a program that can calculate the following:
    - Summation
    - Factorial
    - Minimum of two values
    - Maximum of two values
    - Provides user helpful mathematic constants
- Must write modular / reusable code:
    - Header file
    - Implementation file
    - `main()` file

### math_helper.h

```
// Your high-quality header wtih aythor / description / revision history
#ifndef _MATH_HELPER_H_
#define _MATH_HELPER_H_

// Usefule mathematic constants
                                (estimate)      (actual)
#define PI  (339 / 108)     //  3.139       vs  3.142
#define E  (155 / 57)       //  2.719       vs  2.718

// Note: you would add some really good headers before each of these
//       functions to describe their purpose.  In the interest of
//       brevity, I'm omitting them here.
unsigned int summation(unsigned char n);
unsigned int factorial(unsigned char n);
char max(char a, char b);
char min(char a, char b);

#endif // _MATH_HELPER_H_
```

### math_helper.c

```
#include "math_helper.h"

unsigned int summation(unsigned char n)
{
    // code here
}

unsigned int factorial(unsigned char n)
{
    // code here
}

char max(char a, char b)
{
    return (a > b) ? a : b;
}

char min(char a, char b)
{
    return (a < b) ? a : b;
}
```

### main.c

```
#include "math_helper.h"

void main(void)
{
    char a = 10;
    char b = 15;
    char maxVar, minVar;
    unsigned int sum, fact;

    sum = summation(a);
    fact = factorial(6);
    maxVar = max(a, b);
    minVar = min(a, b);

    while(1){};                 // trap CPU
}
```

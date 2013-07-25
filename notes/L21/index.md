# Lesson 21 Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Structs
- Functions
- Headers

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

Note: function parameters / output can be `void`.

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
- Note: these lines do not end with a semicolon (;)!

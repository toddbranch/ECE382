# Lesson 22 Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

- [KSplice pointer challenge](https://blogs.oracle.com/ksplice/entry/the_ksplice_pointer_challenge)

## Lesson Outline
- Pointers
- Arrays
- Function Parameters
- Practice

## Pointers

A pointer is a variable that holds a memory address.

### Pointers Overview

| Token | Context | Description |
| :-: | :-: | :-: 
| `&` | Assignment statement | Returns the addresss of the variable after this token |
| `*` | Variable declaration | Variable contains the address pointing to a variable of type `var_type` |
| `*` | Assignment statement | Allows you to access the contents of the variable at which the pointer is pointing |
| `->` | Structure | Access a structure's elements through a structure pointer (instead of the "." notation).  Also can use `(*structure).element`. |

### Pointers Example

```
unsigned char x = 0x25;                 // address of x is 0x1000
unsigned int y = 0x1234;                // address of y is 0x1001 - 0x1002
unsigned char* xPtr = &x;               // address of xPtr is 0x1003 - 0x1004
unsigned char* yPtr = &y;               // address of yPtr is 0x1005 - 0x1006 
```

Questions are independent - variables reset to original state prior to each.

**Question:** What is the value of x and xPtr after the following statements? (remember, MSP430 is little endian)
```
xPtr++;
x = *xPtr + 1; // x = ?
```
**Answer:** x = 0x35

**Question:** What is the value of x and xPtr after the following statement?
```
*xPtr = 0x12;
```
**Answer:** x = 0x12, xPtr unchanged

**Question:** What is the value of y and yPtr after the following statement?
```
y = yPtr + *yPtr;
```
**Answer:** y = 0x2235, yPtr unchanged

## Arrays

- *Array* - a collection of elements of the same data type stored in consecutive memory locations.
    - Index counting starts at 0
    - Max index is `NUM_ELEMENTS` - 1

### Array Declaration

```
<data_type> array_name[NUM_ELEMENTS]; // Uninitialized
<data_type> array_name[] = {val0, val1, ...}; // Initialized
```

`array_name` **decays** into a pointer to the first element in the array

`<data_type>` lets the compiler know how much to "jump" between elements in the array

### Array Element Access

`array_name[INDEX_VAL]`

### Arrays Example

```
unsigned int a[3];                      // address of a[0] is 0x1000, address of a[1] is 0x1002, address of a[2] is 0x1004
unsigned int temp;                      // address of a[3] is 0x1006
unsigned char* cPtr;                    // address of cPtr is 0x1008
a[0] = 0x1234;
a[1] = 0x5678;
a[2] = 0x9ABC;
```

Questions are independent - variables reset to original state prior to each.

**Question:** What is the value of `temp` after each of the following statements?  (remember, the MSP430 is little endian)

```
temp = (unsigned int)a;
temp = (a+1)[0];
```
**Answer:** temp = 0x1000, temp = 0x5678

**Question:** What is the value of `cPtr` and `temp` after the following statements? (remember, the MSP430 is little endian) 

```
cPtr = (unsigned char *)a;
temp = (cPtr+1)[0];
```
**Answer:** cPtr = 0x1000, temp = 0x7812

## Function Parameters

- *Pass by Value* - Passing the actual variable
    - Good choice for small-sized variables
    - Expensive to copy larger variables (e.g. structures, arrays, etc.)
- *Pass by Pointer* - Pass pointer into variable (same as Pass by Reference from assembly block)
    - Constant size parameter no matter how large the object it is to point to
    - Allows you to directly modify the variable in the function without a `return` statement
    - Use the `const` keyword if you do not want the function to modify the contents of the pointer's target

**Pass by Value**

```
char some_function(char a, char b)
{
    return ++a + b;

}
```

**Pass by Pointer**

```
char some_function(char* a, char* b)
{
    return ++(*a) + *b;
}
```

**Question:** What is the value of the actual parameter `a` in the client code after each of these functions are called?  What if we change the second one to `const char* a`?

**Question:** How large (in bytes) are each of the parameters in these two functions?

## Practice

```
char x;                         // Memory location 0x0800 = 0xFF
char y[3];                      // Memory locations: 0x0801 = 0x23, 0x0802 = 0x56, 0x0803 = 0x89
char* letter_ptr;               // Memory locations: 0x0804 - 0x0805 = 0xABDC
```

**Question:** What values would be assigned using the following statements?  Unless otherwise stated, assume each instruction is independent of the other instructions.

```
x = y[2];                       // Part A
letter_ptr = &x;                // Part B
letter_ptr = y;                 // Part C
x = *(letter_ptr + 2);          // Assume Part C
y[2] = *(letter_ptr + 1);       // Assume Part B
```

**Answers**
A - x = 0x89
B - letter_ptr = 0x0800
C - letter_ptr = 0x0801
D - x = 0x89
E - y[2] = 0x56

# Lesson Notes

## Readings
[Reading 1](/path/to/reading)

## Assignment

## Lesson Outline
- Compiler-Generated Code

## Compiler-Generated Code

The compiler does a bunch of work to make our lives easier.  Normally, this code just sits in the background and goes unnoticed.  But it's important to understand what's going on underneath in case you run into errors or disassemble code and can't figure out where certain pieces are coming from.

C allows us to do certain things that don't necessarily make sense in the context of an MCU.  It allows us to initialize variables, for instance.

```
int variable = 10000;

void main(void)
{
}
```

But RAM can't be flashed.  So how does this work?  The compiler takes all of the variables we want to initialize and copies them to the end of our executable - in flash ROM.  At runtime, before executing our code, it copies all of them into RAM so they're ready to go when we access them.  Here's what it looks like:
```
```

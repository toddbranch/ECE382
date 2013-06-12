#include <msp430.h>

.text
main:
    bis.b   #0xFF, &P1DIR
    bis.b   #0xFF, &P1OUT

.section    ".vectors", "a"
.org    0x1e
    .word   main

.end

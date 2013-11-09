all: clean main

debug:
	mspdebug rf2500

gdb:
	msp430-gdb main

main:
	msp430-gcc -g -Wall -mmcu=msp430g2553 main.c -o main

clean:
	rm -rf main

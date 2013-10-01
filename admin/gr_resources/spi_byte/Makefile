all:
	msp430-gcc -mmcu=msp430g2553 -Wall -g -Os main.c -o main.elf

debug:
	mspdebug rf2500 "gdb"

dis:
	msp430-objdump -d main.elf > dis	

gdb:
	msp430-gdb

prog:
	mspdebug rf2500 "prog main.elf"

clean:
	rm -f main.elf dis

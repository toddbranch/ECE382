APP=lightLED
MCU=msp430g2553

CC=msp430-gcc
AS=msp430-as
LD=msp430-ld
COMMON=-Wall -v -I.
ASFLAGS += -mmcu=$(MCU) $(COMMON)

assembly:
	$(AS) $(ASFLAGS) $(APP).S -o $(APP).o

dis-obj:
	msp430-objdump -D $(APP).o > dis-obj

dis-elf:
	msp430-objdump -D $(APP).elf > dis-elf

load:
	$(LD) -o $(APP).elf $(APP).o -L /usr/msp430/lib/ldscripts/msp430g2553/ -T /usr/msp430/lib/ldscripts/msp430.x

hex-dump-obj:
	msp430-readelf --hex-dump=.text $(APP).o > dump-obj

hex-dump-elf:
	msp430-readelf --hex-dump=.text $(APP).elf > dump-elf

clean:
	rm -f $(APP).elf $(APP).o 

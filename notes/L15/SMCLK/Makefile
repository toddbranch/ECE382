APP=app
MCU=msp430g2553

AS=msp430-as
LD=msp430-ld
CC=msp430-gcc
COMMON=-Wall -v -I.
ASFLAGS += -mmcu=$(MCU) $(COMMON)
CFLAGS += -mmcu=$(MCU) $(COMMON)
LDFLAGS = -nostartfiles -nostdlib

all:	clean $(APP).elf

$(APP).elf: $(APP).o
	$(CC) $(CFLAGS) $(APP).o $(LDFLAGS) -o $(APP).elf

assembly:
	$(AS) $(ASFLAGS) $(APP).S -o $(APP).o

load:
	$(LD) -o $(APP).elf $(APP).o -L /usr/msp430/lib/ldscripts/msp430g2553/ -T /usr/msp430/lib/ldscripts/msp430.x

dis-obj:
	msp430-objdump -D $(APP).o > dis-obj.lss

dis-elf:
	msp430-objdump -D $(APP).elf > dis-elf.lss

hex-dump-obj:
	msp430-readelf --hex-dump=.text $(APP).o > dump-obj.lss

hex-dump-elf:
	msp430-readelf --hex-dump=.text $(APP).elf > dump-elf.lss

debug:
	mspdebug rf2500 "gdb"

gdb:
	msp430-gdb

no-git:
	rm -rf .git .gitignore README.*

clean:
	rm -f $(APP).elf $(APP).o function.o dis-elf.lss dis-obj.lss dump-obj.lss dump-elf.lss

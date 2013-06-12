APP=sampleProgram
MCU=msp430g2553

CC=msp430-gcc
COMMON=-Wall -Os -I.
CFLAGS	+= -mmcu=$(MCU) $(COMMON)
ASFLAGS += -mmcu=$(MCU) $(COMMON)
LDFLAGS=-nostdlib -nostartfiles

all: $(APP).elf

$(APP).elf: $(APP).o
	$(CC) $(CFLAGS) $(APP).o $(LDFLAGS) -o $(APP).elf

clean:
	rm -f $(APP).elf $(APP).o

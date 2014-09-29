# LCD Notes

## LCD Wiring

The LCD is connected to the project board on J13. See schematic below. The LCD uses a parallel interface (common among LCDs) with an 8-line data bus. Parallel LCDs have the ability to work with either four data lines or all eight. On the project board, the LCD is wired up to use only four data lines, which means only four bits can be transferred in at a time. Note that DB0 through DB3 are tied to ground through 10k resistors. The RS line indicates whether the data on the data bus is a character to be displayed (such as 'A') or a command to be executed (such as CLEAR). The R/W* line allows the LCD's memory to be read, but on the project board, this pin is tied low through R55. Another important signal is the contrast line, which is a variable voltage set by a resistor network or RV1, the on-board potentiometer. The contrast jumper determines which is used.

![LCD Schematic](lcd_schematic.jpg)

The last signal of interest is the EN line, which is a signal to the LCD to read the data on the data bus. Notice that six lines of the LCD are actively used and require data from the MSP430.

In order to reduce the number of pins used for the LCD, the project board uses the SPI ability of the MCU to use only the four SPI pins to communicate with the LCD. However, there needs to be something to convert the serial data from the MSP430 to parallel data the LCD can understand. The schematic shows U5, a 74HC595 Serial Input / Parallel Output Latch. This device takes the serial data from the MSP430 and places it on the LCD parallel interface. The four SPI signals drive the 74HC595. Look at the data sheet for more detail on what signals drive the outputs of this chip.

Questions to Consider:

- On the project board, is the LCD in read or write mode?
- What pins on the LCD driver chip require data from the MSP430?
- How are the four SPI signals used to convert the MSP430 serial data to the parallel data needed by the LCD?

## LCD Protocol

When power is applied, the LCD will display eight rectangles on line 1.  Before the LCD can be used, it must be initialized properly.

You are given code that does 95% of the initialization work for you. However, it is missing a few items to make it work properly. **Do not modify any of the other subroutines provided**. They are intended to save time. The LCD initialization code requires:

1. Two delay functions, called `LCDDELAY1` (40.5 microseconds) and `LCDDELAY2` (1.65 microseconds).
2. Initialization of the Serial Peripheral Interface (SPI) in `INITSPI`.
3. Implementation of `SET_SS_LO` and `SET_SS_HI`.

Think about how you can measure your delay times using general purpose I/O.

Once you attempt to initialize the LCD, you'll know it is properly initialized when the entire display goes blank.

## Sending Data and Commands

Here are a few things to notice about sending data and commands to the display:

1. The code you are given has subroutines for writing data to the LCD (`LCDWRT4`). Notice that bits sent to the LCD must match the hardware configuration described above. For example, the bits sent to the LCD must be EN, RS, two empty bits, then the four data bits. Look at the code given to see how it works.

2. The LCD recognizes the ASCII standard for displaying characters. Under ASCII, each character to be displayed requires eight bits. There is a subroutine (`LCDWRT8`) given to send eight bits as required by the LCD.

3. The LCD has a microcontroller on it with the part number of KS0066U. [Its datasheet is posted on the website](/datasheets/). Look at Table 2 in the datasheet to see how the LCD uses RS, E (called EN on the project board), R/W, and DB0-DB7.

4. Notice that you must control the RS line by what you send to the LCD. `LCDWRT4` takes care of the EN line for you.

5. The display is slow compared to the MSP430.  There are multiple ways of synchronizing communications, but we're going to use the brute force method.  See the [LCD Commands Quick reference guide](/datasheets/). It shows two different time delay requirements, 1.65ms and 40us. We can just wait at least 40us between normal character writes to the display.  For certain commands, use a 1.65 ms delay.

6. The LCD must receive both commands and data.  You must first set the RS line to either high for data or low for commands before sending information to the LCD.

7. You need to set the DD RAM to what address on the LCD you are writing to.  After you set the initial address, an address counter inside the LCD's microcontroller automatically increments.  You don't have to send another address until you want to use the next line.  Figure 3 of the KS0066U datasheet shows the address for each position. Remember you have a two-line, 8 position display. The datasheet also covers larger LCD units.

8. The shift mode is very messy to use unless your message is 8 characters or less.  If you shift a long message, the eighth character 'falls off' the end instead of being shifted into the ninth position.

9. You must use a loop when displaying characters to the LCD.  The loop should read a character from your string and send it to the LCD.

10. Since timing is critical for the functioning of the LCD (and nothing will appear on the LCD if you mess up timing) to help debug/test the timing of your signals you will use the logic analyzer.  You must demonstrate using the logic analyzer the proper timing of your 1.65 ms delay. Instructions for using the logic analyzer will be in a separate handout.

Questions to Consider:

- What do the RS, E, R/W, and DB0-DB7 pins on the LCD do and how do they work?
- When does the LCD read the data on its input pins?

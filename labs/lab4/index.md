title = 'Lab 4 - C - "An LCD Device Driver"'

# Lab 4 - C - "An LCD Device Driver"

[Teaching Notes](notes.html)

## Objectives

You've spent the last 5 lessons transitioning from programming in assembly language to C.  In this lab, you'll use C to write a device driver for the LCD you used in Lab 3.  You'll be expected to write clean, maintainable, modular code that is committed regularly to Git.

## Details

### The Basic Idea

Ever wonder how you plug a mouse into your computer and it "just works"?  That's due in large part to software called a device driver.  Device drivers are low-level software that interface directly with hardware.  In this lab, you'll write a device driver for the LCD in the Geek box.

Unlike Lab 3, you will not be given any code.  The [code from Lab 3](/labs/lab3/given_code.html) will prove useful - but you'll have to port it to C!

The [datasheets](/datasheets) you used in Lab 3, the [Lab 3 documentation](/labs/lab3), and relevant lesson notes will also prove useful.

### Required Functionality

Create an LCD device driver using the C programming language.

Scroll the message "ECE382 is my favorite class!" across the top line of the LCD.  Scroll a message of your choice across the bottom line.

You will want to interface with this LCD again (**in Lab 5**).  I expect you to create a reusable LCD library!  Design a good API in advance - you want this library to be easy to work with in the future.

You must place your code under version control on git and push your repo to Github.

Mind your coding standards!  Commit regularly with descriptive commit messages!

Here are some of my ports of assembly functions to C:
```
#define RS_MASK 0x40

void LCDinit()
{
    writeCommandNibble(0x03);

    writeCommandNibble(0x03);

    writeCommandNibble(0x03);

    writeCommandNibble(0x02);

    writeCommandByte(0x28);

    writeCommandByte(0x0C);

    writeCommandByte(0x01);

    writeCommandByte(0x06);

    writeCommandByte(0x01);

    writeCommandByte(0x02);

    SPI_send(0);
    delayMicro();
}


void LCDclear()
{
    writeCommandByte(1);
}

void writeCommandNibble(char commandNibble)
{
    LCDCON &= ~RS_MASK;
    LCD_write_4(commandNibble);
    delayMilli();
}

void writeCommandByte(char commandByte)
{
    LCDCON &= ~RS_MASK;
    LCD_write_8(commandByte);
    delayMilli();
}

void writeDataByte(char dataByte)
{
    LCDCON |= RS_MASK;
    LCD_write_8(dataByte);
    delayMilli();
}

void LCD_write_8(char byteToSend)
{
    unsigned char sendByte = byteToSend;

    sendByte &= 0xF0;

    sendByte = sendByte >> 4;               // rotate to the right 4 times

    LCD_write_4(sendByte);

    sendByte = byteToSend;

    sendByte &= 0x0F;

    LCD_write_4(sendByte);
}

void SPI_send(char byteToSend)
{
    volatile char readByte;

    set_SS_lo();

    UCB0TXBUF = byteToSend;

    while(!(UCB0RXIFG & IFG2))
    {
        // wait until you've received a byte
    }

    readByte = UCB0RXBUF;

    set_SS_hi();
}
```

The rest, you'll have to do yourself...

### B Functionality

Allow the user to select between three different bottom line messages depending on which button they press.  You are free to write your own button library, or use mine available at https://github.com/toddbranch/buttons .

B Functionality Program operation:

- Screen 1
    - Top Line: Message?
    - Bottom Line: Press123
- Screen 2
    - Top Line (scrolling): ECE382 is my favorite class!
    - Bottom Line (scrolling): *Chosen message*

### A Functionality

Create an additional library for calibrating your clock to different frequencies.

You think your libraries for working with buttons (if you made one), clock calibration, and the LCD could prove useful to other programmers.  You've decided to release them on Github as open source.

You'll need a separate git repository for each of your libraries.  You'll need to create a README for each covering their API and usage.

You must show me each repo successfully hosted on Github to receive credit.

## Prelab

Paste the grading section in your lab notebook as the first page of this lab.

Include whatever information from this lab you think will be useful in creating your program.

Design the API for your LCD library.  [Here is mine as an example.](LCD_h.html)

Consider how you'll port different assembly language constructs in the [Lab 3 template code](/labs/lab3/given_code.html) to C.

Consider how you'll create software delays in C.

If you write any code, an early step should be to get it under version control and push it up to Github (effectively backing it up).

## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/admin/labs.html) thoroughly and follow it.

Mind your code style!

Use git / Github and commit regularly with descriptive commit messages!  This is worth 10pts of your grade!

It might be helpful to start off by porting assembly code directly to C.  But this shouldn't be your final code!  Once you have it working, you should improve its structure using the programming techniques you've learned.

C does not have a strings data type - they are represented as arrays of characters:
```
char * string1 = "this is a string";       // this string is stored in ROM and isn't alterable 
char string2[] = "this is a string";       // this string is stored in RAM and is alterable
```

## Hints

There is a C macro available that makes creating delays much easier.  `__delay_cycles(num_of_cycles)` will delay the specified number of clock cycles with no side effects.

I've implemented string scrolling in two ways - both are equally valid:

- Create a string rotation function that moves the first letter to the end and moves all other characters up
    - `void rotateString(char * string)`
- Keep track of your current location within the string and print from there.  Don't forget to wrap around!
    - `char * printFromPosition(char * start, char * current, char screenSizeInChars)`
    - returns the updated current position

It's annoying to constantly have to `cd` all the way to the directory where your lab is located.  We can fix that:

Type `alias "goToLab"="cd ~/path/to/your/lab"` in your shell.

Now, every time you type `goToLab`, it will replace it with the longer `cd` command.  Nice!

Unfortunately, we'll have to type this alias every time we open the shell - unless we put it in the file `~/.bashrc`.  If we put it in there, it will automatically be loaded every time we open our shell!  Once you add it, type `source ~/.bashrc` to load the commands.

## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 5 | | BOC L25 |
| Required Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 35 | | COB L26 |
| B Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L26 |
| A Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L26 |
| Use of Git / Github | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 10 | | BOC L27 |
| Lab Notebook | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ----- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 30 | | COB L27 |
| **Total** | | | **100** | | |

```
// 
// lcd.h
// Author: Todd Branchflower
// Date: 17 October 2013
// Description: Library to interact with the Geek Box LCD.
//

void initSPI();

void LCDinit();

void LCDclear();

void cursorToLineTwo();

void cursorToLineOne();

void writeChar(char asciiChar);

void writeString(char * string);

void scrollString(char * string1, char * string2);
```

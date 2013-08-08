# L3 Assignment - Assembly Process, MSP430 Execution, MSP430 Instruction Set

## Bug Reporting

All of the code behind the course website is available at [https://github.com/toddbranch/ECE382](https://github.com/toddbranch/ECE382).  If you find a mistake or have a suggestion for improvement, you should file a bug report so I can fix it.  You can review all outstanding issues as well as report new issues at [https://github.com/toddbranch/ECE382/issues](https://github.com/toddbranch/ECE382/issues).

**Find an issue with the course website and file a bug report.**

## Assembly Process

**What does the assembler do?**
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
**What does the linker do?**
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
Consider the following code:
```
mov.w   #0xdfec, &0x0200        ; stores the value 0xdfec at memory location 0x0200
```

**What is the location of each byte of the stored word, assuming big-endian byte ordering?**
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
**What byte ordering scheme does the MSP430 use?  What would be the location of each byte of the stored word?**
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
## MSP430 Execution

**What's the purpose of the program counter?**
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
**Assume `pc` currently holds `0xc000`.  The current instruction is 4 bytes long.  What is the value of `pc` the instant I step?**
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
**What happens if you attempt to access a memory address that isn't implemented in your chip?**
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
## MSP430 Instruction Set

**MSP430 Instruction Set.**

Consider the following code:
```
mov.w   #0xbeef, r8
swpb    r8
and.w   #0xff, r8
mov.w   r8, &0x0200
inv.w   r8
dec.w   r8
```

**Show the contents of `r8` after each the execution of each instrution.**
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

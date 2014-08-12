# L3 Assignment - Assembly Process, MSP430 Execution, MSP430 Instruction Set

Name:
Section:
Documentation:



## Assembly Process

**What does the assembler do?  Be specific.**
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
**What does the linker do?  Be specific.**
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

**What's the purpose of the program counter?  Be specific.**
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
**Assume `pc` currently holds `0xc000`.  The current instruction is 4 bytes long.  What is the value of `pc` the instant I step?  Don't overthink this.**
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
**What happens if you attempt to access a memory address that isn't implemented in your chip?  Talk about reads, writes, and execution.**
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

**Show the contents of `r8` after the execution of each instrution.**
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

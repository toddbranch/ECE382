target remote localhost:2000
display/3i $pc
display/x $r15

#location of WDTCTL
display/2xb   0x0120             

#location of P1DIR, P1OUT
display/xb   0x0021
display/xb   0x0022

source script.gdb

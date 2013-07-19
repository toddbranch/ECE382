target remote localhost:2000
display/3i $pc
display/14xh 0x0200
display/x   $r9
display/x   $r10
display/x   $r11
display/x   $r12
b *0xc03a
source script.gdb

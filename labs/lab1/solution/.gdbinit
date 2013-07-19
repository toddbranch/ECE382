target remote localhost:2000
display/3i $pc
display/10xb 0x0200
display/x   $r8
source script.gdb

set logging on
target remote localhost:2000
display/2xb 0x0200
display/s 0x0300
disp/3i $pc
disp/x  $r8
source script.gdb
monitor reset

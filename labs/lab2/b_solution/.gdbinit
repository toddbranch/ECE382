set logging on
target remote localhost:2000
display/s 0xc000
display/150xb 0x0200
display/s 0x0300
source script.gdb
monitor reset

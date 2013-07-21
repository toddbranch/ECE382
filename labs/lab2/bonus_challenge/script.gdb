monitor reset
monitor erase
load app.elf
info display
monitor reset
monitor fill 0x0200 255 0xff
monitor fill 0x0300 255 0xff

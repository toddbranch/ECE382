title = 'Going Standalone'

# Going Standalone

In a true embedded application, you're not going to want your MSP430 to be powered by the microUSB cable to connected to your computer.  Luckily, going standalone with the MSP430 and Launchpad is pretty easy.

**IMPORTANT: your MSP430 can only tolerate 1.7-3.6V.  Do not power it with more than that!**

1)  Make sure your MSP430 and power source share a common ground.

2)  Connect the VCC pin to your voltage source.

- Ensure this is less than 3.6V.

3)  Disconnect all of the jumpers on your board.

- Actually, you only need to disconnect TXD and RST - but I like disconnecting them all.

4)  Press the reset button to restart your program.

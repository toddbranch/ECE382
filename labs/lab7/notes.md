# Lab 7 Notes

- You can dead-reckon for the competition, not for functionality!  Functionality must use at least one sensor.
- Deadline for makeup assignment is L40.  Deadline for course critiques is BOC L39.

- If you want to change the ADC configuration, you have to ensure the ENC bit is clear.  The chip won't allow you to change settings without clearing this bit.  You'll need to change settings when switching sensors!
- If your chip is in the breadboard, you'll have to wire it to the appropriate pins on the Launchpad to light the LEDs.

- Be mindful of your interface when writing code!  You'll want to hide all of this complexity in a library once you get to the maze.
  - `unsigned int getLeftSensorReading()` seems like a good prototype
  - `char isLeftSensorCloseToWall()` might be useful
  - Think about what you'll want access to in the maze!

- The code in the L36 notes uses interrupts - you don't necessarily have to do that.
  - The `ADC10IFG` flag indicates `ADC10MEM` has been loaded with a conversion result.  It is automatically reset if the interrupt request is accepted.
  - You can also poll this flag and reset it in software.

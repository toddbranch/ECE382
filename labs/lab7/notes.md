# Lab 7 Notes

- You can dead-reckon for the competition, not for functionality!  Functionality must use sensors.
- Deadline for makeup assignment is L40.

- The code in the L36 notes uses interrupts - you don't necessarily have to do that.
  - The `ADC10IFG` flag indicates `ADC10MEM` has been loaded with a conversion result.  It is automatically reset if the interrupt request is accepted.
  - You can also poll this flag and reset it in software.

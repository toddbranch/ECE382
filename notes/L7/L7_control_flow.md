# L7 Assignment - Control Flow

This assignment will be graded on the CheckPlus / Check / CheckMinus / 0 scale - see [Grading](/admin/grading.html) for more information.

## The Program

Write a program that reads an **unsigned** word from `0x0216`.

- If the value is greater than `0x1234`: 
    - Use a loop to add `20+19+18+...+1` (decimal)
    - Store the result (as a word) in `0x0206`
    - Note: don't add `20+19+18+...+1` to `0x1234`, just sum the sequence by itself and store in memory.
- If the value is less than or equal to `0x1234`:
    - If the value is greater than `0x1000`:
        - Add `0xEEC0` to the value
        - Store the value of the carry flag (as a byte) in `0x0202`
    - If the value is less than or equal to `0x1000`:
        - If the value is even:
            - Divide the value by 2
        - If the value is odd:
            - Multiply the value by 2
        - Store the result (as a word) in `0x0212`
- Once you've accomplished the appropriate task, trap the CPU

**Extra credit goes to the student who creates the shortest program.  My solution is 26 instructions long.**

## Questions

Run the following starting values through your program and record the results.

`0x1235`:
<br>
<br>
<br>
<br>
`0x1234`:
<br>
<br>
<br>
<br>
`0x1001`:
<br>
<br>
<br>
<br>
`0x0800`:
<br>
<br>
<br>
<br>
`0x801`:
<br>
<br>
<br>
<br>
## Turn-in Requirements

- Email your instructor your final assembly program.
- Turn in this sheet with answers to the questions.

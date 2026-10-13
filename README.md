### Calculator

A simple calculator created using MIPS Assembly to practice assembly programming for SJSU CS 47.

## Group Notes

- Maybe create a branch for each new implementation.
- Be careful about pushing directly to `main` if you don't create a branch.
- Overflow handling is not necessary (optional implementation).
- Maybe no decimals/fractions?
- Maybe output the calculation process to show progression.
- General rule: if you push to the stack in a procedure, you must pop it at the end. Using a push/pop macro or procedure is recommended.

## TODOs

### General Checklist

| Check Here | Section / About | Notes |
| :---: | --- | --- |
|  | Main | Ask for an equation from the user, call the parser, and return the answer. |
|  | String Parser | Convert the input string into numeric values and function calls. |
|  | Parentheses | Treat inner values as a separate equation using a recursive call. Maybe delegate to the string parser. |
|  | Exponents | Support both `base^expo` and `base^(expo)`. Maybe delegate to the string parser. |
|  | Multiplication | |
|  | Division | |
|  | Addition | |
|  | Subtraction | |

### String Parser

| Check Here | Requirement / Condition |
| :---: | --- |
|  | Support `()^*x/+-0-9` |
|  | Support positive and negative numbers |
|  | Properly convert ASCII digits into usable two's-complement integer values |
|  | Input type: string |
|  | Output type: value |

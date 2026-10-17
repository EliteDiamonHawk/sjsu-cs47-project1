### Calculator

A simple calculator created using MIPS Assembly to practice assembly programming for SJSU CS 47.

## Group Notes

- read and lifecycle when possible

- Maybe create a branch for each new implementation.
- Be careful about pushing directly to `main` if you don't create a branch.
- Overflow handling is not necessary (optional implementation).
- Maybe no decimals/fractions?
- Maybe output the calculation process to show progression.
- General rule: if you push to the stack in a procedure, you must pop it at the end. Using a push/pop macro or procedure is recommended.

### Macro and Subroutines

Notes down macro and subroutines outside of `_macro` and `_subroutine` here. Look at reference.md for those in `_macro` and `_subroutine`.

| label | explaination | Inputs | Return |
|---|---|---|---|
| convert | Convert the input string into numeric values and operations.  validates for accepted char only. | | |
| exit_input_error | early ends the program due to sytnax/input error | | |
| isValue | checks whether word at given `equ` address is a value or operator | $a0: address of word (must be within equ) | $v0: 1 if value, 0 if operator

## Lifecycle

Explain the process the whole program goes through from start to exit (when there are no errors). Please update this whenever there are code changes affecting the program as a whole (linked to main).

- Program Starts
- Ask for equation input
- Calls convert, which changes character to values and operators, validates the character
- Print `end_msg` and `equ` as an integer
- Exit program

## TODOs

### General Checklist

| Check Here | Section / About | Notes |
| :---: | --- | --- |
|  | Main | Ask for an equation from the user, call the parser, and return the answer. |
|  | Convert | validates for accepted char only. Convert the input string into numeric values and operations |
|  | Parentheses | Treat inner values as a separate equation using a recursive call. Maybe delegate to the string parser. |
|  | Exponents | Support both `base^expo` and `base^(expo)`. Maybe delegate to the string parser. |
|  | Multiplication | |
|  | Division | |
|  | Addition | |
|  | Subtraction | |

### Calculator

A simple integer only calculator created using MIPS Assembly to practice assembly programming for SJSU CS 47.

## Group Notes

- read and lifecycle when possible

- Maybe create a branch for each new implementation.
- Be careful about pushing directly to `main` if you don't create a branch.
- Overflow handling is not necessary (optional implementation).
- Maybe no decimals/fractions?
- Maybe output the calculation process to show progression.
- General rule: if you push to the stack in a subroutine, please pop it at the end. Using a push/pop macro or subroutine is recommended.
- Please don't use `$s0` and `$s1` as those will be used by `calculator.asm` as essential pointers. If you do use it, restore it before a subroutine call to calculator.asm and after your subroutine.

### Macro and Subroutines

Notes down macro and subroutines outside of dedicated `_reference.md`s here.

convert
- Converts the input string into numeric values and operations and validates accepted characters `()^*x/+-` and digits `0-9`. Does not validate syntax.
- Separated into `convert.asm` for readability/organization.
- `$a0`: string equation.
- `$a1`: workspace.
- Intended result: the given string equation becomes a tracker where byte `x` stores `1` when workspace word `x` is an integer and `0` when it is an operator. The workspace stores the converted equation.

calculator_startStack
- Stores `$s#` registers.
- Stores the return address used to leave the calculator.
- Marks the beginning of calculator-owned stack usage.
- Used so on either normal completion or an input error, calculator stack are cleared and saved registers are restored.

calculator_clearStack
- Clears calculator-owned stack usage until its marker is reached.
- saved registers are restored 
- Intended to return the saved return address in `$v0`.
- does not modify temp registers

calculator_exit_inputError
- Early ends calculator processing due to a syntax/input error.
- Clears calculator stack usage.
- Returns the address of `"INPUT ERROR"` in `$v0` and sets `$v1` to `1`.

## File Overview

- `main.asm` - program entry point, input/output, and calculator call.
- `calculator.asm` - calculator entry point, shared calculator includes, and calculator-level helpers.
- `convert.asm` - input validation/token conversion work. Currently incomplete.
- `calc_stack.asm` - calculator-specific stack start/cleanup helpers.
- `_macro.asm` - common printing, input, and stack macros.
- `_subroutine.asm` - reusable I/O, string, character, and math subroutines.
- `macros_reference.md` - reference for common macros.
- `subroutines_reference.md` - reference for common subroutines.

## Lifecycle

Explain the process the whole program goes through from start to exit (when there are no errors). Please update this whenever there are code changes affecting the program as a whole (linked to main).

Current implemented flow:

- Program starts in `main.asm`.
- Ask for equation input and store up to 100 bytes in `str`.
- Print `Calculating...`.
- Call `calculator_calculateStringEquation` with `str` as the input and `equ` as the workspace.
- `calculator_calculateStringEquation` initializes calculator stack tracking and calls `convert`.
- `convert` currently walks the input, but conversion/validation behavior is still incomplete.
- Intended successful return: `$v0` contains the calculated integer and `$v1` is `0`; `main` prints `Answer: ` followed by `$v0`.
- Intended error return: `$v1` is nonzero and `$v0` contains an error string address; `main` prints the error string.
- Exit program.

## TODOs

### General Checklist

| Check Here | Section / About | Notes |
| :---: | --- | --- |
|  | Main | Ask for an equation from the user, call the parser, and return the answer. |
|  | Convert | Validate accepted characters and convert the input string into numeric values and operations. |
|  | Parentheses | Treat inner values as a separate equation using a recursive call. Maybe delegate to the string parser. |
|  | Exponents | Support both `base^expo` and `base^(expo)`. Maybe delegate to the string parser. |
|  | Multiplication | |
|  | Division | |
|  | Addition | |
|  | Subtraction | |

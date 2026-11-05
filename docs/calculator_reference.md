# Calculator Documentation/Reference

## Saved Registers

`$s#` registers from before the subroutine will be saved and returned through `calc_stack.asm`. Currently, the calculator saves the current values:
- `$s0`: pointer to tracker/given string equation
- `$s1`: pointer to the workspace
- `$s2`: pointer to start of calculator stack for exiting/clearing.

## Main Subroutine

### calculator_calculateStringEquation
- Main calculator entry point.
- Saves the caller return address and calculator arguments on the calculator stack before calling `convert`.
- Calculation after conversion is not implemented yet.
- `$a0`: address to the string equation.
- `$a1`: address to a workspace that is at least 4 times the space of `$a0`.
- `$v0`: intended returned value.
- `$v1`: intended status code (`0` if successful, `1` if error) 
- on error `$v0` contains the error string address.

## Helper Subroutines

These assume that `$s0` and `$s1` stores the pointers to tracker and workspace/equation. It helps with read/manipulating the equation as normally you would need to coordinate with tracker

### equation_toTracker
- gives retrives the corresponding adress in tracker given workspace address
- `$a0`: address of word (assume within equation/workspace).
- `$v0`: address of byte within tracker.

### equation_getType
- gives retrives the corresponding adress in tracker given workspace address
- `$a0`: address of word (assume within equation/workspace).
- `$v0`: value stored in associated byte in tracker. 0=end, 1=operation/char, 2=integer

### equation_isValue
- Checks whether a word at a given equation/workspace address represents a value or operator.
- Uses the corresponding byte in tracker.
- `$a0`: address of word (assume within equation/workspace).
- `$v0`: `1` if value, `0` if operator.

### equation_replace
deletes a given range in equation
- `$a0`: address of word to replace (assume within equation/workspace).
- `$a1`: ending value at given address after replace.
- `$a2`: value to replace in corresponding tracker byte. 0=end, 1=operation/char, 2=integer.

### equation_delRange
deletes a given range in equation
- `$a0`: address of starting word in range (assume within equation/workspace). Included in deletion.
- `$a1`: address of ending word in range (assume within equation/workspace). Excluded in deletion.

### equation_delMulti
deletes a given number of words/operations/integers at given address in equation
- `$a0`: address of word (assume within equation/workspace). Included in deletion/length
- `$a1`: length of delete (unsigned integer)

### equation_del
- deletes given word in equation and updates tracker
- `$a0`: address of word (assume within equation/workspace)

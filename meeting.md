# Meetup

## Subroutines

### Convert

- given a string equation, it converts it into reverse polish form
- validates accepted characters `()^*x/+-` and digits `0-9`. Does not validate syntax.
- Separated into `convert.asm` for readability/organization.
- `$a0`: string equation.
- `$a1`: workspace.

### execute_polish
- works after convert to reduce reverse-polish equation into a single integer
- works with whoever doing convert

### calculator_addition
- detect overflow
- `$a0`: first integer to add
- `$a1`: second interger to add
- `$v0`: result

### calculator_subtract
- detect overflow
- `$a0`: first integer to subtract from
- `$a1`: second interger, the number you are subtracting
- `$v0`: result

### calculator_multiply
- detect overflow
- `$a0`: first integer to multiple with
- `$a1`: second interger to multiply with
- `$v0`: result

### calculator_divide
- detect overflow
- truncate decimals
- `$a0`: first integer dividend
- `$a1`: second interger divisor
- `$v0`: result

### calculator_exponent
- detect overflow
- maybe call `calculator_multiply`?
- `$a0`: base
- `$a1`: power
- `$v0`: result

### string_to_int
- only allows `-` and numerals
- if it hits a character that is not allowed, it assumes end of integer/string
- use `equation_replace`
- `a0`: pointer (in tracker/string) to string (must iterate only once through)
- `a1`: pointer to workspace
- result is stored in first word of workspace

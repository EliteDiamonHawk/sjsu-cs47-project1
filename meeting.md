# Meetup

## Subroutines

### Convert
- assigned to: `EliteDiamonHawk (Dylan Huang)`
- given a string equation, it converts it into reverse polish form
- validates accepted characters `()^*x/+-` and digits `0-9`. Does not validate syntax.
- Separated into `convert.asm` for readability/organization.
- `$a0`: string equation.
- `$a1`: workspace.

### execute_polish
- assigned to: `uxiion (Alan)`
- works after convert to reduce reverse-polish equation into a single integer
- works with whoever doing convert

### calculator_addition
- assigned to: `hempie`
- detect overflow
- `$a0`: first integer to add
- `$a1`: second integer to add
- `$v0`: result

### calculator_subtract
- assigned to: `hempie`
- detect overflow
- `$a0`: first integer to subtract from
- `$a1`: second integer, the number you are subtracting
- `$v0`: result

### calculator_multiply
- assigned to: `Meme Generator`
- detect overflow
- `$a0`: first integer to multiple with
- `$a1`: second integer to multiply with
- `$v0`: result

### calculator_divide
- assigned to: `Meme Generator`
- detect overflow
- truncate decimals
- `$a0`: first integer dividend
- `$a1`: second integer divisor
- `$v0`: result

### calculator_exponent
- assigned to: `trinity`
- detect overflow
- maybe call `calculator_multiply`?
- `$a0`: base
- `$a1`: power
- `$v0`: result

### string_to_int
- assigned to: `trinity`
- only allows numerals 0-9 and an inital `-` for negative
- if it hits a character that is not allowed, it assumes end of integer/string
- `a0`: pointer (in tracker/string) to string (must iterate only once through)
- `v0`: integer in two's complement (signed)
- `v1`: number of characters/digits. for example `4321` returns 4 and `-4321` return 5.


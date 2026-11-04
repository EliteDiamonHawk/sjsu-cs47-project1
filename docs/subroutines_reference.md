# MIPS Subroutine Reference

Source: `_subroutine.asm`

## Subroutine Overview

| Subroutine | Purpose | Inputs | Return |
|---|---|---|---|
| `print_string` | Prints a null-terminated string. | `$a0` = string address | None |
| `println_string` | Prints a string followed by a newline. | `$a0` = string address | None |
| `println` | Prints a newline character. | None | None |
| `print_tab` | Prints a tab character. | None | None |
| `print_spc` | Prints a space character. | None | None |
| `print_integer` | Prints an integer. | `$a0` = integer | None |
| `println_integer` | Prints an integer followed by a newline. | `$a0` = integer | None |
| `print_char` | Prints a character. | `$a0` = character | None |
| `println_char` | Prints a character followed by a newline. | `$a0` = character | None |
| `exit_program` | Terminates the program. | None | Does not return |
| `read_int` | Reads an integer from the console. | None | `$v0` = integer |
| `read_string` | Reads a string from the console into a buffer. | `$a0` = buffer address; `$a1` = buffer size | Buffer modified |
| `length_string` | Gets the length of a null-terminated string, excluding `\0`. | `$a0` = string address | `$v0` = length |
| `reverse_string` | Copies a source string into a destination in reverse order. | `$a0` = result address; `$a1` = source address | Destination string modified |
| `print_hi` | Prints the current value of the HI register. | HI | None |
| `print_lo` | Prints the current value of the LO register. | LO | None |
| `swap_hi_lo` | Swaps the values stored in HI and LO. | HI, LO | HI and LO swapped |
| `math_pow` | Calculates an integer base raised to a nonnegative exponent by repeated multiplication. | `$a0` = base; `$a1` = exponent | `$v0` = result |
| `is_alpha` | Tests whether a character is alphabetic. | `$a0` = unsigned character | `$v0` = 1/0 |
| `is_lower_alpha` | Tests whether a character is lowercase alphabetic. | `$a0` = unsigned character | `$v0` = 1/0 |
| `is_upper_alpha` | Tests whether a character is uppercase alphabetic. | `$a0` = unsigned character | `$v0` = 1/0 |
| `is_digit` | Tests whether a character is a decimal digit. | `$a0` = character | `$v0` = 1/0 |
| `is_alnum` | Tests whether a character is alphabetic or numeric. | `$a0` = unsigned character | `$v0` = 1/0 |
| `is_space` | Tests whether a character is a space. | `$a0` = character | `$v0` = 1/0 |
| `is_tab` | Tests whether a character is a tab. | `$a0` = character | `$v0` = 1/0 |
| `is_carr_rtn` | Tests whether a character is a carriage return. | `$a0` = character | `$v0` = 1/0 |
| `is_nl` | Tests whether a character is a newline. | `$a0` = character | `$v0` = 1/0 |
| `is_whitespc` | Tests whether a character is supported whitespace: space, tab, carriage return, or newline. | `$a0` = character | `$v0` = 1/0 |
| `is_vowel` | Tests whether a character is an uppercase or lowercase vowel. | `$a0` = character | `$v0` = 1/0 |
| `is_lower_vowel` | Tests whether a character is a lowercase vowel. | `$a0` = character | `$v0` = 1/0 |
| `is_upper_vowel` | Tests whether a character is an uppercase vowel. | `$a0` = character | `$v0` = 1/0 |
| `to_upper` | Converts a lowercase alphabetic character to uppercase. | `$a0` = character | `$v0` = uppercase character, or 0 if not lowercase |
| `to_lower` | Converts an uppercase alphabetic character to lowercase. | `$a0` = character | `$v0` = lowercase character, or 0 if not uppercase |
| `title_case_string` | Modifies a string in place so alphabetic characters after non-alphanumeric characters become uppercase and other alphabetic characters become lowercase. | `$a0` = string address | String modified in place |
| `count_stats_string` | Counts vowels, digits, and whitespace characters in a string. | `$a0` = string; `$a1` = vowel-count address; `$a2` = digit-count address; `$a3` = whitespace-count address | Three counters written to memory |

## Implementation / Side-Effect Overview

| Subroutine | Important Registers / Calls | Behavior / Notes |
|---|---|---|
| `print_string` | `$v0=4`, syscall | Uses the MIPS print-string syscall. |
| `println_string` | Calls `print_string`, `println`; saves `$ra` | Preserves its return address with the stack macros. |
| `println` | `$a0='\n'`, `$v0=11`, syscall | Overwrites `$a0` and `$v0`. |
| `print_tab` | `$a0='\t'`, `$v0=11`, syscall | Overwrites `$a0` and `$v0`. |
| `print_spc` | `$a0=' '`, `$v0=11`, syscall | Overwrites `$a0` and `$v0`. |
| `print_integer` | `$v0=1`, syscall | Prints the integer currently in `$a0`. |
| `println_integer` | Calls `print_integer`, `println`; saves `$ra` | Prints integer then newline. |
| `print_char` | `$v0=11`, syscall | Prints the character currently in `$a0`. |
| `println_char` | Calls `print_char`, `println`; saves `$ra` | Prints character then newline. |
| `exit_program` | `$v0=10`, syscall | Terminates execution. |
| `read_int` | `$v0=5`, syscall | Syscall places the input integer in `$v0`. |
| `read_string` | `$v0=8`, syscall | Requires valid `$a0` buffer and `$a1` size before the call. |
| `length_string` | `$t0`, `$v0` | Advances through bytes until `\0`; computes end address minus starting address. |
| `reverse_string` | `$t0`, stack | Pushes source characters onto the stack, then pops them into the destination; appends `\0`. |
| `print_hi` | `mfhi`, `$a0`, `$v0=1` | Moves HI into `$a0` and prints it as an integer. |
| `print_lo` | `mflo`, `$a0`, `$v0=1` | Moves LO into `$a0` and prints it as an integer. |
| `swap_hi_lo` | `$t0`, `$t1`, `mfhi/mflo/mthi/mtlo` | Exchanges the contents of the special HI and LO registers. |
| `math_pow` | `$v0`, `$a0`, `$a1` | Starts result at 1 and repeatedly multiplies by base while decrementing exponent. |
| `is_alpha` | Calls `is_lower_alpha`, `is_upper_alpha`; saves `$ra` | Returns true as soon as either lowercase or uppercase test succeeds. |
| `is_lower_alpha` | `$v0` | Uses unsigned range checking for ASCII `a`-`z`. |
| `is_upper_alpha` | `$v0` | Uses unsigned range checking for ASCII `A`-`Z`. |
| `is_digit` | `$v0` | Uses unsigned range checking for ASCII `0`-`9`. |
| `is_alnum` | Calls `is_alpha`, `is_digit`; saves `$ra` | Returns true if either test succeeds. |
| `is_space` | `$v0` | Compares `$a0` with `' '`. |
| `is_tab` | `$v0` | Compares `$a0` with `'\t'`. |
| `is_carr_rtn` | `$v0` | Compares `$a0` with `'\r'`. |
| `is_nl` | `$v0` | Compares `$a0` with `'\n'`. |
| `is_whitespc` | Calls whitespace test routines; saves `$ra` | Tests space, tab, carriage return, then newline. |
| `is_vowel` | Calls lower/upper vowel tests; saves `$ra` | Returns true when either case-specific vowel test succeeds. |
| `is_lower_vowel` | `$v0` | Explicitly compares against `a`, `e`, `i`, `o`, `u`. |
| `is_upper_vowel` | `$v0` | Explicitly compares against `A`, `E`, `I`, `O`, `U`. |
| `to_upper` | Calls `is_lower_alpha`; saves `$ra` | If lowercase, subtracts 32 from ASCII value; otherwise returns 0. |
| `to_lower` | Calls `is_upper_alpha`; saves `$ra` | If uppercase, adds 32 to ASCII value; otherwise returns 0. |
| `title_case_string` | `$s0`; calls `to_upper`, `to_lower`, `is_alnum`; saves `$s0`, `$ra` | Works in place. First alphabetic character and alphabetic characters following non-alphanumeric characters are uppercased. |
| `count_stats_string` | `$s0-$s3`, `$t0`; calls `is_vowel`, `is_digit`, `is_whitespc`; saves `$s0-$s3`, `$ra` | Zeros all three supplied counters first, then scans the string and increments the appropriate counters. |

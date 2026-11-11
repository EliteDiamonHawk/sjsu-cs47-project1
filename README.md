# Calculator

A simple integer-only calculator created using MIPS Assembly to practice assembly programming for SJSU CS 47.

## Input Support

The program supports the following:
- the input characters `+-x*/^()` and numerals 0-9
- error handling
  - overflow
  - input validation
- output is a integer in two's complement

The program does NOT support the following:
- decimals `.`
  - fractions due to division are truncated.
- unary operators such as `+1` or `-(1)`. A `-` directly before a number is read as a negative number (e.g. `-1`, `2*-3`, `5--2`); otherwise write such as `(0-1)`, `(0+1)`, or `1`.
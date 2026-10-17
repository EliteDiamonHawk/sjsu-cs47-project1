# MIPS Macro Reference

Source: `_macro.asm`

## Macro Overview

| Macro | Purpose | Arguments |
|---|---|---|
| `print_string_lbl(%string_address)` | Prints the null-terminated string stored at a label/address. | `%string_address` - string label |
| `println_string_lbl(%string_address)` | Prints the string stored at a label/address, followed by a newline. | `%string_address` - string label |
| `print_int_i(%arg)` | Prints an immediate integer value. | `%arg` - integer/immediate value |
| `println_int_i(%arg)` | Prints an immediate integer value followed by a newline. | `%arg` - integer/immediate value |
| `print_char_i(%arg)` | Prints an immediate character value. | `%arg` - character/immediate value |
| `println_char_i(%arg)` | Prints an immediate character value followed by a newline. | `%arg` - character/immediate value |
| `read_string_lbl(%buffer_lbl, %buffer_size)` | Reads a string from the console into a labeled buffer. | `%buffer_lbl` - destination buffer; `%buffer_size` - buffer size |
| `push(%reg)` | Pushes one word from a register onto the MIPS stack. | `%reg` - source register |
| `pop(%reg)` | Pops the top word from the MIPS stack into a register. | `%reg` - destination register |

## Macro Behavior / Expansion

| Macro | Registers / Stack Used | Underlying Operation |
|---|---|---|
| `print_string_lbl` | `$a0`, `$ra` | Loads the label address into `$a0`, then calls `print_string`. |
| `println_string_lbl` | `$a0`, `$ra` | Loads the label address into `$a0`, then calls `println_string`. |
| `print_int_i` | `$a0`, `$ra` | Loads the immediate into `$a0`, then calls `print_integer`. |
| `println_int_i` | `$a0`, `$ra` | Loads the immediate into `$a0`, then calls `println_integer`. |
| `print_char_i` | `$a0`, `$ra` | Loads the immediate character into `$a0`, then calls `print_char`. |
| `println_char_i` | `$a0`, `$ra` | Loads the immediate character into `$a0`, then calls `println_char`. |
| `read_string_lbl` | `$a0`, `$a1`, `$ra` | Loads the buffer address into `$a0`, size into `$a1`, then calls `read_string`. |
| `push` | `$sp` | Decrements `$sp` by 4 and stores the register at `0($sp)`. |
| `pop` | `$sp` | Loads a word from `0($sp)` into the register, then increments `$sp` by 4. |

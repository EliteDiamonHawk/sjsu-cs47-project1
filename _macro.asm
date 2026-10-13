#print string at given address/label
.macro	print_string_lbl(%string_address)
	la	$a0, %string_address
	jal	print_string
.end_macro

#print string at given address/label with new line after
.macro	println_string_lbl(%string_address)
	la	$a0, %string_address
	jal	println_string
.end_macro

#print given integer
.macro	print_int_i(%arg)
	li	$a0, %arg
	jal	print_integer
.end_macro

#print given integer with new line after
.macro	println_int_i(%arg)
	li	$a0, %arg
	jal	println_integer
.end_macro

#print given char
.macro	print_char_i(%arg)
	li	$a0, %arg
	jal	print_char
.end_macro

#print given char with new line after
.macro	println_char_i(%arg)
	li	$a0, %arg
	jal	println_char
.end_macro

#read string from console, storing in give label
.macro	read_string_lbl(%buffer_lbl, %buffer_size)
	la	$a0, %buffer_lbl
	li	$a1, %buffer_size
	jal	read_string
.end_macro

#stack push: store word to sp
.macro	push(%reg)
	addi	$sp, $sp, -4
	sw	%reg, 0($sp)
.end_macro

#stack pop: store top of sp at given register
.macro	pop(%reg)
	lw	%reg, 0($sp)
	addi	$sp, $sp, 4
.end_macro

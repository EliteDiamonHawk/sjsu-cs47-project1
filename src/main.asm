.text
.globl main
	j main
.include	"calculator.asm"

.data
prompt:	.asciiz	"Please enter an equation: "
calc_msg:	.asciiz	"Calculating... "
end_msg:	.asciiz "Answer: "
str:	.space	100	#after convert: 1=value, 0=operator
equ:	.space	400	#stores integer and operations

.text
main:
	#read equation from user
	la	$a0, prompt
	jal	print_string
	read_string_lbl(str, 100)
	
	#calling subroutine to solve equation
	println_string_lbl(calc_msg)
	la	$a0, str
	la	$a1, equ
	jal calculator_calculateStringEquation
	bnez	$v1, main_calculation_error_sys_output	#check for error
	
	#ending: print end_msg and integer in 0(equ)
	print_string_lbl(end_msg)
	move	$a0, $v0
	jal	println_integer
	jal	exit_program
	
	#error/ending: print error message
main_calculation_error_sys_output:
	move	$a0, $v0
	jal	println_string
	jal	exit_program

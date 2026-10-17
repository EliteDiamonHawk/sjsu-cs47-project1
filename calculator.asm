.text
.globl main
	j main
.include	"_macro.asm"
.include	"_subroutine.asm"

.data
prompt:	.asciiz	"Please enter an equation: "
calc_msg:	.asciiz	"Calculating... "
input_error: 	.asciiz	"INPUT ERROR"
end_msg:	.asciiz "Answer: "

str:	.space	100	#after convert: 1=value, 0=operator
equ:	.space	400	#stores integer and operations



.text
main:
	la	$a0, prompt
	jal	print_string
	read_string_lbl(str, 100)
	println_string_lbl(calc_msg)
	jal 	convert
	
	
	#ending: print end_msg and integer in 0(equ)
	print_string_lbl(end_msg)
	lw	$a0, equ
	jal	println_int
	jal	exit_program


#early ends the program due to sytnax/input error
exit_input_error:
	println_string_lbl(input_error)
	jal	exit_program
	
	
# checks whether word at given equ address is a value or operator
isValue:
	la    $t0, equ
	subu  $t0, $a0, $t0	# offset from beginning of equ

	srl   $t0, $t0, 2	# divide offset by 4

	la    $t1, str
	addu  $t1, $t1, $t0	# address of corresponding type byte

	lbu   $v0, 0($t1)
	jr    $ra


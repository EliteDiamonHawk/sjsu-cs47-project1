.include	"_macro.asm"
.include	"_subroutine.asm"
.include	"calc_stack.asm"
.include	"convert.asm"

.text
# Calculates the answer to an string equation
calculate_string_equation:
	move	$t9, $a0
	move	$t8, $a1
	move	$a0, $ra
	jal	calculator_start_stack
	push($t9)
	push($t8)

	
	jal 	convert
	
	
	jal	calculator_clear_stack
	# TODO: put output in v0, v1
	jr	$v0
	
	
# checks whether word at given equ address is a value or operator
isValue:
	subu	$t0, $a0, $a1	# offset from beginning of equ

	srl	$t0, $t0, 2	# divide offset by 4

	la	$t1, str
	addu	$t1, $t1, $t0	# address of corresponding type byte

	lbu	$v0, 0($t1)
	jr	$ra


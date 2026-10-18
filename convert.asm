.text
# INCOMPLETE
# Convert the input string into numeric values and operations
convert:
	push($ra)
	move	$t1, $a0	#parse pointer
	move	$t2, $t1	#replace pointer: 1=value, 0=operator
	move	$t3, $a1	#equation pointer
convert_loop_start:
	lbu	$t4, 0($t1)
	beqz	$t4, convert_loop_end
	
convert_if_open_parenthesis:

	j	convert_loop_increment_pointers
	
convert_if_close_parenthesis:

	j	convert_loop_increment_pointers
	
convert_if_mult:

	j	convert_loop_increment_pointers
	
convert_if_x:

	j	convert_loop_increment_pointers
	
convert_if_div:

	j	convert_loop_increment_pointers
	
convert_if_plus:

	j	convert_loop_increment_pointers
	
convert_if_minus:

	j	convert_loop_increment_pointers
	
convert_if_num:
	
	j	convert_loop_increment_pointers
	
	
convert_loop_increment_pointers:
	addi $t1, $t1, 1	#increment pointers
	addi $t2, $t2, 1
	addi $t3, $t3, 4
convert_loop_end:
	pop($ra)
	jr	$ra
	
	
	
convert_toInteger:

	jr	$ra
	
convert_sP:	#save pointers
	push($t0)
	push($t1)
	push($t2)
	jr	$ra
convert_rP:	#restore pointers
	pop($t2)
	pop($t1)
	pop($t0)
	jr	$ra
	
	
.data
input_error: 	.asciiz	"INPUT ERROR"
.text
#early ends the calculator due to sytnax/input error
exit_input_error:
	jal	calculator_clear_stack
	move	$ra, $v0
	la	$v0, input_error
	addi	$v1, $zero, 1
	jr	$ra

	

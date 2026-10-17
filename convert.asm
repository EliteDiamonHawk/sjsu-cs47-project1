.text
# INCOMPLETE
# Convert the input string into numeric values and operations
convert:
	push($ra)
	la	$t1, str	#parse pointer
	move	$t2, $t1	#replace pointer: 1=value, 0=operator
	la	$t3, equ	#equation pointer
convert_loop_start:
	beqz	0($t1), validate_loop_end
	lbu	$t4, 0($t1)
	
convert_loop_if_open_parenthesis:

	j	convert_loop_increment_pointers
	
convert_loop_if_close_parenthesis:

	j	convert_loop_increment_pointers
	
convert_loop_if_carot:

	j	convert_loop_increment_pointers
	
convert_loop_if_star:

	j	convert_loop_increment_pointers
	
convert_loop_if_x:

	j	convert_loop_increment_pointers
	
convert_loop_if_div:

	j	convert_loop_increment_pointers
	
convert_loop_if_plus:

	j	convert_loop_increment_pointers
	
convert_loop_if_minus:

	j	convert_loop_increment_pointers
	
convert_loop_if_num:

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

	
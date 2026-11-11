# $v0 = calculated output

.text
execute_polish:
    	push($ra)
    	push($s3)
    	push($s4)
    	push($s5)
	
	move $s3, $s0 		# pointer to tracker
	move $s4, $s1		# pointer to polish equation
	move $s5, $zero 	# number of values on stack
	
execute_polish_loop:
	
	lbu $t0, 0($s3)		# get operand, end or integer
	
	beqz $t0, execute_polish_end
	
	addi $t1, $zero, 2
	beq $t0, $t1, execute_polish_value
	
	j execute_polish_operator

execute_polish_value:
	
	lw $t2, 0($s4)		# get number
	push ($t2)		# push onto stack
	
	addi $s5, $s5, 1	# increment counter of stack
	
	j execute_polish_next

execute_polish_operator:
	
	slti $t0, $s5, 2
	bnez $t0, calculator_exit_inputError
	
	pop($a1) 		# pop right operand first
	pop($a0)		# pop left operand second
	
	addi $s5, $s5, -2	# two operands popped
	lw $t0, 0($s4)
	
	addi $t1, $zero, '+'
	beq $t0, $t1, execute_polish_add
	
	addi $t1, $zero, '-'
	beq $t0, $t1, execute_polish_sub
	
	addi $t1, $zero, '*'
	beq $t0, $t1, execute_polish_mult
	
	addi $t1, $zero, '/'
	beq $t0, $t1, execute_polish_divison
	
	addi $t1, $zero, '^'
	beq $t0, $t1, execute_polish_exponent
	
	j calculator_exit_inputError
	
execute_polish_add:
	jal calculator_addition
	j execute_polish_push_result
	
execute_polish_sub:
	jal calculator_subtract
	j execute_polish_push_result

execute_polish_mult:
	jal calculator_multiply
	j execute_polish_push_result
	
execute_polish_divison:
	jal calculator_divide
	j execute_polish_push_result

execute_polish_exponent:
	jal calculator_exponent
	j execute_polish_push_result


execute_polish_push_result:	# push result onto stack
	push($v0)
	addi $s5, $s5, 1
	
	j execute_polish_next

execute_polish_next:
	addi $s3, $s3, 1	# next tracker byte
	addi $s4, $s4, 4	# next workspace word
	
	j execute_polish_loop
	
execute_polish_end:
	
	addi $t0, $zero, 1
	bne $s5, $t0, calculator_exit_inputError
	
	pop($v0)		# final answer
	
	pop($s5)
    	pop($s4)
    	pop($s3)
	pop($ra)
	
	jr $ra
	
	

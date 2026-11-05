.text

convert:
	push($ra)
	move	$s3, $s0	#parse pointer
	move	$s4, $s1	#equation pointer
	move	$s5, $s0	#tracker output pointer
	addi	$s6, $zero, 1	#expecting? 0=operator after value, 1=operand, 2=operator after ')'
	move	$s7, $zero	#counts how many operators in stack
	
convert_loop_start:
	lbu	$t4, 0($s3)		#current char
	beqz	$t4, convert_loop_end	#loop while current char is not $zero

	#skip whitespace
	move	$a0, $t4
	jal	is_whitespc
	bnez	$v0, convert_skip_whitespace
	lbu	$t4, 0($s3)		#reload current char after subroutine
	
	#check what type of token is expected
	beqz	$s6, convert_expect_operator
	addi	$t5, $zero, 2
	beq	$s6, $t5, convert_expect_operator

#cases when operand is expected
convert_expect_operand:	
	# ( case
	addi	$t5, $zero, '('
	beq	$t4, $t5, convert_open_parenthesis

	#normal case: char is digit
	move	$a0, $t4
	jal	is_digit
	beqz	$v0, calculator_exit_inputError
	
	#convert to integer
	move	$a0, $s3
	jal	string_to_int
	
	#output to equation
	sw	$v0, 0($s4)
	addi	$t5, $zero, 2
	sb	$t5, 0($s5)
	
	#increment and loop again
	addu	$s3, $s3, $v1
	addi	$s4, $s4, 4
	addi	$s5, $s5, 1
	move	$s6, $zero	#next token must be an operator
	j	convert_loop_start

#push ( onto operator stack
convert_open_parenthesis:
	push($t4)
	addi	$s7, $s7, 1
	addi	$s3, $s3, 1
	addi	$s6, $zero, 1	#still expecting operand
	j	convert_loop_start

#cases when operand is NOT expected
convert_expect_operator:
	#close parenthesis case
	addi	$t5, $zero, ')'
	beq	$t4, $t5, convert_close_parenthesis

	#open parenthesis after a value means implicit multiplication
	addi	$t5, $zero, '('
	beq	$t4, $t5, convert_implicit_multiply

	#digit after a close parenthesis means implicit multiplication
	move	$a0, $t4
	jal	is_digit
	beqz	$v0, convert_expect_operator_operation
	addi	$t5, $zero, 2
	beq	$s6, $t5, convert_implicit_multiply
	j	calculator_exit_inputError	#two separate numbers are not valid implicit multiplication

#normal operator case
convert_expect_operator_operation:
	lbu	$t4, 0($s3)		#reload current char after subroutine

	#addition
	addi	$t5, $zero, '+'
	beq	$t4, $t5, convert_operation_found

	#subtraction
	addi	$t5, $zero, '-'
	beq	$t4, $t5, convert_operation_found

	#multiplication. x or *
	addi	$t5, $zero, '*'
	beq	$t4, $t5, convert_operation_found

	addi	$t5, $zero, 'x'
	beq	$t4, $t5, convert_operation_x

	#division
	addi	$t5, $zero, '/'
	beq	$t4, $t5, convert_operation_found

	#exponent
	addi	$t5, $zero, '^'
	beq	$t4, $t5, convert_operation_found

	#anything else is invalid
	j	calculator_exit_inputError

#convert x to * for simplification
convert_operation_x:
	addi	$t4, $zero, '*'

#normal * increments parser
convert_operation_found:
	addi	$s3, $s3, 1
	j	convert_operation
convert_implicit_multiply:		#implicit * does not increment
	addi	$t4, $zero, '*'
	j	convert_operation

#operator handling
convert_operation:
	#push if operator stack is empty
	beqz	$s7, convert_operation_push

	#never pop through an open parenthesis
	lw	$t5, 0($sp)
	addi	$t6, $zero, '('
	beq	$t5, $t6, convert_operation_push

	#special ^ handling
	addi	$t6, $zero, '^'
	beq	$t4, $t6, convert_operation_push

	#*x/ only pop operators of equal/higher precedence
	addi	$t6, $zero, '*'
	beq	$t4, $t6, convert_operation_mul_div
	addi	$t6, $zero, '/'
	beq	$t4, $t6, convert_operation_mul_div

	#+- pop every operator until open parenthesis
	jal	convert_output_operator
	j	convert_operation

#pop ^*/ before pushing */
convert_operation_mul_div:
	addi	$t6, $zero, '^'
	beq	$t5, $t6, convert_operation_mul_div_pop
	addi	$t6, $zero, '*'
	beq	$t5, $t6, convert_operation_mul_div_pop
	addi	$t6, $zero, '/'
	beq	$t5, $t6, convert_operation_mul_div_pop
	j	convert_operation_push

convert_operation_mul_div_pop:
	jal	convert_output_operator
	j	convert_operation

#push current operator to operator stack
convert_operation_push:
	push($t4)
	addi	$s7, $s7, 1
	addi	$s6, $zero, 1	#next char must be an operand
	j	convert_loop_start

# ): pop stack to equation until open parenthesis
convert_close_parenthesis:
convert_close_parenthesis_loop_start:
	beqz	$s7, calculator_exit_inputError	 #no ( in stack
	lw	$t5, 0($sp)
	addi	$t6, $zero, '('
	beq	$t5, $t6, convert_close_parenthesis_found
	jal	convert_output_operator
	j	convert_close_parenthesis_loop_start

convert_close_parenthesis_found:
	pop($zero)		#remove (
	addi	$s7, $s7, -1
	addi	$s3, $s3, 1
	addi	$s6, $zero, 2	#operator expected. imply multiplication?
	j	convert_loop_start

#skip whitespace char
convert_skip_whitespace:
	addi	$s3, $s3, 1
	j	convert_loop_start

#end of input: output remaining operators
convert_loop_end:
	#ending while expecting an operand means empty input or trailing operator
	addi	$t5, $zero, 1
	beq	$s6, $t5, calculator_exit_inputError

convert_loop_end_operator:
	beqz	$s7, convert_loop_finish
	lw	$t5, 0($sp)
	addi	$t6, $zero, '('
	beq	$t5, $t6, calculator_exit_inputError	#unclosed parenthesis
	jal	convert_output_operator
	j	convert_loop_end_operator

convert_loop_finish:
	#mark end of equation in tracker
	sb	$zero, 0($s5)
	
	pop($ra)
	jr	$ra

#pop operator stack to equation
convert_output_operator:
	pop($t5)
	addi	$s7, $s7, -1
	sw	$t5, 0($s4)
	addi	$t6, $zero, 1
	sb	$t6, 0($s5)
	addi	$s4, $s4, 4
	addi	$s5, $s5, 1
	jr	$ra
	
	
.data
input_error: 	.asciiz	"INPUT ERROR"
.text
#early ends the calculator due to sytnax/input error
calculator_exit_inputError:
	jal	calculator_clearStack
	move	$ra, $v0
	la	$v0, input_error
	addi	$v1, $zero, 1
	jr	$ra

.data
overflow_error: 	.asciiz	"OVERFLOW ERROR"
.text
#early ends the calculator due to overflow error
calculator_exit_overflowError:
	jal	calculator_clearStack
	move	$ra, $v0
	la	$v0, overflow_error
	addi	$v1, $zero, 1
	jr	$ra

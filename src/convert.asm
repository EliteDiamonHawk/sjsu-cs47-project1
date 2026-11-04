.text
# INCOMPLETE
# Convert the input string into numeric values and operations
convert:
	push($ra)
	move	$t0, $s0	#parse pointer
	move	$t1, $s1	#equation pointer
	addi	$t2, $zero, 1	#expecting? 0=operator, 1=operand, 2=any
	move	$t3, $zero	#counts how many operators in stack
	
convert_loop_start:
	lbu	$t4, 0($t0)		#current char
	beqz	$t4, convert_loop_end	#loop while current char is not $zero

	#skip whitespace
	jal	convert_pushP
	pop($t4)
	move	$a0, $t4
	jal	is_whitespc
	pop($t4)
	jal	convert_popP
	add	$t0, $t0, $v0
	bnez	convert_loop_start
	
	
	beqz	convert_expect_operator

#cases when operand is expected
convert_expect_operand:	
	#open parenthesis case
	#jump to opearand case?

	#normal case: first char is digit
	convert_pushP	#validation/check
	move	$a0, $t4
	jal	is_digit
	convert_popP
	
	beqz	$v0, convert_expect_operand_unary #try unary if not digit
	
	#convert to integer
	convert_pushP
	move	$a0, $t0
	jal	string_to_int
	convert_popP
	
	#output to equation
	push($v1)
	convert_pushP
	addi	$a1, $a0
	move	$a0, $t1
	addi	$a2, $zero, 2
	jal	equation_replace
	convert_popP
	pop($v1)
	
	#increment and loop again
	add	$t0, $t0, $v1
	addi	$t1, $t1, 4
	j	convert_loop_start
	
	#unary case: char is operator, next char is digt, AND expecting operand
convert_expect_operand_unary:
	
	
	beq	$t2, 1, convert_loop_start

#cases when operand is NOT expected
convert_expect_operator:

	j	convert_loop_start

convert_loop_end:
	
	pop($ra)
	jr	$ra
	
	
	
#save pointers
convert_pushP:
	push($t0)
	push($t1)
	push($t2)
	push($t3)
	jr	$ra

#restore pointers
convert_popP
	pop($t3)
	pop($t2)
	pop($t1)
	pop($t0)
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
#early ends the calculator due to sytnax/input error
calculator_exit_inputError:
	jal	calculator_clearStack
	move	$ra, $v0
	la	$v0, overflow_error
	addi	$v1, $zero, 1
	jr	$ra
	

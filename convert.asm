.text
# INCOMPLETE
# Convert the input string into numeric values and operations
convert:
	push($ra)
	move	$t1, $a0	#parse pointer
	move	$t2, $t1	#replace pointer: 1=value, 0=operator
	move	$t3, $a1	#equation pointer
	
convert_loop_start:
	lbu	$t4, 0($t1)		#current char
	beqz	$t4, convert_loop_end	#loop while current char is not $zero

convert_char_to_integer:	#recusively turn numbers into 
	jal	convert_saveP
	jal	char_to_integer		#convert char to integer, saving pointers
	jal	convert_restoreP
	beqz	$v1, convert_store_operation	#checks if conversion is successful, else an operation
	
convert_string_to_integer_loop:	
	push($v0)
	

convert_store_integer:

	j	convert_loop_increment_pointers

convert_check_operation:	# validates current char as operation
	lbu	$t4, 0($t1)		# in case t4 was modified
	beq 	$t4, '(', convert_store_operation
	beq 	$t4, ')', convert_store_operation
	beq 	$t4, '^', convert_store_operation
	beq 	$t4, '*', convert_store_operation
	beq 	$t4, 'x', convert_store_operation
	beq 	$t4, '/', convert_store_operation
	beq 	$t4, '+', convert_store_operation
	beq 	$t4, '-', convert_store_operation
	j	exit_input_error	#error if operand or digit

convert_store_operation:
	sw	$t4, 0($t3)
	sb	$zero,	0($t2)
	
convert_loop_increment_pointers:
	addi	$t1, $t1, 1	#increment pointers
	addi	$t2, $t2, 1
	addi	$t3, $t3, 4
	
	j	convert_loop_start

convert_loop_end:
	pop($ra)
	jr	$ra
	
#save pointers
convert_saveP:
	push($t0)
	push($t1)
	push($t2)
	jr	$ra

#restore pointers
convert_restoreP:
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

	

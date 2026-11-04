.text
# INCOMPLETE
# Convert the input string into numeric values and operations
convert:
	push($ra)
	move	$t0, $s0	#parse pointer
	move	$t1, $s1	#equation pointer
	addi	$t2, $zero, 1	#expecting operand?
	
convert_loop_start:
	lbu	$t4, 0($t0)		#current char
	beqz	$t4, convert_loop_end	#loop while current char is not $zero

	#skip whitespace
	jal	convert_saveP
	pop($t4)
	move	$a0, $t4
	jal	is_whitespc
	pop($t4)
	jal	convert_restoreP
	add	$t0, $t0, $v0
	bnez	convert_loop_start
	
	#char is integer/digit
	




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
convert_restoreP
	push($t2)
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
	

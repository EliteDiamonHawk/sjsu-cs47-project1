.text

#marks the start of the stack for calculator so that when a error occurs, all stack usage is cleared
#marker is $zero
calculator_start_stack:
	push($zero)
	push($a0)
	jr	$ra

#clears the calculator stack and returns the $ra to leave calculator
calculator_clear_stack:
	move	$t1, $t0
	push($t0)
	bnez	$t0, calculator_clear_stack
	move	$v0, $t1
	jr	$ra
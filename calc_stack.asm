.text

#marks the start of the stack for calculator so that when a error occurs, all stack usage is cleared
#marker is $zero
calculator_start_stack:
	push($a0)
	puhs($s0)
	push($s1)
	push($s2)
	push($s3)
	push($s4)
	push($s5)
	push($s6)
	push($s7)
	push($zero)
	jr	$ra

#clears the calculator stack and returns the $ra to leave calculator
calculator_clear_stack:
	push($v0)
	bnez	$v0, calculator_clear_stack
	pop($s7)
	pop($s6)
	pop($s5)
	pop($s4)
	pop($s3)
	pop($s2)
	pop($s1)
	pop($s0)
	pop($v0)
	jr	$ra

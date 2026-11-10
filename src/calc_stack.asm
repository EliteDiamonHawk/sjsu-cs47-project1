.text

#marks the start of the stack for calculator so that when a error occurs, all stack usage is cleared
#marker is $zero
calculator_startStack:
	push($a0)	#ra to outside calculator
	puhs($s0)
	push($s1)
	push($s2)
	push($s3)
	push($s4)
	push($s5)
	push($s6)
	push($s7)
	move	$s2, $sp
	jr	$ra

#clears the calculator stack and returns the $ra to leave calculator
#does not touch temporaries so store calculator return values there
calculator_clearStack:
	beq	$sp, $s2, calculator_clearStack_loop_end
calculator_clearStack_loop_start:
	pop($zero)
	bne	$sp, $s2, calculator_clearStack_loop_start
calculator_clearStack_loop_end:
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

.include	"_macro.asm"
.include	"_subroutine.asm"
.include	"calc_stack.asm"
.include	"convert.asm"

.text
# Calculates the answer to an string equation
calculator_calculateStringEquation:
	#start setup
	move	$t9, $a0
	move	$t8, $a1
	move	$a0, $ra
	jal	calculator_startStack
	move	$s0, $t9
	move	$s1, $t8

	#start algo
	jal 	convert
	
	
	
	#end cleanup
	jal	calculator_clearStack
	# TODO: put output in v0, v1
	jr	$v0
	
	
	
# gives retrives the corresponding adress in tracker given workspace address
equation_toTracker:
	subu	$v0, $a0, $s1	# offset from beginning of equ
	srl	$v0, $v0, 2	# divide offset by 4
	addu	$v0, $a0, $v0	# address of corresponding type byte
	jr	$ra
	
equation_getType:
	push($ra)
	
	jal	equation_toTracker
	lbu	$v0, 0($v0)
	
	pop($ra)
	jr	$ra
	
# checks whether word at given workspace address is a value or operator
equation_isValue:
	push($ra)
	
	jal	equation_getType
	seq	$v0, $v0, 2
	
	pop($ra)
	jr	$ra
	
#replaces given address in equation and updates corresponding byte in tracker
equation_replace:
	push($ra)
	
	sw	$a1, 0($a0)
	jal	equation_toTracker
	sb	$a2, 0($v0) 
	
	pop($ra)
	jr	$ra

# deletes a given range in equation
equation_delRange:
	move	$t0, $a0
	move	$t1, $a1

equation_delRange_loop_start:
	lw
	

#deletes a given number of words/operations/integers at given address in equation
equation_delMulti:


#deletes given word in equation and updates tracker
equation_del:




#removes whitespc from equation at given address
equation_rmWhitespc:
equation_rmWhitespc_loop:
	
	
	
equation_rmWhitespc_loop_end:
	jr	$ra
	
	
#removes all whitespc throught equation
equation_clearWhitespc:

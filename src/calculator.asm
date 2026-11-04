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
	jal	execute_polish
	
	#end cleanup
	jal	calculator_clearStack
	# put output in v0, v1
	move	$ra, $v0
	la	$v0, $s1
	move	$v1, $zero
	jr	$ra
	
	
	
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
	push($ra)

equation_delRange_loop_start:
	
	#replace a character
	push($a0)
	push($a1)
	move	$a0, $a1
	jal	equation_toTracker
	pop($a1)
	pop($a0)

	push($a0)
	push($a1)
	move	$a2, $v0
	jal	equation_replace
	pop($a1)
	pop($a0)
	
	#check if last placed character was string end marker
	push($a0)
	push($a1)
	jal	equation_getType
	pop($a1)
	pop($a0)
	beqz	$v0, equation_delRange_loop_end
	
	#increment and loop
	addi	$a0, $a0, 4
	addi	$a1, $a1, 4
	j	equation_delRange_loop_start
	
equation_delRange_loop_end:
	pop($ra)
	jr	$ra
	
#deletes a given number of words/operations/integers at given address in equation
equation_delMulti:
	push($ra)
	
	add	$a1, $a0, $a1
	jal	equation_delRange
	
	pop($ra)
	jr	$ra

#deletes given word in equation and updates tracker
equation_del:
	push($ra)
	
	addi	$a1, $zero, 1
	jal	equation_delMulti
	
	pop($ra)
	jr	$ra




# add and subtract subroutines (multiply + divide should also be here)
# basically just adds the integers then checks the sign bit for an overflow and goes to the overflow routine if detected

.text

#<-------------------- ADDITION ---------------------->#

# adds two signed integers and detects overflow
# $a0: first integer
# $a1: second integer
# $v0: result
calculator_addition:

	addu $v0, $a0, $a1	# add both integers without triggering an overflow exception
	xor  $t0, $a0, $v0	# compare sign of first operand with result (1 if different)
	xor  $t1, $a1, $v0	# compare sign of second operand with result (1 if different)
	and  $t0, $t0, $t1	# sign bit becomes 1 if both operands differ in sign from result

	bltz $t0, calculator_exit_overflowError	# if sign bit is 1, overflow occurred
	jr   $ra	# otherwise return to caller with result in $v0


#<-------------------- SUBTRACTION ---------------------->#

# subtracts two signed integers and detects overflow
# $a0: first integer
# $a1: second integer (number being subtracted)
# $v0: result
calculator_subtract:
	subu $v0, $a0, $a1	# subtract second integer from first without overflow exception

	xor  $t0, $a0, $a1	# compare operand signs (1 in sign bit if different)
	xor  $t1, $a0, $v0	# compare first operand sign with result sign
	and  $t0, $t0, $t1	# sign bit becomes 1 if both conditions hold

	bltz $t0, calculator_exit_overflowError	# if sign bit is 1, overflow occurred
	jr   $ra	# otherwise return to caller with result in $v0

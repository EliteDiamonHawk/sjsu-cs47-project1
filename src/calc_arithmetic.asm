# add, subtract, multiply, and divide subroutines
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


#<-------------------- MULTIPLICATION ---------------------->#

# multiplies two signed integers and detects overflow
# $a0: first integer
# $a1: second integer
# $v0: result
calculator_multiply:
	mult	$a0, $a1	# Multiplies the first and second integer
	mflo	$v0		# Moves the lower 32 bits of the result into $v0
	mfhi	$t0		# Moves the higher 32 bits of the result into a temporary register
	
	sra	$t1, $v0, 31	# Shifts the lower 32 bits to the right by 31 arithmetically
	bne	$t0, $t1, calculator_exit_overflowError	# If the higher 32 bits are different from $t1, overflow occurred
	
	jr	$ra	# Otherwise return to caller with result in $v0


#<-------------------- DIVISION ---------------------->#

# divides two signed integers and detects overflow
# $a0: dividend
# $a1: divisor
# $v0: result
calculator_divide:
	beq	$zero, $a1, calculator_exit_overflowError	# If divisor is 0, overflow occurred
	
	div	$a0, $a1	# Otherwise, divides the dividend by the divisor
	mflo	$v0		# Moves the result from Lo register to $v0
	
	jr	$ra		# Return to caller with result in $v0

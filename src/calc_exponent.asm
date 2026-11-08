.text

calculator_exponent:
li $v0, 1
beqz $a1, calculator_exponent_end
beq $a0, 1, calculator_exponent_end
beq $a0, -1, calculator_exponent_neg_one
beqz $a0, calculator_exponent_zero_base
bltz $a1, calculator_exponent_fraction

move $t2, $a1
calculator_exponent_loop:
mult $v0, $a0
mflo $v0
mfhi $t0
sra $t1, $v0, 31
bne $t0, $t1, calculator_exit_overflowError
addi $t2, $t2, -1
bnez $t2, calculator_exponent_loop

calculator_exponent_end:
jr $ra

calculator_exponent_neg_one:
andi $t0, $a1, 1
beqz $t0, calculator_exponent_end
li $v0, -1
jr $ra

calculator_exponent_zero_base:
bltz $a1, calculator_exit_inputError
li $v0, 0
jr $ra

calculator_exponent_fraction:
li $v0, 0
jr $ra

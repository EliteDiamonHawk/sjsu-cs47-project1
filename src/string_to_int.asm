.text

string_to_int:
move $t0, $a0
li $v0, 0
li $t3, 0

lbu $t1, 0($t0)
bne $t1, '-', string_to_int_loop
li $t3, 1
addi $t0, $t0, 1

string_to_int_loop:
lbu $t1, 0($t0)
blt $t1, '0', string_to_int_done
bgt $t1, '9', string_to_int_done
addi $t1, $t1, -48

bgt $v0, 214748364, calculator_exit_overflowError
mul $v0, $v0, 10
addu $v0, $v0, $t1
bltz $v0, calculator_exit_overflowError

addi $t0, $t0, 1
j string_to_int_loop

string_to_int_done:
sub $v1, $t0, $a0
beq $v1, $t3, string_to_int_no_digits
beqz $t3, string_to_int_end
sub $v0, $zero, $v0

string_to_int_end:
jr $ra

string_to_int_no_digits:
li $v0, 0
li $v1, 0
jr $ra

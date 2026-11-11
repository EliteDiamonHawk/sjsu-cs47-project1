# Automated tests for the calculator.
# Assemble and run THIS file (not main.asm) in MARS. Each test prints [PASS] or [FAIL]
# followed by a summary. Each test's input is in a comment so it can be copied into main.asm.
#
# To add a test: add an input string under "test inputs" and a row to the "tests" table:
#	.word	<input label>, <expected status>, <expected value (ignored on error)>

.eqv	STATUS_OK	0	# answer returned
.eqv	STATUS_INPUT	1	# INPUT ERROR
.eqv	STATUS_OVERFLOW	2	# OVERFLOW ERROR
.eqv	STATUS_UNKNOWN	3	# error string not recognized
.eqv	TEST_SIZE	12	# bytes per row in tests table

.text
.globl test_main
	j	test_main
.include	"calculator.asm"

.data
#----- test inputs -----
t_add:		.asciiz	"1+2"
t_sub:		.asciiz	"5-3"
t_sub_neg:	.asciiz	"3-5"
t_sub_chain:	.asciiz	"10-3-2"
t_mul:		.asciiz	"7*6"
t_mul_x:	.asciiz	"7x6"
t_div_chain:	.asciiz	"100/7/2"
t_pow:		.asciiz	"2^10"
t_prec1:	.asciiz	"2+3*4"
t_prec2:	.asciiz	"2*3^2"
t_prec3:	.asciiz	"2^3*2"
t_pow_right:	.asciiz	"2^3^2"
t_prec_mix:	.asciiz	"1+2*3-4/2^2"
t_paren1:	.asciiz	"(2+3)*4"
t_paren2:	.asciiz	"1-(2-3)"
t_paren3:	.asciiz	"((((1))))"
t_paren4:	.asciiz	"(1)-2"
t_imp1:		.asciiz	"2(3)"
t_imp2:		.asciiz	"(2)(3)"
t_imp3:		.asciiz	"(1+2)3"
t_imp4:		.asciiz	"3(4+1)-2"
t_imp5:		.asciiz	"2^2(3)"
t_space:	.asciiz	" 12 + 30 "
t_negres1:	.asciiz	"0-5*3"
t_negres2:	.asciiz	"8/(0-3)"
t_negres3:	.asciiz	"(0-7)/2"
t_neg1:		.asciiz	"-5"
t_neg2:		.asciiz	"3+-5"
t_neg3:		.asciiz	"5--2"
t_neg4:		.asciiz	"2*-3"
t_neg5:		.asciiz	"-2*-3"
t_neg6:		.asciiz	"8/-3"
t_neg7:		.asciiz	"-2^2"
t_neg8:		.asciiz	"(-1)^3"
t_neg9:		.asciiz	"2(-3)"
t_neg10:	.asciiz	"3 - -5"
t_pow_neg:	.asciiz	"2^-1"
t_pow_zero:	.asciiz	"0^0"
t_pow_even:	.asciiz	"(-1)^4"
t_pow_big:	.asciiz	"2^30"
t_max:		.asciiz	"2147483647"
t_min:		.asciiz	"-2147483647-1"
t_mul_big:	.asciiz	"46340*46340"
t_of_lit:	.asciiz	"2147483648"
t_of_neglit:	.asciiz	"-2147483648"
t_of_add:	.asciiz	"2147483647+1"
t_of_sub:	.asciiz	"-2147483647-1-1"
t_of_mul:	.asciiz	"46341*46341"
t_of_pow:	.asciiz	"2^31"
t_of_div0:	.asciiz	"5/0"
t_of_divmin:	.asciiz	"(-2147483647-1)/-1"
t_err_empty:	.asciiz	""
t_err_trail:	.asciiz	"1+"
t_err_lead:	.asciiz	"+1"
t_err_twonum:	.asciiz	"1 2"
t_err_open:	.asciiz	"(1+2"
t_err_close:	.asciiz	"1+2)"
t_err_empty_p:	.asciiz	"()"
t_err_char:	.asciiz	"1+a"
t_err_dash:	.asciiz	"-"
t_err_dbldash:	.asciiz	"--5"
t_err_negparen:	.asciiz	"-(3)"
t_err_zeroneg:	.asciiz	"0^-1"

#----- tests table: input, expected status, expected value -----
	.align	2
tests:
	# basic operations
	.word	t_add, STATUS_OK, 3			# 1+2
	.word	t_sub, STATUS_OK, 2			# 5-3
	.word	t_sub_neg, STATUS_OK, -2		# 3-5
	.word	t_sub_chain, STATUS_OK, 5		# 10-3-2
	.word	t_mul, STATUS_OK, 42			# 7*6
	.word	t_mul_x, STATUS_OK, 42			# 7x6
	.word	t_div_chain, STATUS_OK, 7		# 100/7/2
	.word	t_pow, STATUS_OK, 1024			# 2^10
	# precedence and associativity
	.word	t_prec1, STATUS_OK, 14			# 2+3*4
	.word	t_prec2, STATUS_OK, 18			# 2*3^2
	.word	t_prec3, STATUS_OK, 16			# 2^3*2
	.word	t_pow_right, STATUS_OK, 512		# 2^3^2
	.word	t_prec_mix, STATUS_OK, 6		# 1+2*3-4/2^2
	# parentheses
	.word	t_paren1, STATUS_OK, 20			# (2+3)*4
	.word	t_paren2, STATUS_OK, 2			# 1-(2-3)
	.word	t_paren3, STATUS_OK, 1			# ((((1))))
	.word	t_paren4, STATUS_OK, -1			# (1)-2
	# implicit multiplication
	.word	t_imp1, STATUS_OK, 6			# 2(3)
	.word	t_imp2, STATUS_OK, 6			# (2)(3)
	.word	t_imp3, STATUS_OK, 9			# (1+2)3
	.word	t_imp4, STATUS_OK, 13			# 3(4+1)-2
	.word	t_imp5, STATUS_OK, 12			# 2^2(3)
	# whitespace
	.word	t_space, STATUS_OK, 42			#  12 + 30
	# negative results
	.word	t_negres1, STATUS_OK, -15		# 0-5*3
	.word	t_negres2, STATUS_OK, -2		# 8/(0-3)
	.word	t_negres3, STATUS_OK, -3		# (0-7)/2
	# negative number inputs
	.word	t_neg1, STATUS_OK, -5			# -5
	.word	t_neg2, STATUS_OK, -2			# 3+-5
	.word	t_neg3, STATUS_OK, 7			# 5--2
	.word	t_neg4, STATUS_OK, -6			# 2*-3
	.word	t_neg5, STATUS_OK, 6			# -2*-3
	.word	t_neg6, STATUS_OK, -2			# 8/-3
	.word	t_neg7, STATUS_OK, 4			# -2^2	(read as (-2)^2)
	.word	t_neg8, STATUS_OK, -1			# (-1)^3
	.word	t_neg9, STATUS_OK, -6			# 2(-3)
	.word	t_neg10, STATUS_OK, 8			# 3 - -5
	# exponent edge cases
	.word	t_pow_neg, STATUS_OK, 0			# 2^-1	(fraction truncated)
	.word	t_pow_zero, STATUS_OK, 1		# 0^0
	.word	t_pow_even, STATUS_OK, 1		# (-1)^4
	.word	t_pow_big, STATUS_OK, 1073741824	# 2^30
	# 32-bit limits
	.word	t_max, STATUS_OK, 2147483647		# 2147483647
	.word	t_min, STATUS_OK, -2147483648		# -2147483647-1
	.word	t_mul_big, STATUS_OK, 2147395600	# 46340*46340
	# overflow errors
	.word	t_of_lit, STATUS_OVERFLOW, 0		# 2147483648
	.word	t_of_neglit, STATUS_OVERFLOW, 0		# -2147483648	(known limitation)
	.word	t_of_add, STATUS_OVERFLOW, 0		# 2147483647+1
	.word	t_of_sub, STATUS_OVERFLOW, 0		# -2147483647-1-1
	.word	t_of_mul, STATUS_OVERFLOW, 0		# 46341*46341
	.word	t_of_pow, STATUS_OVERFLOW, 0		# 2^31
	.word	t_of_div0, STATUS_OVERFLOW, 0		# 5/0
	.word	t_of_divmin, STATUS_OVERFLOW, 0		# (-2147483647-1)/-1	(known bug: currently FAILS)
	# input errors
	.word	t_err_empty, STATUS_INPUT, 0		# (empty input)
	.word	t_err_trail, STATUS_INPUT, 0		# 1+
	.word	t_err_lead, STATUS_INPUT, 0		# +1
	.word	t_err_twonum, STATUS_INPUT, 0		# 1 2
	.word	t_err_open, STATUS_INPUT, 0		# (1+2
	.word	t_err_close, STATUS_INPUT, 0		# 1+2)
	.word	t_err_empty_p, STATUS_INPUT, 0		# ()
	.word	t_err_char, STATUS_INPUT, 0		# 1+a
	.word	t_err_dash, STATUS_INPUT, 0		# -
	.word	t_err_dbldash, STATUS_INPUT, 0		# --5
	.word	t_err_negparen, STATUS_INPUT, 0		# -(3)
	.word	t_err_zeroneg, STATUS_INPUT, 0		# 0^-1
tests_end:

#----- runner data -----
test_input:	.space	100	#copy of current input; calculator overwrites its input
	.align	2
test_workspace:	.space	400
test_pass_msg:	.asciiz	"[PASS] "
test_fail_msg:	.asciiz	"[FAIL] "
test_eq_msg:	.asciiz	"  =  "
test_expect_msg:	.asciiz	"  expected: "
test_got_msg:	.asciiz	"  got: "
test_unknown_msg:	.asciiz	"UNKNOWN ERROR"
test_summary_msg:	.asciiz	"Passed: "
test_of_msg:	.asciiz	" / "

.text
test_main:
	la	$s0, tests	#current test row
	la	$s1, tests_end
	move	$s2, $zero	#passed count
	move	$s3, $zero	#total count

test_main_loop_start:
	beq	$s0, $s1, test_main_loop_end

	#copy input into test_input
	lw	$a1, 0($s0)
	la	$a0, test_input
	jal	test_copy_string

	#run calculator
	la	$a0, test_input
	la	$a1, test_workspace
	jal	calculator_calculateStringEquation
	move	$s4, $v0	#answer or error string address
	move	$a0, $v0
	move	$a1, $v1
	jal	test_get_status
	move	$s5, $v0	#actual status

	#compare status, then value if no error
	lw	$t0, 4($s0)
	bne	$s5, $t0, test_main_fail
	bnez	$s5, test_main_pass
	lw	$t0, 8($s0)
	bne	$s4, $t0, test_main_fail

test_main_pass:
	addi	$s2, $s2, 1
	print_string_lbl(test_pass_msg)
	lw	$a0, 0($s0)
	jal	print_string
	print_string_lbl(test_eq_msg)
	move	$a0, $s5
	move	$a1, $s4
	jal	test_print_result
	jal	println
	j	test_main_next

test_main_fail:
	print_string_lbl(test_fail_msg)
	lw	$a0, 0($s0)
	jal	print_string
	print_string_lbl(test_expect_msg)
	lw	$a0, 4($s0)
	lw	$a1, 8($s0)
	jal	test_print_result
	print_string_lbl(test_got_msg)
	move	$a0, $s5
	move	$a1, $s4
	jal	test_print_result
	jal	println

test_main_next:
	addi	$s3, $s3, 1
	addi	$s0, $s0, TEST_SIZE
	j	test_main_loop_start

test_main_loop_end:
	#summary: Passed: X / N
	jal	println
	print_string_lbl(test_summary_msg)
	move	$a0, $s2
	jal	print_integer
	print_string_lbl(test_of_msg)
	move	$a0, $s3
	jal	println_integer
	jal	exit_program

#copies a null-terminated string, including the null
#$a0: destination address, $a1: source address
test_copy_string:
	lbu	$t0, 0($a1)
	sb	$t0, 0($a0)
	addi	$a0, $a0, 1
	addi	$a1, $a1, 1
	bnez	$t0, test_copy_string
	jr	$ra

#converts calculator output into a status code
#$a0: calculator $v0, $a1: calculator $v1, return: status in $v0
test_get_status:
	addi	$v0, $zero, STATUS_OK
	beqz	$a1, test_get_status_end
	addi	$v0, $zero, STATUS_INPUT
	la	$t0, input_error
	beq	$a0, $t0, test_get_status_end
	addi	$v0, $zero, STATUS_OVERFLOW
	la	$t0, overflow_error
	beq	$a0, $t0, test_get_status_end
	addi	$v0, $zero, STATUS_UNKNOWN
test_get_status_end:
	jr	$ra

#prints the value if status is OK, otherwise the error name
#$a0: status, $a1: value
test_print_result:
	push($ra)
	bnez	$a0, test_print_result_error
	move	$a0, $a1
	jal	print_integer
	j	test_print_result_end

test_print_result_error:
	addi	$t0, $zero, STATUS_INPUT
	la	$t1, input_error
	beq	$a0, $t0, test_print_result_msg
	addi	$t0, $zero, STATUS_OVERFLOW
	la	$t1, overflow_error
	beq	$a0, $t0, test_print_result_msg
	la	$t1, test_unknown_msg
test_print_result_msg:
	move	$a0, $t1
	jal	print_string

test_print_result_end:
	pop($ra)
	jr	$ra

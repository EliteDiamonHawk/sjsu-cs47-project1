
.text

#print string at given address
#a0: string address
print_string:
	li	$v0, 4
	syscall
	jr	$ra

#print string at given address with new line after
#a0: string address
println_string:
	push($ra)
	jal	print_string
	jal	println
	pop($ra)
	jr	$ra

#print new line
println:
	li	$a0, '\n'
	li	$v0, 11
	syscall
	jr	$ra

#print indent/tab
print_tab:
	li	$a0, '\t'
	li	$v0, 11
	syscall
	jr	$ra

#print space ' '
print_spc:
	li	$a0, ' '
	li	$v0, 11
	syscall
	jr	$ra

#print the integer in the given register
#a0: integer
print_integer:
	li	$v0, 1
	syscall
	jr	$ra

#print the integer in the given register with new line after
#a0: integer
println_integer:
	push($ra)
	jal	print_integer
	jal	println
	pop($ra)
	jr	$ra

#print the char in the given register
#a0: char
print_char:
	li	$v0, 11
	syscall
	jr	$ra

#print the char in the given register with new line after
#a0: char
println_char:
	push($ra)
	jal	print_char
	jal	println
	pop($ra)
	jr	$ra

#exit program
exit_program:
	li	$v0, 10
	syscall

#read integer from console
#returns: $v0
read_int:
	li 	$v0, 5
	syscall
	jr	$ra

#read string from console, storing in given address
#$a0: buffer address, $a1: buffer size
read_string:
	li 	$v0, 8
	syscall
	jr	$ra

#get length of a given string, not counting trailing \0
#$a0: string address, return: $v0
length_string:
	move    $t0, $a0	#t0 for foward pointer
length_string_loop_start:	#iterate pointer to the end of string
	lbu     $v0, 0($t0)
	beq     $v0, $zero, length_string_loop_end
	addiu   $t0, $t0, 1
	j       length_string_loop_start

length_string_loop_end:
	subu    $v0, $t0, $a0
	jr	$ra

#reverses a given string using stack
#a0: result string address, $a1 = source string address
reverse_string:
	push($zero)	#mark beginning of stack use. ends reversed string

reverse_string_loop_start:
	lbu     $t0, 0($a1)
	beq     $t0, $zero, reverse_string_loop_end

	push($t0)
	addiu   $a1, $a1, 1
	j       reverse_string_loop_start

reverse_string_loop_end:

reverse_string_loop2_start:
	pop($t0)
	beq     $t0, $zero, reverse_string_loop2_end

	sb      $t0, 0($a0)
	addiu   $a0, $a0, 1
	j       reverse_string_loop2_start

reverse_string_loop2_end:
	sb	$zero, 0($a0)
	jr	$ra

#print the values in hi
print_hi:
	mfhi 	$a0
	li	$v0, 1
	syscall
	jr	$ra

#print the values in lo
print_lo:
	mflo 	$a0
	li	$v0, 1
	syscall
	jr	$ra

#swaps values in hi and lo
swap_hi_lo:
	mfhi    $t0
	mflo    $t1
	mthi    $t1
	mtlo    $t0
	jr	$ra

#to do exponential multiplication
#a0: base, a1: exp, return: $v0
math_pow:
	li 	$v0, 1
	
math_pow_loop_start:
	beq 	$a1, $zero, math_pow_loop_end
	mul	$v0, $v0, $a0
	addi 	$a1, $a1, -1
	j	math_pow_loop_start
	
math_pow_loop_end:
	jr	$ra

#check if given character/byte is alphabetic
#make sure given char is unsigned
#a0: char, return: 1/0 in $v0
is_alpha:
	push($ra)
	jal	is_lower_alpha
	bgtz	$v0, is_alpha_end
	jal	is_upper_alpha
is_alpha_end:
	pop($ra)
	jr	$ra

#check if given character/byte is lower-case alphabetic
#make sure given char is unsigned
#a0: char, return: 1/0 in $v0
is_lower_alpha:
	addiu	$v0, $a0, -97	# 'a' == 97
	sltiu	$v0, $v0, 26
	jr	$ra

#check if given character/byte is upper-case alphabetic
#make sure given char is unsigned
#a0: char, return: 1/0 in $v0
is_upper_alpha:
	addiu	$v0, $a0, -65	# 'A' == 65
	sltiu	$v0, $v0, 26
	jr	$ra

#check if given character/byte is numeric
#a0: char, return: 1/0 in $v0
is_digit:
	addiu	$v0, $a0, -48	# '0' == 48
	sltiu	$v0, $v0, 10
	jr	$ra

#check if given character/byte is alphabetic or numeric
#make sure given char is unsigned
#a0: char, return: 1/0 in $v0
is_alnum:
	push($ra)
	jal	is_alpha
	bgtz	$v0, is_alnum_end
	jal	is_digit
is_alnum_end:
	pop($ra)
	jr	$ra

#check if given character/byte is a space ' '
#a0: char, return: 1/0 in $v0
is_space:
	seq	$v0, $a0, ' '
	jr	$ra

#check if given character/byte is a tab '\t'
#a0: char, return: 1/0 in $v0
is_tab:
	seq	$v0, $a0, '\t'
	jr	$ra

#check if given character/byte is a carriage return '\r'
#a0: char, return: 1/0 in $v0
is_carr_rtn:
	seq	$v0, $a0, '\r'
	jr	$ra

#check if given character/byte is a newline '\n'
#a0: char, return: 1/0 in $v0
is_nl:
	seq	$v0, $a0, '\n'
	jr	$ra

#check if given character/byte is a whitespace character
#a0: char, return: 1/0 in $v0
is_whitespc:
	push($ra)
	jal	is_space
	bnez	$v0, is_whitespc_end
	jal	is_tab
	bnez	$v0, is_whitespc_end
	jal	is_carr_rtn
	bnez	$v0, is_whitespc_end
	jal	is_nl

is_whitespc_end:
	pop($ra)
	jr	$ra

#check if given character/byte is a vowel
#a0: char, return: 1/0 in $v0
is_vowel:
	push($ra)
	jal	is_lower_vowel
	bnez	$v0, is_vowel_end
	jal	is_upper_vowel
is_vowel_end:
	pop($ra)
	jr	$ra

#check if given character/byte is a lowercase-vowel
#a0: char, return: 1/0 in $v0
is_lower_vowel:
	seq     $v0, $a0, 'a'
	bgtz    $v0, is_lower_vowel_end
	seq     $v0, $a0, 'e'
    	bgtz    $v0, is_lower_vowel_end
  	seq     $v0, $a0, 'i'
  	bgtz    $v0, is_lower_vowel_end
  	seq     $v0, $a0, 'o'
   	bgtz    $v0, is_lower_vowel_end
  	seq     $v0, $a0, 'u'
is_lower_vowel_end:
	jr	$ra

#check if given character/byte is a uppercase-vowel
#a0: char, return: 1/0 in $v0
is_upper_vowel:
	seq     $v0, $a0, 'A'
	bgtz    $v0, is_upper_vowel_end
	seq     $v0, $a0, 'E'
    	bgtz    $v0, is_upper_vowel_end
  	seq     $v0, $a0, 'I'
  	bgtz    $v0, is_upper_vowel_end
  	seq     $v0, $a0, 'O'
   	bgtz    $v0, is_upper_vowel_end
  	seq     $v0, $a0, 'U'
is_upper_vowel_end:
	jr	$ra

#return upper-alpha of given lower-alpha
#make sure given char is unsigned
#return $zero if not lower-alpha
#a0: char, returns: $v0
to_upper:
	push($ra)
	jal	is_lower_alpha
	beqz	$v0, to_upper_end
	addiu	$v0, $a0, -32	# 'A' == 65, 'a' == 97, 'A' - 'a' == -32
to_upper_end:
	pop($ra)
	jr	$ra

#return lower-alpha of given upper-alpha
#make sure given char is unsigned
#return $zero if not upper-alpha
#a0: char, return: $v0
to_lower:
	push($ra)
	jal	is_upper_alpha
	beqz	$v0, to_lower_end
	addiu	$v0, $a0, 32	# 'A' == 65, 'a' == 97, 'a' - 'A' == 32
to_lower_end:
	pop($ra)
	jr	$ra

#uppercase all alpha after a non-alnum. loweralpha all else
#done in place
#a0: string address
title_case_string:
	push($ra)
	push($s0)
	move	$s0, $a0
	
	lbu	$a0, 0($s0)	#current char store
	beqz	$a0, title_case_string_loop_end	#check for empty string
	jal	to_upper
	beqz	$v0, title_case_string_loop_start
	sb	$v0, 0($s0)
	
 title_case_string_loop_start:
	addi	$s0, $s0, 1
	lbu	$a0, 0($s0)
	beqz	$a0, title_case_string_loop_end	#termination condition
	
	#check previous char to decide lower/upper; upper if not alnum
	lbu	$a0, -1($s0)
	jal	is_alnum
	beqz	$v0, title_case_string_make_upper
	
	#make lower
	lbu	$a0, 0($s0)
	jal	to_lower
	beqz	$v0, title_case_string_loop_start
	sb	$v0, 0($s0)
	j	title_case_string_loop_start
	
 title_case_string_make_upper:
	lbu	$a0, 0($s0)
	jal	to_upper
	beqz	$v0, title_case_string_loop_start
	sb	$v0, 0($s0)
	j	title_case_string_loop_start

 title_case_string_loop_end:
	pop($s0)
	pop($ra)
	jr	$ra

#returns count of vowels, digits, and whitespace of string at given address/label
#a0: string address, a1: vowel count address, a2: digit count address, a3: whitespace count address
count_stats_string:
	push($ra)
	push($s0)
	push($s1)
	push($s2)
	push($s3)
	move    $s0, $a0
	move	$s1, $a1
	move	$s2, $a2
	move	$s3, $a3
	
	sw	$zero, 0($s1)	#zero out the counters
	sw	$zero, 0($s2)
	sw	$zero, 0($s3)
	
count_stats_string_loop_start:
	lbu     $a0, 0($s0)
	beq     $a0, $zero, count_stats_string_loop_end

#count vowel
	jal	is_vowel
	beqz	$v0, count_stats_string_digits
	lw	$t0, 0($s1)
	addi 	$t0, $t0, 1
	sw	$t0, 0($s1)
	j	count_stats_string_loop_iterate

count_stats_string_digits:
	lbu	$a0, 0($s0)
	jal	is_digit
	beqz	$v0, count_stats_string_whitespc
	lw	$t0, 0($s2)
	addi 	$t0, $t0, 1
	sw	$t0, 0($s2)
	
	j	count_stats_string_loop_iterate

count_stats_string_whitespc:
	lbu	$a0, 0($s0)
	jal	is_whitespc
	beqz	$v0, count_stats_string_loop_iterate
	lw	$t0, 0($s3)
	addi 	$t0, $t0, 1
	sw	$t0, 0($s3)
	
count_stats_string_loop_iterate:
	addiu   $s0, $s0, 1
	j       count_stats_string_loop_start

count_stats_string_loop_end:
	pop($s3)
	pop($s2)
	pop($s1)
	pop($s0)
	pop($ra)
	jr	$ra
	
	
#converts a character to digit
#a0: character, return: digit as integer in $v0, 1/0 if successful in $v1
char_to_integer:
	push($ra)
	push($a0)
	jal	is_digit
	move	$v1, $v0
	pop($v0)
	subiu	$v0, $v0, '0'
	pop($ra)
	jr	$ra

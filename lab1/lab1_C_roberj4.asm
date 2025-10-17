# Homework 1
# Name: Robert Ji
# Net ID: roberj4

.globl main

.data
prompt_string: .asciiz "Enter a string (max 100 chars): "
err_string: .asciiz "\nERROR"
prompt_type: .asciiz "(L)ength, (S)paces, (D)igits, or Symbols(#)? "
prompt_length: .asciiz "Length of string: "
prompt_space: .asciiz "# of spaces: "   
prompt_digit: .asciiz "# of digits: "
prompt_symbols: .asciiz "# of symbols: "
user_input: .space 101
user_action: .space 2
endl: .asciiz "\n"

.align 2
    # Your data declarations go here 

.text
main:
    # Your code goes here
    li $v0, 4
    la $a0, prompt_string
    syscall # prompt user for ASCII str
    
    li $v0, 8
    la $a0, user_input
    li $a1, 101
    syscall # get user input
    
    li $v0, 4
    la $a0, prompt_type
    syscall # prompt for action
    
    li $v0, 8
    la $a0, user_action
    li $a1, 2
    syscall # get user action
    
    # action check
    la $t0, user_action
    lb $t1, 0($t0)
    
    li $t2, 76 
    beq $t1, $t2, length_count
    li $t2, 83
    beq $t1, $t2, space_count
    li $t2, 68
    beq $t1, $t2, digit_count
    li $t2, 35
    beq $t1, $t2, symbol_count
    
    # invalid
    li $v0, 4
    la $a0, err_string
    syscall
    
    la $a0, endl
    syscall
    
    j end
    
    length_count:
    	la $t0, user_input
    	li $t3, 0
    length_loop:
    	lb $t4, 0($t0)
    	beq $t4, 10, length_return
    	beq $t4, 0, length_return
    	addi $t3, $t3, 1
    	addi $t0, $t0, 1
    	j length_loop
    length_return:
    	li $v0, 4
    	la $a0, prompt_length
    	syscall
    	
    	li $v0, 1
    	move $a0, $t3
    	syscall
    	j toggle
    	
    space_count: 
    	la $t0, user_input
    	li $t3, 0
    space_loop:
    	lb $t4, 0($t0)
    	beq $t4, 10, space_return
    	beq $t4, 0, space_return
    	li $t5, 32
    	bne $t4, $t5, space_continue
    	addi $t3, $t3, 1
    space_continue:
    	addi $t0, $t0, 1
    	j space_loop
    space_return:
    	li $v0, 4
    	la $a0, prompt_space
    	syscall
    	
    	li $v0, 1
    	move $a0, $t3
    	syscall
    	
    	j toggle
    
    digit_count:
    	la $t0, user_input
    	li $t3, 0
    digit_loop:
    	lb $t4, 0($t0)
    	beq $t4, 10, digit_return
    	beq $t4, 0, digit_return
    	li $t5, 48
    	blt $t4, $t5, digit_continue
    	li $t5, 57
    	bgt $t4, $t5, digit_continue
    	
    	addi $t3, $t3, 1
    digit_continue:
    	addi $t0, $t0, 1
    	j digit_loop
    digit_return:
    	li $v0, 4
    	la $a0, prompt_digit
    	syscall
    	
    	li $v0, 1
    	move $a0, $t3
    	syscall
    	
    	j toggle
    	
    symbol_count: 
    	la $t0, user_input
    	li $t3, 0
    symbol_loop:
    	lb $t4, 0($t0)
    	beq $t4, 10, symbol_return
    	beq $t4, 0, symbol_return
    	
    	li $t5, 32
    	ble $t4, $t5, symbol_continue
    	
    	# digits
    	li $t5, 48
    	blt $t4, $t5, symbol_found
    	li $t5, 57
    	ble $t4, $t5, symbol_continue
    	
    	# uppercase
    	li $t5, 65
    	blt $t4, $t5, symbol_found
    	li $t5, 90
    	ble $t4, $t5, symbol_continue
    	
    	#lowercase
    	li $t5, 97
    	blt $t4, $t5, symbol_found
    	li $t5, 122
    	ble $t4, $t5, symbol_continue
    
    symbol_found:
    	addi $t3, $t3, 1
    symbol_continue:
    	addi $t0, $t0, 1
    	j symbol_loop
    symbol_return: 
    	li $v0, 4
    	la $a0, prompt_symbols
    	syscall
    	
    	li $v0, 1
    	move $a0, $t3
    	syscall
    	
    
    # toggle all letter chars
    toggle:
    	la $t0, user_input
    toggle_loop:
    	lb $t1, 0($t0)
    	beq $t1, 10, toggle_return
    	beq $t1, 0, toggle_return
    	
    	li $t2, 65
    	blt $t1, $t2, check_lowercase
    	li $t2, 90
    	bgt $t1, $t2, check_lowercase
    	addi $t1, $t1, 32
    	sb $t1, 0($t0)
    	j toggle_continue
    check_lowercase:
    	li $t2, 97
    	blt $t1, $t2, toggle_continue
    	li $t2, 122
    	bgt $t1, $t2, toggle_continue
    	
    	addi $t1, $t1, -32
    	sb $t1, 0($t0)
    	
    toggle_continue:
    	addi $t0, $t0, 1
    	j toggle_loop
    
    toggle_return:
    	li $v0, 4
    	la $a0, endl
    	syscall
    	
    	la $a0, user_input
    	syscall
	
    end: 
    	li $v0, 10
    	syscall # exit	
    
    

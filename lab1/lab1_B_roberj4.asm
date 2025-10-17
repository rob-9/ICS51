# Robert Ji
# roberj4

.globl main
.text
main:
li $v0, 4
la $a0, prompt
syscall #prompt the user

li $v0, 8
la $a0, str
li $a1, 5
syscall # read string


li $v0, 4
la $a0, endl
syscall # new line

la $a0, str
syscall # print str

la $a0, endl
syscall # new line

li $v0, 1
la $t0, str
lw $t1, 0($t0)
move $a0, $t1
syscall # print 4 bytes

li $v0, 4
la $a0, endl
syscall # new line

li $v0, 35
move $a0, $t1
syscall # print binary

li $v0, 4
la $a0, endl
syscall # new line

li $v0, 34
move $a0, $t1
syscall # print hexa

li $v0, 4
la $a0, endl
syscall # new line

# add 1 to t1 and store resultant word into label: str
addi $t1, $t1, 1
la $t0, str
sw $t1, 0($t0)


la $a0, str
syscall # print new str

la $a0, endl
syscall

# place 2nd char in str to $t2
lb $t2, 1($t0)

# conditional print
andi $t3, $t2, 1
beq $t3, $zero, even

# odd
la $a0, odd_message
syscall
j end

even:   
la $a0, even_message
syscall


end: 
la $a0, endl
syscall # new line
li $v0, 10
syscall # exit	



.data
prompt: .asciiz "Enter 4 characters: "
endl: .asciiz "\n"
even_message: .asciiz "EVEN"
odd_message: .asciiz "ODD"
.align 2
str: .asciiz "????"


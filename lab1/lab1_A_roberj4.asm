# Robert Ji
# roberj4

.globl main
.text
main:
li $v0, 4
la $a0, prompt
syscall

li $v0, 5
syscall

# load address of num into $t0 (regA)
la $t0, num

# load value stored in memory at num (regB)
lw $t1, 0($t0)
add $t2, $t1, $v0
move $a0, $t2

# print out result (a0)
li $v0, 1
syscall

li $v0, 4
la $a0, endl     # print newline
syscall

# negate and print
sub $t3, $zero, $t2    # negate
la $t4, value
sw $t3, 0($t4)

move $a0, $t3
li $v0, 1              # print 
syscall

li $v0, 4
la $a0, endl
syscall

la $a0, abcd
syscall

la $a0, endl
syscall

sll $t5, $t3, 8
move $a0, $t5
li $v0, 1
syscall

sw $t5, 0($t4)

li $v0, 4
la $a0, endl
syscall

la $a0, abcd
syscall

li $v0, 10
syscall

.data
num: .word 2010 # an integer
prompt: .asciiz "Enter an integer:"  # a string
endl: .asciiz "\n"   # a string
.align 2
abcd: .ascii "ABCD"  # 4-character array
value: .word -100    # an integer
moreabcs: .asciiz "EFGHIJK"  # a string

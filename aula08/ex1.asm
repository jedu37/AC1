	.data
str:	.asciiz "2016 e 2020 sao anos bissextos"
str_bin:.asciiz "101101"
	.eqv p_i10,1
	
	.text
	#.globl main

main:	addiu $sp,$sp,-4 #
        sw $ra,0($sp)	  # save $ra

	#la $a0,str       # ex1_b
	la $a0,str_bin	  # ex1_c
	#jal atoi         # atoi(str) # ex1_b
	jal atoi_bin         # atoi(str_bin) ex1_c
	move $a0,$v0     #
	li $v0,p_i10     #
	syscall          # print_i10(atoi(str)) 
	
	lw $ra,0($sp)    # restore $ra
	addiu $sp,$sp,4  # 
	jr $ra 

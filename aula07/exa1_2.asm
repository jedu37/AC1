# Mapa de Registos
#
#
#

	.data
array:	.space 200	#array[50] , 50*4 = 200
str0:	.asciiz "Size of array : "
str1:	.asciiz "array["
str2:	.asciiz "] = "
str3:	.asciiz "Enter the value to be inserted: "
str4:	.asciiz "Enter the Position: "
str5:	.asciiz "\nOriginal Array: "
str6:	.asciiz "\nModified Array: "
	.eqv p_str,4
	.eqv p_i10,1
	.eqv r_i,5
	
	.text
	.globl main

main:	addiu $sp,$sp,-20	#
	sw $ra,0($sp)		# save $ra
	sw $s0,4($sp)		# save $s0
	sw $s1,8($sp)		# save $s1
	sw $s2,12($sp)		# save $s2
	sw $s3,16($sp)		# save $s3
	
	la $a0,str0		#
	li $v0,p_str		#
	syscall			# print_string("Size of array: ");
	
	li $v0,r_i		#
	syscall			#
	move $s1,$v0		# array_size = $s1 = read_int()
	
	li $s0,0		# i = $s0 = 0
	
for1:	bge $s0,$s1,end_f1	# for( i < array_size){
	
	la $a0,str1		#
	li $v0,p_str		#
	syscall			# print_string("array[");
	
	move $a0,$s0		#
	li $v0,p_i10		#
	syscall			# print_int10(i);
	
	la $a0,str2		#
	li $v0,p_str		#
	syscall			# print_string("] = ");
	
	li $v0,r_i		#
	syscall			#
	move $t0,$v0		# $t0 = read_int()
	
	la $t1,array		# $t1 = array
	
	sll $t2,$s0,2		# $t2 = i*4
	add $t2,$t2,$t1		# $t2 = *array[i]
	sw $t0,0($t2)		# array[i] = $t0
	
	addi $s0,$s0,1		# i++;
	j for1			#}

end_f1: la $a0,str3		#
	li $v0,p_str		#
	syscall			# print_string("Enter the value to be inserted: ");
	
	li $v0,r_i		#
	syscall			#
	move $s2,$v0		# $s2 = read_int()
	
	la $a0,str4		#
	li $v0,p_str		#
	syscall			# print_string("Enter the Position: ");
	
	li $v0,r_i		#
	syscall			#
	move $s3,$v0		# $s3 = read_int()
	
	la $a0,str5		#
	li $v0,p_str		#
	syscall			# print_string("\nOriginal Array: ");
	
	la $a0,array		#
	move $a1,$s1		#
	jal print_array		# print_array(array, array_size);
	
	la $a0,array		#
	move $a1,$s2		#
	move $a2,$s3		#
	move $a3,$s1		#
	jal insert		# insert(array,insert_value, insert_pos, array_size);
	
	la $a0,str6		#
	li $v0,p_str		#
	syscall			# print_string("\nModified Array: ");
	
	la $a0,array		#
	addi $s1,$s1,1		# array_size++
	move $a1,$s1		#
	jal print_array		# print_array(array, array_size+1);
	
	lw $ra,0($sp)		# restore $ra
	lw $s0,4($sp)		# restore $s0
	lw $s1,8($sp)		# restore $s1
	lw $s2,12($sp)		# restore $s2
	lw $s3,16($sp)		# restore $s3
	addiu $sp,$sp,20	#
	li $v0,0
	jr $ra
	
							
	
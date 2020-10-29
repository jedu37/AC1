# Mapa de Registos
#  $t0 - value
#  $t1 - bit
#  $t2 - i
#  $t3 - remainder
#  $t4 - flag 

	.data
str1:	.asciiz		"Introduza um numero:"
str2:	.asciiz		"\n O valor em binarioe':"
	
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	print_char,11
	
	.text
	.globl main

main:	la $a0,str1		#
	li $v0,print_string	# (instrução virtual)
	syscall			# print_string(str1);
				#
	li $v0,read_int		#
	syscall			#
	move $t0,$v0		# value = read_int();
				#
	la $a0,str2		#
	li $v0,print_string	#
	syscall			# print_string("\nO valor em binario e':")
				#
	li $t2,0		# i = 0
	li $t4,0		# falg = 0
				#
do:				# do{
	andi $t1,$t0,0x80000000	#   (instrução virtual)
	srl $t1,$t1,31		#   bit = ( value & 0x80000000 ) >> 31;
				#
	beq $t4,1,skip1		#  
	beqz $t1,endif		#
				#	if(flag = 1 || bit != 0 ) 
skip1:	li $t4,1		#          flag = 1
				#
	rem $t3,$t2,4 		#   remainder = i % 4
	bnez $t3,skip		#   if ( ( i % 4 ) == 0 )
				#
	li $a0,' '		#
	li $v0,print_char	#
	syscall			#     print_char(' ');
				#	
skip:	addi $t1,$t1,0x30	#
				#
	move $a0,$t1		#
	li $v0,print_char	#
	syscall			#     print_char('0'+bit);
				#
				#
endif:				#
	sll $t0,$t0,1		#   value = value << 1;
	addi $t2,$t2,1		#   i++
	blt $t2,32,do		# }while ( i < 32 )
				#
endfor:	jr $ra			#
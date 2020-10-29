# Mapa de Registos
#  $t0 - soma
#  $t1 - value
#  $t2 - i
	
	.data
str1:	.asciiz 	"Introduza o numero:"
str2:	.asciiz		"Valor ignorado\n" 
str3:	.asciiz		"A soma dos positivos e':"
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	print_int10,1
	
	.text
	.globl main

main:	li $t0,0		# soma = 0;
	li $t2,0		# i = 0;
				#
for:	bge $t2,5,endfor	# while( i < 5 ) {
				#
	la $a0,str1		#
	li $v0,print_string	#
	syscall			#   print_string("Introduza um numero:");
				#
	li $v0,read_int		#
	syscall			#
	move $t1,$v0		#   value = read_int();
				#
	ble $t1,$0,else		#   if ( value > 0)
	add $t0,$t1,$t0		#     soma += value;
	j endif			#
else:				#   else
	la $a0,str2		#
	li $v0,print_string	#
	syscall			#     print_string("Valor ignorado\n");
				#
endif:	addi $t2,$t2,1		#   i++;
	j for			# }
				#
endfor:				#
	la $a0,str3		#
	li $v0,print_string	#
	syscall			# print_string("A soma dos positivos e':"
				#
	move $a0,$t0		#
	li $v0,print_int10	#
	syscall			# print_int10(soma);
				#
	jr $ra			#
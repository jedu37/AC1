# Mapa de Registos
# $t0 - res
# $t1 - i
# $t2 - mdor
# $t3 - mdo
# $t4 - temp

	.data
str1:	.asciiz		"Introduza dois numeros: "
str2:	.asciiz		"Resultado: "
	
	.eqv print_string,4
	.eqv read_int,5
	.eqv print_int10,1

	.text
	.globl main
	
main:	li $t0,0		# res = 0
	li $t1,0		# i = 0
				#
	la $a0,str1		#
	li $v0,print_string	#
	syscall			# print_string("Introduza dois numeros: ");
				#
	li $v0,read_int		#
	syscall			#
	andi $t2,$v0,0x0F	# mdor = read_int() & 0x0F
				#
	li $v0,read_int		#
	syscall			#
	andi $t3,$v0,0x0FFFF	# mdo = read_int() & 0x0F
				#
while:	beqz $t2,end		# while ( (mdor != 0) &&
	bge $t1,16,end		#	(i++ < 16) ){
				#
	andi $t4,$t2,0x00000001	#   mdor & 0x00000001
	beqz $t4,skip		#   if ( ( mdor & 0x00000001) != 0){
	add $t0,$t0,$t3		#		res = res + mdo;}
				#
skip:	sll $t3,$t3,1		#   mdo = mdo << 1
	srl $t2,$t2,1		#   mdor = mdor >> 1
	addi $t1,$t1,1		#   i++
				#
	j while			#}
				#
end:	la $a0,str2		#
	li $v0,print_string	#
	syscall			# print_string("Resultado: #")
				#
	move $a0,$t0		#
	li $v0,print_int10	#
	syscall			# print_int10(res)
				#
	li $v0,10		#
	syscall			# system.exit
	jr $ra			#
# Mapa de registos
# *p - $t0
# *pLast - $t1

	.data
st1:	.asciiz "Array"
st2:	.asciiz "de"	
st3:	.asciiz "ponteiros"

array:	.word st1,st2,st3
	.eqv SIZE,3
	.eqv print_str,4
	.eqv print_c,11
	
	.text
	.globl main
main:	la $t0,array		#$t0 = p = array
	li $t1,SIZE		#$t1 = SIZE
	sll $t1,$t1,2		#$t1 = SIZE * 4
	addu $t1,$t0,$t1	#$t1 = pLast = array + SIZE

while:	bge $t0,$t1,endw	#while(p < pLast)
	
	lw $a0,0($t0)		# $a0 = *p
	li $v0,print_str	#
	syscall			# print_str(array[i]);
	
	li $a0,'\n'		#
	li $v0,print_c		#
	syscall			# print_char('\n')
	
	addiu $t0,$t0,4		# p++
	j while

endw:	li $v0,10		#
	syscall			#exit
 	jr $ra 			# termina o programa 
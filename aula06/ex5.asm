# Mapa de Registos
# $t0 - argc
# $t1 - argv - p;
# $t2 - pLast;
# $t3 - p
# $t4 - *j
# $t5 - nC
# $t6 - nL
# $t7 - mC
# $t8 - mCA

	.data
str1: 	.asciiz "\nArgumento("
str2:	.asciiz "): "
str3:   .asciiz "\n->Caracteres: "
str4:	.asciiz "\n->Letras: "
str5:	.asciiz "\nMaior: "
	.align 2
	.eqv print_i10,1
	.eqv print_str,4
	.text
	.globl main

main:	li $t7,0		# $t7 = mC = 0
	move $t0,$a0		#$t1 = argc
	move $t1,$a1		#$t2 = $(argv[0])
	
	sll $t2,$t0,2		#$t2 = argc*4
	addu $t2,$t2,$t1	#$t2 = argv + argc = pLast

for:	bge $t1,$t2,endfor	#for(p < pLast)
	
	la $a0,str1		#
	li $v0,print_str	#
	syscall			# print_str("\nArgumento(")
	
	lw $t3,0($t1)		# $t3 = *p
	
	move $a0,$t3		#
	li $v0,print_str	#
	syscall			# print_str(argumento)
	
	la $a0,str2		#
	li $v0,print_str	#
	syscall			# print_str("): ")
	
	li $t5,0		# $t5 = nC = 0
	li $t6,0		# $t6 = nL = 0
	
while:	lb $t4,0($t3)		#
	beq $t4,'\0',endw	#while( *j != '\0')
	addi $t5,$t5,1		# nC++;
				# 0x41 - A || 0x5a - Z || 0x61 - a || 0x7a - z
if:	blt $t4,'A',endif	# if((*j >= A &&  
	ble $t4,'Z',cond  	#     *j <= Z) ||
	blt $t4,'a',endif	#    (*j >a &&
	bgt $t4,'z',endif	#     *j < z)){
cond:	addi $t6,$t6,1		# 	nL++;

endif:	addiu $t3,$t3,1		#j++;
	j while

endw:	la $a0,str3		#
	li $v0,print_str	#
	syscall			# print_str("\n->Caracteres:")
	
	move $a0,$t5		#
	li $v0, print_i10	#
	syscall			# print_int(nC)
	
	la $a0,str4		#
	li $v0,print_str	#
	syscall			# print_str(""\n->Letras")
	
	move $a0,$t6		#
	li $v0, print_i10	#
	syscall			# print_int(nL)
	
if2:	ble $t5,$t7,endi	# if( nC > mC){
	move $t7,$t5		# mC = nC
	move $t8,$t1		# mCA = p
	
endi:	addiu $t1,$t1,4		#p++
	j for

endfor:	la $a0,str5		#
	li $v0,print_str	#
	syscall			# print_str("\nMaior:")
	lw $a0,0($t8)		#		
	li $v0,print_str	#
	syscall			# print_str("\nMaior:")
		
	li $v0,10		#
	syscall			#exit
 	jr $ra 			# termina o programa 
	.data
	.text
	.globl main
main:	li $t0,0x12345678	#instrução virtual (decomposta 
				#em duas instruções nativas)
	sll $t2,$t0,1		#Shift Left Logical de $t1 por 1 bit
	srl $t3,$t0,1		#Shift Right Logical de $t1 por 1 bit
	sra $t4,$t0,1		#Shift Right Arithmetic de $t1 por 1 bit
	jr $ra			#fim do programa
	.data
	.text
	.globl main
main:	li  $t0,val_desejado 	#Carrega para $t0 o valor desejado
	srl $t1,$t0,1	 	#Shift Right Logical de 1 bit a $t0
	xor $t1,$t0,$t1		#Xor de St1 e $t0, fazendo assim código gray
	jr $ra			#final de programa
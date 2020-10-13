#Var Map
#$t0 -> gray
#$t1 -> num
#$t2 -> bin
#$t3 -> temp var

	.data
	.text
	.globl main
main:	li $t0,val_desejado	#gray = valor desejado
	move $t1,$t0		#num = gray
	srl $t3,$t1,4		#temp = num >> 4
	xor $t1,$t1,$t3		#num = num ^ temp
	srl $t3,$t1,2		#temp = num >> 2
	xor $t1,$t1,$t3		#num = num ^ temp
	srl $t3,$t1,1          #temp = num >> 1
	xor $t1,$t1,$t3		#num = num ^ temp
	move $t2,$t1		#bin = num
	jr $ra			#end
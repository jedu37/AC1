	.data
	.text
	.globl main
main:	ori $t0,$0,val_1	#substituir val_1 e val_2 pelos
	ori $t1,$0,val_2	#valores de entrada desejados
	and $t2,$t0,$t1		#$t2 = $t0 & $t1 ( and bit a bit)
	or  $t3,$t0,$t1		#$t3 = $t0 | $t1 ( and bit a bit)
	nor $t4,$t0,$t1		#$t4 = $t0 ^ $t1 ( and bit a bit)
	xor $t5,$t0,$t1		#$t5 = $t0 xor $t1 ( and bit a bit)
	jr $ra			# fim do programa
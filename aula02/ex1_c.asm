	.data
	.text
	.globl main
main:	ori $t0,$0,0xe543	# valor a negar
	nor $t1,$t0,$t0		# negar
	jr $ra			# fim do programa
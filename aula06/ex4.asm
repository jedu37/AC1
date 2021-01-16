# Mapa de Registos
# $t0 - i
# $t1 - argc
# $t2 - argv;
# $t3 - argv[i]
	.data
str1: 	.asciiz "Nr. de parâmetros: "
str2:	.asciiz "\nP"
str3:   .asciiz ": "
	.align 2
	.eqv print_i10,1
	.eqv print_str,4
	.text
	.globl main

main:	li $t0,0		#$t0 i = 0;
	move $t1,$a0		#$t1 = argc
	move $t2,$a1		#$t2 = $(argv[0])
	
	la $a0, str1		#
	li $v0,print_str	#
	syscall			#print_str("Nr. de parametros: ");
	
	move $a0,$t1
	li $v0, print_i10
	syscall			#print_int(argc);

for:	bge $t0,$t1,endfor	#for(i < argc)

	la $a0,str2		#
	li $v0,print_str	#
	syscall			#print_str("\nP");
	
	move $a0,$t0		#
	li $v0, print_i10	#
	syscall			#print_int10(i);
	
	la $a0,str3		#
	li $v0,print_str	#
	syscall			#print_str(": ");
	
	sll $t3,$t0,2		#$t3 = i * 4
	addu $t3,$t2,$t3	#$t3 = *array[i]
	
	lw $a0,0($t3)		#$a0 = array[i]
	li $v0,print_str	#
	syscall			#print_str(argv[i]);
	
	addi $t0,$t0,1		#i++
	j for

endfor:li $v0,10		#
	syscall			#exit
 	jr $ra 			# termina o programa 
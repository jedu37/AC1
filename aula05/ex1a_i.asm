 	.data
str1: 	.asciiz "\nIntroduza um numero: "

str2: 	.asciiz "\nConteudo do array:\n"

str3: 	.asciiz "; "
	
	.align 2
lista:	.space 40 		# SIZE * 4
 	
 	.eqv FALSE,0
 	.eqv TRUE,1
 	.eqv SIZE,10
 	
 	.eqv read_int,5
 	.eqv print_string,4
 	.eqv print_int10,1
 	
 	.text
 	.globl main
main: 	la $t0,lista 		# p = lista
 	
 	li $t2,SIZE 		#
 	sll $t2,$t2,2 		#
 	addu $t2,$t0,$t2 	# $t2 = lista + SIZE;

loading:bgeu $t0,$t2,endload	# while(p < lista+SIZE) {
	la $a0,str1		#
 	li $v0,print_string	#
 	syscall	 		# print_string("\nIntroduza um numero: ");
 	
 	li $v0,read_int		#
 	syscall 		#
	sw $v0,0($t0) 		# *p = read_int();
	
	addiu $t0,$t0,4 	# p++;
 	j loading 		# }
 	
endload: 			# código para leitura de valores
#-----------------------------------------------------------------------
	la $t6,lista 		# 	
 	li $t2,SIZE
 	sub $t2,$t2,1
for1: 	bge $t5,$t2,endfor1 	# while(i < SIZE-1){
	addi $t0,$t5,1		# j = i+1
for2: 	bge $t0,SIZE,endfor2 	# while(j < SIZE){
	
	sll $t7,$t5,2 		# $t7 = i * 4
 	addu $t7,$t7,$t6 	# $t7 = &lista[i]
 	lw $t8,0($t7) 		# $t8 = lista[i]
 	
 	sll $t1,$t0,2 		# $t1 = i * 4
 	addu $t1,$t1,$t6 	# $t1 = &lista[j]
 	lw $t9,0($t1) 		# $t9 = lista[j]

if:  	ble $t8,$t9,endif 	# if(lista[i] > lista[j){
	sw $t9,0($t7)		# lista[i] = $t9
	sw $t8,0($t1) 		# lista[j] = $t8
 				# }
endif:	addi $t0,$t0,1 		# j++;
	j for2			#
endfor2:addi $t5,$t5,1 		# i++;
	j for1			# }
endfor1:			# }
	
#-----------------------------------------------------------------------
 	la $t0,lista 		# p = lista
 	
 	li $t2,SIZE 		#
 	sll $t2,$t2,2 		#
 	addu $t2,$t0,$t2 	# $t2 = lista + SIZE;
 	
writing:bgeu $t0,$t2,endw	# while(p < lista+SIZE) {

 	lw $t1,0($t0) 		# $t1 = *p;
 	
 	move $a0,$t1
 	li $v0,print_int10	
 	syscall			# print_int10( *p );
 	
 	la $a0,str3
 	li $v0,print_string
 	syscall		 	# print_string("; ");
 	
 	addiu $t0,$t0,4 	# p++;
	j writing		# }
	
 endw:				# codigo de impressao do
 				# conteudo do array
#-----------------------------------------------------------------------
 	li $v0,10		#
	syscall			#exit
 	jr $ra 			# termina o programa 
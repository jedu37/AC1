# Mapa de registos
# ...
# houve_troca: $t4
# p: $t5
# pUltimo: $t6
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
 	la $t5,lista 		# $t5 = &lista[0]
 	li $t6,SIZE 		#
 	subu $t6,$t6,1 		# $t6 = SIZE – 1
 	sll $t6,$t6,2 		# $t6 = (SIZE – 1) * 4
 	addu $t6,$t5,$t6 	# $t6 = lista + (SIZE – 1)
do: 	 			# do {
 	li $t4,FALSE		# houveTroca = FALSE;
 	
 				# for(
 	la $t5,lista 		#  p = &lista[0];
for:	bge $t5,$t6,endfor	#  p < pUltimo)
	lw $t7,0($t5) 		#  $t7 = *p
	lw $t8,4($t5)          #  $t8 = *(p+1)

if:	ble $t7,$t8,endif	#  if (*p > *(p+1)){
	sw $t7,4($t5) 		#  *(p+1) = $t8
	sw $t8,0($t5)          #  *p = $t7
	li $t4,TRUE		#  houveTroca = TRUE;
				#}
				
endif:  addiu $t5,$t5,4 	# p++;
	j for
	
endfor: 			# }
 	bnez $t4,do 		# } while(houve_troca == TRUE);
	
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
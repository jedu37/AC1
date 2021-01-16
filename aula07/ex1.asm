# O argumento da função é passado em $a0
# O resultado é devolvido em $v0
# Sub-rotina terminal: não devem ser usados registos $sx
	.data
str: 	.asciiz "Arquitetura de Computadores I"
	.eqv print_i10, 1
	.text
	#.globl main

#STRLEN (determina e devolve a dimensão de uma string)
#Mapa de registos
#$t0: s* 
#$t1: len
strlen: 	li $t1,0 		# len = 0;
stlw: 		lb $t0,0($a0) 		# while(*s++ != '\0')
 		addiu $a0,$a0,1 	#
 		beq $t0,'\0',stlendw 	# {
 		addi $t1,$t1,1		# len++;
 		j stlw			# }
stlendw:	move $v0,$t1 		# return len;
 	 	jr $ra 			# 
	
#MAIN
#Mapa de registos
#$a0: argumentos 
#$v0: resultado
main:	addiu $sp, $sp, -4	#reserva espaço
	sw $ra, 0($sp)		#guarda o valor de $a0
	
	la $a0, str		#$a0 = str
	jal strlen		#strlen(str)
	move $a0, $v0
	li $v0, print_i10	#print_int10(strlen(char))
	syscall
	
	lw $ra, 0($sp)		#atualiza o valor de $a0
	addiu $sp,$sp,4		#liberta o espaço reservado
	jr $ra			#termina o programa

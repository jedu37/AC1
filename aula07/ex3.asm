	.data
str1:	.asciiz "I serodatupmoC ed arutetiuqrA"
str2:	.space 31
str3:	.asciiz "\n"
str4:	.asciiz "String demasiado comprida: "
	.eqv SIZE,30	
	.eqv MAX_SIZE, 31
	.eqv print_string,4
	.eqv print_int10,1
	.text
	#.globl main

#STRCOPY (cria cópia da string no endereço destino)
#Mapa de Registos
#$s0 - src
#$s1 - dst
#$t0 - aux
strcpy: 	addiu $sp,$sp,-12 	#cria espaço no stack
		sw $ra,0($sp)		#para salvaguardas
		sw $s0,4($sp)		#os registos $ra, $s0, $s1
		sw $s1,8($sp)		#
		
		move $s0,$a1		#$s0 = src = $a1
		move $s1,$a0		#$s1 = dst = $a0
		move $v0,$a0		#$v0 = dst = $a0
		
stcyw:		lb $t0, 0($s0)		#$t0 = *src
		sb $t0, 0($s1)		#*dst = $t0
		beq $t0,'\0',stcyew	#while( *src != '\0')
		addiu $s0,$s0,1		# src ++
		addiu $s1,$s1,1		# dst ++
		j stcyw

stcyew:		sw $ra,0($sp)		#retorna do stack
		sw $s0,4($sp)		#os registos $ra, $s0, $s1
		sw $s1,8($sp)		#
		addiu $sp,$sp,12 	#retorna o stackk pointer para o topo
		jr $ra # termina a sub-rotina 

#MAIN
main:	addiu $sp, $sp, -4		#reservar espaço na Stack
	sw  $ra, 0($sp)			#guardar o valor de $ra
	
	la  $a0, str1			#str1
	jal strlen			#strlen(str1);
if:	bgt $v0, MAX_SIZE,else		#if(strlen(str1)) <= MAX_SIZE
	la $a0,str2
	la $a1,str1
	jal strcpy			#strcopy(str2, str1);
	
	move $t1, $v0
	move $a0, $t1
	li $v0, print_string
	syscall				#print_string(strcopy(str2, str1));
	
	la $a0, str3
	li $v0, print_string
	syscall				#print_string("\n")
	
	move $a0,$t1
	jal strrev			#strrev(str2);
	
	move $a0, $v0
	li $v0,print_string
	syscall				#print_string(strrev(str2));
	
	li $t0, 0			#exit_value = 0
	j end
	
else:	la $a0, str4
	li $v0, print_string		
	syscall 			#print_string(str4);
	
	la $a0, str1
	jal strlen			#strlen(str1);
	
	move $a0, $v0
	li $v0,print_int10
	syscall				#print_int10(strlen(str1));
	
	li $t0, -1			#exit_value = -1
	
end:	lw $ra, 0($sp)
	addiu $sp,$sp,4			#reserva espaço na stack
	
	move $v0,$t0			#return exit_value
	jr $ra				#termina o programa
		

#Mapa de registo --> main
#str1 -> $t0
#str2 -> $t1
	.data
str1:	.asciiz "Arquitetura de "
str2:	.space 50
str3:	.asciiz "\n"
str4:	.asciiz "Computadores I"
	.eqv print_string,4
	.text
	#.globl main
	
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0, str2
	la $a1, str1
	jal strcpy		#strcopy(str2, str1)
	
	la $a0, str2
	li $v0,print_string
	syscall			#print_string(str2);
	
	la $a0,str3
	li $v0,print_string
	syscall			#print_string("\n");
	
	 la $a0, str2
	 la $a1, str4
	 jal strcat		#strcat(str2, str4);
	 
	 move $a0, $v0
	 li $v0, print_string
	 syscall		#print_string(strcat(str2, str4));
	 
	 lw $ra, 0($sp)
	 addiu $sp,$sp,4	#liberta espaço na stack
	 
	 jr $ra			#termina o programa

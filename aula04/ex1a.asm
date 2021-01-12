# Mapa de Registos
# p:   	$t0
# *p:	$t1

  	.data
  	.eqv	SIZE,20
	.eqv	read_string,8
	.eqv	print_string,4
str:	.space	SIZE
	.align 2
msg:	.asciiz "Introduza uma string: "

	.text
	.globl main
main:	la $a0,msg		#
	li $v0,print_string	#
	syscall			# print_string("Introduza uma string: ");
	
	la $a0,str		#
	li $a1,SIZE 		#
	li $v0,read_string	#
	syscall			# read_string(str,SIZE)
	
	la $t0,str		# p = str;
	
while:	lb $t1,0($t0)		# 
	beq $t1,'\0',endw	# while(*p != '\0'){
	li $t2,'a'
	li $t3,'A'
	subu $t2,$t2,$t3	# 'a' + 'A';
	subu $t1,$t1,$t2	# *p – 'a' + 'A';
	sb $t1,0($t0)		# *p = *p – 'a' + 'A'; // 'a'=0x61, 'A'=0x41, 'a'-'A'=0x20
	addi $t0,$t0,1		# p++;
	j while

endw:	la $a0,str		#
	li $v0,print_string	#
	syscall			# print_string(str);
	
	li $v0,10		#
	syscall			# exit
 	jr $ra 			# termina o programa 
	
	
	
	
	
	
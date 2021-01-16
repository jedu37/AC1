# Mapa de registos
# $t0 - i
# $t1 - array
# $t2 - j
# $t3 - array[i]

	.data	
st1:	.asciiz "Array"
st2:	.asciiz "de"	
st3:	.asciiz "ponteiros"
str:	.asciiz "\nString #"
point:	.asciiz ": "
	.align 2

array:	.word st1,st2,st3
		
	.eqv SIZE,3
	.eqv print_str,4
	.eqv print_i10,1 
	.eqv print_c,11
		
	.text
	.globl main
main:	li $t0,0		# $t0 = i = 0
	la $t1,array		# $t1 = array

for:	bge $t0,SIZE,endfor	# while(i<SIZE)
	
	la $a0, str		#				
	li $v0, print_str	#
	syscall			#print_string("\nString #");
	
	move $a0, $t0		#$a0 = i;
	li $v0, print_i10	#
	syscall			#print_int10(i);
	
	la $a0, point		#$a0 = ": ";
	li $v0, print_str	#
	syscall			#print_string(": ");

	li $t2, 0		#$t2 = j = 0;
	
while:	sll $t3,$t0,2		#$t3 = i * 4;
	addu $t3,$t1,$t3	#$t3 = &(array[i]);
	lw $t3,0($t3)		#$t3 = array[i];
	addu $t3,$t3,$t2	#$t3 = &array[i][j];
	lb $t3,0($t3)		#$t3 = array[i][j];
	beq $t3,'\0',endw	#while(array[i][j] != '\0') {
	
	move $a0, $t3		#		
	li $v0,print_c		#
	syscall			#print_char(array[i][j]);
	
	li $a0,'-'		#					
	li $v0, print_c		#	
	syscall			#print_char('-');	
	
	addi $t2, $t2, 1	#j++;
	j while
		
endw:	addi $t0,$t0,1		#i++
	j for

endfor:li $v0,10		#
	syscall			#exit
 	jr $ra 			# termina o programa 
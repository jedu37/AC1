# Mapa de registos
# $t0 - p
# $t1 - pLast
# $t2 - n
# $t3 - j

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
main:	la $t0,array		# $t0 = p = array
	li $t1,SIZE		# $t1 = SIZE
	sll $t1,$t1,2		# $t1 = SIZE * 4
	addu $t1,$t0,$t1	# $t1 = pLast = p + SIZE
	li $t2,0		# $t2 = n = 0 

for:	bge $t0,$t1,endfor	# while(p<pLast)
	
	la $a0, str		#				
	li $v0, print_str	#
	syscall			#print_string("\nString #");
	
	move $a0, $t2		#$a0 = n;
	li $v0, print_i10	#
	syscall			#print_int10(i);
	
	la $a0, point		#$a0 = ": ";
	li $v0, print_str	#
	syscall			#print_string(": ");
	
	lw $t3,0($t0)		#$t3= j = *p;
	
while:	lb $t4,0($t3)		#$t4 = *j;
	beq $t4,'\0',endw	#while(*j != '\0') {

	move $a0, $t4		#		
	li $v0,print_c		#
	syscall			#print_char(array[i][j]);
	
	li $a0,'-'		#					
	li $v0, print_c		#	
	syscall			#print_char('-');	
	
	addi $t3, $t3, 1	#j++;
	j while
		
endw:	addiu $t0,$t0,4		#p++
	addi $t2,$t2,1		#n++
	j for

endfor:li $v0,10		#
	syscall			#exit
 	jr $ra 			# termina o programa 
	.data
virg:	.asciiz ", "
	.text
	.globl strlen
	.globl strrev
	.globl strcpy
	.globl strcat
	.globl insert
	.globl print_array
	
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
 
#EXCHANGE(troca a posição de dois registos)
exchange:			#void exchange(char* c1, char* c2)
	lb $t0,0($a0)		#$t0 = $a0  || char aux = *c1;
	lb $t1,0($a1)		#$t1 = $a1
	sb $t1, 0($a0)		#$t1 = $a0  || *c1 = *c2;
	sb $t0,0($a1)		#$t0 = $a1  || *c2 = aux; 	
	jr $ra			#termina a sub-rotina
	
# STRREV (inverte uma string)
# Mapa de registos:
# str: $a0 -> $s0 (argumento é passado em $a0)
# p1: $s1 (registo callee-saved)
# p2: $s2 (registo callee-saved)
#
strrev: 	addiu $sp,$sp,-16 	# reserva espaço na stack
 		sw $ra,0($sp) 		# guarda endereço de retorno
 		sw $s0,4($sp) 		# guarda valor dos registos
 		sw $s1,8($sp) 		# $s0, $s1 e $s2
 		sw $s2,12($sp) 		#
 		move $s0,$a0 		# registo "callee-saved"
 		move $s1,$a0 		# p1 = str
 		move $s2,$a0 		# p2 = str
 	
strvw1: 	lb $t0,0($s2)		# while( *p2 != '\0' ) {
		beq $t0,'\0',strvendw1	#
 		addiu $s2,$s2,1 	# p2++;
 		j strvw1  		# }
strvendw1: 	subu $s2,$s2,1 		# p2--;
strvw2: 	bge $s1,$s2,strvendw2	# while(p1 < p2) {
 		move $a0,$s1 		#
 		move $a1,$s2 		#
 		jal exchange 		# exchange(p1,p2)
 		addi $s1,$s1,1		# p1++
		sub $s2,$s2,1          # p2--
		j strvw2 		# }
		
strvendw2:	move $v0,$s0 		# return str
 		lw $ra,0($sp) 		# repõe endereço de retorno
 		lw $s0,4($sp) 		# repõe o valor dos registos
 		lw $s1,8($sp) 		# $s0, $s1 e $s2
	 	lw $s2,12($sp) 		#
 		addiu $sp,$sp,16 	# liberta espaço da stack
 		jr $ra # termina a sub-rotina 

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

#STRCAT (permite concatenar duas strings)
#Mapa de Registos
#$a0 - $0(p)
#$a1 - $s1
#*p - $s2
strcat:		addiu $sp,$sp,-16 	#cria espaço no stack
		sw $ra,0($sp)		#para salvaguardas
		sw $s0,4($sp)		#os registos $ra, $s0, $s1
		sw $s1,8($sp)		#
		sw $s2,12($sp)
		
		move $s0, $a0		#$s0 = p = dst
		move $s1, $a1		#$s1 = src
stcaw:		lb $s2, 0($s0)		#*p = dst[0]
		beq $s2, '\0', stcaew	#while(*p != '\0')
		addi $s0,$s0,1		#p++;
		j stcaw

stcaew:		move $a0,$s0
		move $a1,$s1
		jal strcpy		#strcpy(p,src)
	
		lw $ra,0($sp)		#liberta o espaço na stack
		lw $s0,4($sp)
		lw $s1,8($sp)
		lw $s2,12($sp)
		addiu $sp,$sp,16
		jr $ra			#termina a sub-rotina

# exa1 ------
#insert (insere Value na pos do array de size)
#Mapa de Registos
# $t0 -> i
# $t1 -> *array[i]
# $t2 -> array[i]

insert:		move $t0,$a3		# int i = size;
		sub $t0,$t0,1		# int i = size - 1;
		
if_ins:		ble $a2,$a3,else_ins	# if( pos > size)
		li $v0,1		#
		jr $ra			#	return 1;
		
else_ins:	blt $t0,$a2,end_ins	#else{ for{ i >= pos ){
		sll $t1,$t0,2		#	$t1 = i * 4
		addu $t1,$t1,$a0	#       $t1 = *array[i]
		lw $t2,0($t1)		#	$t2 = array[i]
		sw $t2,4($t1)		#	array[i+1] = array[i]
		sub $t0,$t0,1		#	i--;
		j else_ins		#	}
end_ins:	sll $t1,$a2,2		#   $t1 = pos*4;
		addu $t1,$t1,$a0 	#   $t1 = *array[pos]
		sw $a1,0($t1)		#   array[pos] = value
		li $v0,0		#
		jr $ra			#	return 1;

#print_array (imprime array a de n elementos)
print_array:	move $t0,$a0		#  $t0 = *a
		move $t1,$a1		#  $t1 = n
		sll $t1,$t1,2		#  $t1 = n*4
		add $t1,$t1,$a0		#  $t1 = *p = a + n

for_p_a:	bge $t0,$t1,end_p_a	#  for( a < p ){
		lw $a0, 0($t0)		# $a0 = *a
		li $v0,1		#
		syscall			# print_int10(*a)
		la $a0,virg		# $a0 = ','
		li $v0,4		#
		syscall			# print_string(", ")
		addiu $t0,$t0,4		# a++
		j for_p_a		#  }
end_p_a:	jr $ra			# }

		
		
# Mapa de Registos

        .data
z:	.double 0.0
n_l:	.asciiz "\n"
        .eqv r_d,7
        .eqv p_d, 3
	.eqv p_str,4
        
        .text
        #.globl main
main:   addiu $sp,$sp,-4   # reserva espaço na stack
        sw $ra,0($sp)      # salva $ra
        
        li $v0,r_d         # do{
	syscall            #
	mov.d $f20,$f0     # val = $f20 = read_double()
	mov.d $f12,$f0     # $f12 = read_double()
	jal f2c            # f2c(val)
	
	mov.d $f12,$f0     #
	li $v0,p_d         #
	syscall            # print_float( f2c(val) );
	
	la $a0,n_l         #
	li $v0,p_str       #
	syscall            # print_string("\n");
	
	la $t0,z           #
	l.d $f8,0($t0)     # $f8 = 0.0
	c.eq.d $f20,$f8    # }while(va != 0);
	bc1f main
	
	li $v0,0		#return 0;
        lw $ra,0($sp)          # recupera $ra
        addiu $sp,$sp,4        # liberta espaço na stac
	jr $ra			# termina o programa
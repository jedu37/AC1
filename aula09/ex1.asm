# Mapa de Registos

        .data
k:	.float 2.59375
z:	.float 0.0
n_l:	.asciiz "\n"
        .eqv r_i,5
        .eqv p_flt, 2
	.eqv p_str, 4
        
        .text
        .globl main
main:   
        li $v0,r_i         # do{
        syscall            #
        
        la $t0,k
	l.s $f4,0($t0)     # $f4 = 2.59375;
	mtc1 $v0,$f6       # $f6 = val
	cvt.s.w $f6,$f6    # $f6 = (float) val
	mul.s $f12,$f6,$f4 # $f12 = res = (float) val * 2.59375
	
	li $v0,p_flt       #
	syscall            # print_float( res );
	
	la $a0,n_l         #
	li $v0,p_str       #
	syscall            # print_float("\n");
	
	la $t0,z           #
	l.s $f8,0($t0)     # $f8 = 0.0
	
	c.eq.s $f6,$f8     # }while(res != 0);
	bc1f main
	
	li $v0,0		#return 0;
	jr $ra			# termina o programa
	
        
        
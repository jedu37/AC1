	.data
a:      .space 80       # size * 8 ( double -> 8 bytes)
	.eqv SIZE,10
	.eqv r_i, 5
	.eqv p_d, 3
	
	.text
	.globl main
main:   addiu $sp,$sp,-4 	# reserva espaço na stack
        sw $ra,0($sp)          # salva $ra
        
        li $t0,0               # $s0 = int i = 0
for:    bge $t0,SIZE,end       # for(i < SIZE){
        la $t1,a               # $t1 = a
        sll $t2,$t0,3          # $t2 = i*8
        addu $t1,$t1,$t2       # $t1 = a[i]
        
        li $v0,r_i             #
        syscall                #
        mtc1 $v0,$f4           # $f4 = read_int()
        cvt.d.w $f4,$f4               # $f4 = (double) read_int()
        s.d $f4,0($t1)         # a[i] = (double)read_int();
        
        addi $t0,$t0,1         # i++;
        j for                  #}
        
end:    la $a0,a               #
        li $a1,SIZE            #
        jal average            # average(a,SIZE)
        mov.d $f12,$f0         #
        li $v0,p_d             #
        syscall                # print_double( average(a, SIZE) ); 
        li $v0,1               # return 0; 
        lw $ra,0($sp)          # restaura $ra
        addiu $sp,$sp,4		# liberta espaço na stack
        jr $ra                 #
        
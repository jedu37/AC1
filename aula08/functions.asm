	.data
buf_ac1:.space 33

	.text
	.globl atoi
	.globl atoi_bin
	.globl itoa
	.globl print_int_ac1

# ex1_a	
# Mapa de registos
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1
# Sub-rotina terminal: não devem ser usados registos $sx
atoi: 	li $v0,0 		# res = 0;
wa: 	lb $t0,0($a0) 		# while((*s >= '0') && (*s <= '9'))
 	blt $t0,'0',end_wa       #
 	bgt $t0,'9',end_wa        # {
 	sub $t1,$t0,'0'          # digit = *s – '0'
 	addiu $a0,$a0,1        # s++;
 	mul $v0,$v0,10         # res = 10 * res;
        add $v0,$v0,$t1        # res = 10 * res + digit;
        j wa                   # }
end_wa: jr $ra                 # termina sub-rotina

# ex1_a	
# Mapa de registos
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1
# Sub-rotina terminal: não devem ser usados registos $sx
atoi_bin: 	li $v0,0 		# res = 0;
wab: 	lb $t0,0($a0) 		# while((*s >= '0') && (*s <= '9'))
 	blt $t0,'0',end_wab    #
 	bgt $t0,'1',end_wab    # {
 	sub $t1,$t0,'0'          # digit = *s – '0'
 	addiu $a0,$a0,1        # s++;
 	sll $v0,$v0,1         # res = res << 1;
        add $v0,$v0,$t1        # res = res<<1 + digit;
        j wab                   # }
end_wab: jr $ra                 # termina sub-rotina

# Mapa de registos
# n: $a0 -> $s0
# b: $a1 -> $s1
# s: $a2 -> $s2
# p: $s3
# digit: $t0
# Sub-rotina intermédia
itoa:   addiu $sp,$sp,-20          # reserva espaço na stack
        sw $s0,0($sp)              # guarda registos $sx e $ra
        sw $s1,4($sp)              #
        sw $s2,8($sp)              #
        sw $s3,12($sp)             #
        sw $ra,16($sp)             #
         
        move $s0,$a0               # copia n, b e s para registos
        move $s1,$a1               # "callee-saved"
        move $s2,$a2               #
        move $s3,$a2               # p = s;
do_i:                                # 
        div $s0,$s1 		    # 
        mfhi $t0                   # $t0 = digit = n%b;
        mflo $s0                   # $s0 = n = n/b;
        
        move $a0,$t0		    #
        jal to_ascii               # toascii(digit)
        
        sb $v0,0($s3)              # $s3 = *p = toascii(digit)
        addiu $s3,$s3,1            # p++		    
        bgt $s0,0,do_i             # } while(n > 0);
        sb $0,0($s3)               # *p = 0;
        move $a0,$s2               #
        jal strrev                 # strrev( s );
        move $v0,$s2               # return s;
        lw $s0,0($sp)              # repõe registos $sx e $ra
        lw $s1,4($sp)              #
        lw $s2,8($sp)              #
        lw $s3,12($sp)             #
        lw $ra,16($sp)             # 
        addiu $sp,$sp,20           # liberta espaço na stack
        jr $ra                     # 

to_ascii: move $t0,$a0             # $t0 = $a0
          addi $t0,$t0,'0'         # v += '0'
          ble $t0,'9',skip_ta      # if ( v > '9' )
          addi $t0,$t0,7           # v += 7 // 'A'-'9'-1
skip_ta:  move $v0,$t0             # return v
          jr $ra
################################################################
print_int_ac1: addiu $sp,$sp,-12         # reserva espaço na stack
        sw $s0,0($sp)              # guarda registos $sx e $ra
        sw $s1,4($sp)              #
        sw $ra,8($sp)             #
        
        move $s0,$a0               # $s0 = val
        move $s1,$a1               # $s0 = base
        
        move $a0,$s0               #
        move $a1,$s1               #
        la $a2,buf_ac1             #
        jal itoa                   # itoa(val,base,buf)
        move $a0,$v0               #
        li $v0,4                   #
        syscall                    # print_string(itoa(val,base,buf));
        lw $s0,0($sp)              # repõe registos $sx e $ra
        lw $s1,4($sp)              #
        lw $ra,8($sp)              # 
        addiu $sp,$sp,12           # liberta espaço na stack
        jr $ra                     # 
          
	 
	
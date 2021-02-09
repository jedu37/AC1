# Mapa de registos
# str: $s0
# val: $s1
# O main é, neste caso, uma sub-rotina intermédia
 	.data
str:    .space 33
n_l:    .asciiz "\n"
        .eqv STR_MAX_SIZE,33
        .eqv r_i,5
        .eqv p_str,4
        .text
        .globl main
        
main:   addiu $sp,$sp,-12# reserva espaço na stack
        sw $s0,0($sp)    #
        sw $s1,4($sp)    # guarda registos $sx na stack
        sw $ra,8($sp)    # guarda $ra na stack
        
do:                      # do {
        li $v0,r_i       #
        syscall          #
        move $s1,$v0     #  val = read_int()
        
        move $a0,$s1     # n = val
        li $a1,2         # b = 2
        la $a2,str       # s = str
        jal itoa	  # itoa(n,b,s)
        
        move $a0,$v0     #
        li $v0,p_str     #
        syscall          # print_string( itoa(val, 2, str) ); 
        
        la $a0,n_l       #
        li $v0,p_str     #
        syscall          # print_string("\n");  
        
        move $a0,$s1     # n = val
        li $a1,8         # b = 8
        la $a2,str       # s = str
        jal itoa	  # itoa(n,b,s)
        
        move $a0,$v0     #
        li $v0,p_str     #
        syscall          # print_string( itoa(val, 8, str) );
        
        la $a0,n_l       #
        li $v0,p_str     #
        syscall          # print_string("\n");  
        
        move $a0,$s1     # n = val
        li $a1,16         # b = 16
        la $a2,str       # s = str
        jal itoa	  # itoa(n,b,s)
        
        move $a0,$v0     #
        li $v0,p_str     #
        syscall          # print_string( itoa(val, 16, str) );
        
        la $a0,n_l       #
        li $v0,p_str     #
        syscall          # print_string("\n");
        
        move $a0,$s1     #
        li $a1,10        #
        jal print_int_ac1# print_int_ac1(val,10)
        
        la $a0,n_l       #
        li $v0,p_str     #
        syscall          # print_string("\n");    
        
        bnez $s1,do      # } while(val != 0)
        
        li $v0,0         # return 0;
        
        lw $s0,0($sp)    #
        lw $s1,4($sp)    # repoe registos $sx
        lw $ra,8($sp)    # repõe registo $ra
        addiu $sp,$sp,12 # liberta espaço na stack
        jr $ra           # termina programa
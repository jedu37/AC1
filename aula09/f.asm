        .data
z:      .double 0.0
v_5:    .double 5.0
v_9:    .double 9.0
v_32:   .double 32.0
                
        .text
        .globl f2c
        .globl average
#f2c(double ft)        
f2c:    la $t0,v_5         #
        l.d $f4,0($t0)     # $f4 = 5.0
        la $t0,v_9         #
        l.d $f6,0($t0)     # $f6 = 9.0
        la $t0,v_32        #
        l.d $f8,0($t0)     # $f8 = 32.0
        div.d $f4,$f4,$f6  # $f4 = 5.0/9.0
        sub.d $f8,$f12,$f8 # $f8 = ft -32
        mul.d $f0,$f4,$f8  # return( 5.0/9.0 * (ft - 32.0));
        jr $ra             # 

#average/(doube *array, int n)
# i -> $t0
# $f4 -> sum
average:
        move $t0,$a1      # int i = n
        la $t1,z          #
        l.d $f4,0($t1)    # $f4 = double sum = 0.0
for_a:  blez $t0,end_fa   # for(i>0){
        sub $t1,$t0,1     # $t1 = i-1
        sll $t1,$t1,3     # $t1 = (i-1)*8
        addu $t1,$a0,$t1   # $t1 = array[i-1]
        l.d $f6,0($t1)    # $f6 = *array[i-1]
        add.d $f4,$f4,$f6 # sum += array[i-1];
        sub $t0,$t0,1     # i--
        j for_a
end_fa: mtc1 $a1,$f8      # $f6 = n
        cvt.d.w $f8,$f8   # $f6 = (double) n
        div.d $f0,$f4,$f8 # return sum / (double)n; 
        jr $ra            #      
        
        
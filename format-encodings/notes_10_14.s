.text
.globl what

what:  nop 
li $t0, 1           
nop                 
move $t1, $a0       
top:  blt $t1, 1, done    
nop                 
mul $t0, $t0, v  
nop   
subi $t1, $t1, 1    
b fac               
done: move $v0, $t0       
jr $ra
                            
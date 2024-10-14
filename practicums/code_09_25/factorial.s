          .text
          .globl factorial


factorial:  nop        # public static int factorial (int N) {
   # v0: <return value>
   # a0: N
   # t0: result             # int result;
   # t1: v                  # int v;
                  
        .eqv v $t1  

                            #  // fac(N) = N * n-1 * n-2 ... 1 
                            #  
        li $t0, 1           #  result = 1;
                            #  
  init: nop                 #  ;
        move v, $a0         #  v = N; 
  fac:  blt v, 1, done      #  for(; v >= 1 ;) {

  body: nop                 #    ;
        mul $t0, $t0, v     #    result = result * v;
                
  next:                     #    ;    
        subi $t1, $t1, 1    #    v = v - 1 ;
        b fac               #    continue fac;   
                            #  }
  done:                     #  ;            
                            #  
        move $v0, $t0       #  return result;
        jr $ra
                            # }
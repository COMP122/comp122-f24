#   1. Practicum on Macros and IF Statements
#      - area of something -- review
#      - min
#      - max
#      - abs
#      - diff (difference)
#      - sign
#      - ascending swap

        .macro sign(%num)
        #  sign ($t5)
        #  $v0 holds the results

        # v0: sign

        # Example of the alternative form for the "if" statement
        # bge %num, $zero, cons     # if ( num >= 0 ) {
        # b alt

        blt %num, $zero, alt        # if ( num >= 0 ) {
cons:     nop                       #   ;
          li $v0, 0                 #   sign = 0;
          b done                    #   // goto done;
                                    # } else {
alt:      nop                       #   ;         
          li $v0, 1                 #   sign = 1;
          b done                    #   // goto done;
                                    # }
done:   nop                         # ;

        .end_macro


        .macro swap(%first, %second)

        # at: temp

        blt %first, %second, apple      # if (first >= second ) {
can:      nop                           #    null;
          move $at, %first              #    temp = first;
          move %first, %second          #    first = second;
          move %second, $at             #    second = temp;
          b thanks                      #    // goto thanks
                                        # } else {
apple:    nop                           #    null;
          b thanks                      #    // got thanks
                                        # }
hanks:  nop                             # ; 

        .end_macro


   
        .macro abs ( %rd, %rs )
        # abs $v0, $a0

        bge %rs, $zero, alt            # if ( %rs < 0 ) {
 cons:    nop                          #   ; 
          sub %rd, $zero, %rs          #   %rd = 0 - %rs
          b next                       #   // goto next;
                                       # } else {
 alt:     nop                          #   ;
          move %rd, %rs                #   %rd = %rs
          b next                       #   // goto next;
                                       # }
 next:  nop                            # ; 

        .end_macro



        .macro max(%max, %a, %b)

        ble %a, %b, alt                 # if ( a > b ) {
cons:     nop                           #   ;            
          move %max, %a                 #   max = a;
          b thanks                      #   // goto thanks;
                                        # } else {
alt:      nop                           #   ;               
          move %max, %b                 #   max = b;
          b thanks                      #   // goto thanks;
                                        # }
thanks: nop                             # ;
        print_d(%max)                   # mips.print_d(max);
    
        .end_macro



        .macro min(%min, %a, %b)
        # Usage:   min  $t1, $t2, $t3

        bgt %a, %b, alt   # if ( a <= b ) {
cons:     nop             #    ;           
          move %min, %a   #    min = a;
          b next          #    // goto next;
                                   # } else {
alt:      nop             #    ;
          move %min, %b   #    min = b;
          b next          #    // goto next;
                          # }
 next:    nop             # ; 
         
        .end_macro
         

        .macro diff( %diff, %a, %b )
        # Usage: diff $v0, $t1, $t2

        ble %a, %b, sam             # if ( A > B ){
 cons:    nop                       #   ;
          sub %diff, %a, %b         #   diff = A - B
          b bob                     #   // goto bob;
                                             # } else {
 sam:     nop                       #   ;
          sub %diff, %b, %a         #   diff B - A
          b bob                     #   // goto bob;
                                     # }
 bob:   nop                         # ; 
        .end_macro



#  Area:  area of a box
#   * a =  2(l * h ) +   2(l * w) + 2* ( h * w )
#   * a =  2 ( (l * h ) + (l * w) + ( h * w ) ) 
surface_box:  nop
        # a0: L
        # a1: H
        # a2: W
        # t0: l
        # t1: h
        # t2: w
        # t3: 2
        # t4: s
        # t5: x
        # t6: y
        # t7: z

        move $t0, $a0         # l = L;
        move $t1, $a1         # h = H;
        move $t2, $a2         # w = W;

        mul $t0, $t1          # x = l * h;
        mflo $t5
   
        mul $t0, $t2
        mflo $t6              # y = l * w;

        mul $t1, $t2
        mflo $t7              # z = h * w;

        add $t4, $t5, $t6     # s = x + y;
        add $t4, $t4, $t7     # s = s + z;

        li $t3, 2             # t3 = 2;        # sll $v0, $t4, 1
        mul $t3, $t4          # a =  t3 * s;   #
        mflo $v0                               #

        jr $ra

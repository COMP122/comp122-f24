


public static int pos_msb(int number) {

            int position;

start:      ;
            position=0;
ctl:        for (; number != 0 ;) {
stuff:         ;
               number = number >>> 1;
again:         ;  
               position = position + 1;
               continue ctl;       
            }
complete:   ;         

            return position;
}
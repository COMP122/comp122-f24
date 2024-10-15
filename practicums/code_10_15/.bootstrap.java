
class pos_msb {
   static MIPS_library mips = new MIPS_library();
// #line 0 "java_tac/pos_msb.j"



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

  public static char[] string2charArray(String text) {
    int index;
    char [] A = new char[ text.length() + 2];

    for (index=0; index < A.length - 2; index++ ) {
      A[index] = (text).charAt(index);
    }
    A[index]   = '\0' ;   // the Null character
    A[index+1] = '\7' ;   // the Alert character
    return A;
  }

  public static void main(String[] args) {
  
    int index;
    int exit_status = 0;
    int  $a0   = -5;

    // Marshal the stack arguments:

    // List of BEFORE actions


    // Make the primary call to the subroutine
    int $v0 = pos_msb($a0);
    int $f0 = $v0;
    exit_status = $v0;

    // List of AFTER actions

    // Print the return value from the routine
    mips.println_d($v0);
    mips.exit(exit_status);
    return;
  }
}

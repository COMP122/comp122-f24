
# Equation     
     1. X = (a + b) * (a - b)

# Java Code
```java

public static int equation(int a, int b) {

     int X;

     X = (a + b) * (a - b);
     return X;

}
```

# Java TAC Code
```java

public static int equation(int $a0, int $a1) {
     // a0: a
     // a1: b

     int $t0;
     int $t1;
     int $t2;
     int $v0;

     $t0 = $a0 + $a1;                  // X = (a + b) * (a - b);
     $t1 = $a0 - $a1;
     $t2 = $t0 * $t1; 
     $v0 = $t2;
     return $v0;

}
```

# MIPS Code

```mips
          .data
          .text
          .globl equation

equation:  nop           ## public static int equation(int $a0, int $a1) {
          # a0: a
          # a1: b
          # t0: 
          # t1: 
          # t2: 
          # v0: = (a + b) * (a - b);

          add $t0, $a0, $a1   #  $t0 = $a0 + $a1;   // X = (a + b) * (a - b);
          sub $t1, $a0, $a1   #  $t1 = $a0 - $a1;
          
          mult $t0, $t1       #  $t2 = $t0 * $t1; 
          mflo $t2
          
          move $v0, $t2       #  $v0 = $t2;

          move $v0, $v0       #  return $v0;
          jr $ra
```
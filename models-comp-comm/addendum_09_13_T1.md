# Equation
  Z = a / b + (b + 2) / b

# Java Subroutine

```java
public static int equation(int a, int b) {
   int Z;

   Z = a / b + (b + 2) / b;

   return Z;         
}

```

# Java Subroutine TAC

```java
public static int equation(int $a0, int $a1) {
   // a0: a
   // a1: b
   int $v0;
   int $t0;
   int $t1;
   int $t2;
   int $t3;

   $t0 = $a0 / $a1;
   $t1 = $a1+ 2;
   $t2 = $t1 / $a1;
   $t3 = $t0 + $t2;

   $v0 = $t3;  //Z = a / b + (b + 2) / b;

   return $v0;         
}

```


```mips

            .text
            .globl equation
equation: nop   # public static int equation(int a, int b) {
   # a0: a
   # a1: b
   # v0: Z = a / b + (b + 2) / b;
   # t0:
   # t1:
   # t2:
   # t3:
   # t4: 2

   div $a0, $a1         # $t0 = $a0 / $a1;
   mflo $t0
                        
   li $t4, 2;           # $t1 = $a1+ 2;
   add $t1, $a1, $t4

   div $t1, $a1         # $t2 = $t1 / $a1;
   mflo $t2

   add $t3, $t0, $t2   # $t3 = $t0 + $t2;

   move $v0, $t3       # $v0 = $t3; 

   move $v0, $v0       # return $v0;         
   jr $ra

```
# Equation
```
   Y = b + 2 * c + 4
```

# Java Code
```java

public static int equation(int b, int c) {

   int Y;

   Y = b + 2 * c + 4;
   return Y;

}
```

```java tac

public static int equation(int $a0, int $a1) {
   // v0: Y = b + 2 * c + 4;
   // a0: b
   // a1: c
   // t0: 2, 4
   // t1: 2 * c
   // t2: b + 2 * c 
   int $t0;
   int $t1;
   int $t2;
   int $t3;
   int $v0;

   $t0 = 2;          //    Y = b + 2 * c + 4;
   $t1 = $t0 * $a1;
   $t2 = $a0 + $t1;
   $t0 = 4;
   $t3 = $t2 + $t0;

   $v0 = $t3;

   return $v0;

}
```
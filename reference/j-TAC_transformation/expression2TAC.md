
## PEMDAS



  1. PEMDAS and Three Address code
  1. Assignment:
     1. Given equation
        ```
        4 * a + b^2  - 4 * a * b / a
        ----------------------------
            2 * b
        ```
     1. Rewrite into a single linear expression
     1. Rewrite into a single linear equation that contains only the operators: () * / + -
     1. Define a linear equation of the form `$v0 = expression;`
     1. Rewrite into a series of linear equation
        - Each equation must for of one of the following forms:
          *  temp = constant;
          *  temp = variable;
          *  temp = variable + variable;
          *  temp = variable - variable;
          *  $v0 = temp;

       - you are given a set of local variables:  $t1, $t2, $t3, .. $t9, $v0
       - each variable can can be defined once
       - place the final value into $v0

     1. Write a java subroutine using the following template to compute the value of $v0
        - Place this subroutine in the file named equation.j
          ```java
   
          public static int equation(int a, int b) {
            int $v0;
            int $t0;
            int $t1;
            int $t2;
   
            // Insert your series of equations that define $v0 after this line
   
            // 
            return $v0;
          }
          ```

       * Requirements
         - delete all unnecessary lines
         - ensure proper formatting
         - ensure your code complies with `java_subroutine`

    1. Use `java_subroutine to fill in the following table`

       |  a    |  b   |  $v0 |
       |-------|------|------|
       |   0   |  0   |   error   |   `java_subroutine equation 0 0`
       |   0   |  1   |      |   `java_subroutine equation 0 1`
       |   0   |  2   |      |   `java_subroutine equation 0 2`
       |   1   |  0   |      |   `java_subroutine equation 1 0`
       |   1   |  1   |   0   |   `java_subroutine equation 1 1`
       |   1   |  2   |   2  |   `java_subroutine equation 1 2`
       |   2   |  0   |      |   `java_subroutine equation 2 0`
       |   2   |  1   |      |   `java_subroutine equation 2 1`
       |   2   |  2   |      |   `java_subroutine equation 2 2`
      

# Process to Writing MIPS code for COMP122

In COMP122, the Professor has devised a way to write MIPS code based upon your knowled of Java.  This approach has been developed to achieve the following goals.

  1. Reinforce your understanding of the Java Program Language
  1. Introduce you to operational semantics
  1. Simplify your efforts to craft MIPS code

The development process is as follows:


 1. Development Process:
     1. Write Java Subroutine: `method.j`
        - the Java must conform to a subset of java
        - the algorithm design must match that provided in the specifiction
        - ensure that it is 100% correct
     1. Rewrite Java Subroutine into TAC style:  `method.`
        - ensure that it is 100% correct
        - ensure it it in PROPER TAC form
     1. Transliterate your Java subroutine into MIPS: `method.s`
        - Copy your `method.j` into `method.s`
        - Comment out your Java Code
        - Transliterate: line by line!
          ```
          {label}:      {mips instruction}       #  {java instruction}
          ```
        - If you have to do more than transliteration, 
          - your Java code is WRONG--even it generates the desired results!


## Simplied Java Code for Comp122

When writing Jave code, you want 


# Rules to write Simplified Java Code for COMP122

  1. Strive to keep you code simple and readable
  1. Provide comments that provide clarity of purpose
  1. Keep your mathematical expression simple
  1. Use the simpliest control structure
     * if-then-else
     * for 
     * while
     * do-while
  1. Don't use the following..
     * Objects
     * the for-each control flow statment



* Dos
  - 
* Don't
1. 

1. Write 

## Writing Java Code

 1. Development Process:
     1. Write Java Subroutine: `method.j`
        - ensure that it is 100% correct
     1. Rewrite Java Subroutine into TAC style:  `method.`
        - ensure that it is 100% correct
        - ensure it it in PROPER TAC form
     1. Transliterate your Java subroutine into MIPS: `method.s`
        - Copy your `method.j` into `method.s`
        - Comment out your Java Code
        - Transliterate: line by line!
          ```
          {label}:      {mips instruction}       #  {java instruction}
          ```
        - If you have to do more than transliteration, 
          - your Java code is WRONG--even it generates the desired results!


## Java --> Java TAC

### [Expressions and Assignment Conversion Algorithm](./expression2TAC.md)

### [Conversion of an if-then-else statement into TAC](./if-then-else2TAC.md)

### [Conversion of a for-loop statement into TAC style](./for-loop2TAC.md)

### Conversion of while-loop statement into TAC style

One of the most versitile statements is the `while-loop`.  The Java `for-loop`, however, is effectively a `while-loop`, but with improved syntax for readibility. A true `for-loop` iterates for a predefined number of times.  This number can be determined prior to ever executing the body of the loop.  

As such, we prefer the use of the `for-loop` over the `while-loop`.  If you do use a `while-loop`, the first step in the conversion process is to replace the `while-loop` with a `for-loop`.  This replace is performed by simply modify the line that contents the Boole test.

Consider the following `while-loop` construct.

   ```java
   while( <test> ) {
      <body>
   }
   ```


Simple convert your code to match the following template:

  ```java
  for(; <test> ;) {
    <body>
  }
  ```


### Conversion of do-while-loop statement into TAC style

   ```java
   do {
      <body>
   } while( <test> );
   ```

   ```java
   loop:     do {
   body:       ;            
               <body>

               $l = ...;
               $r = ...;
             } while( $l <comp> $r );
   done:     ;
   ```


   ```java
   while( <test> ) {
      <body>
   }
   ```

### Conversion of for-each-loop statement into TAC style

The 'for-each' loop allows one to interate over a collection, such as an array.  Consider the following Java code example which sums the individual elements in the array A.

   ```java
   sum = 0;
   for ( int element in A ) {
      sum += element;
   } 
   ```

  ```java
   sum = 0;
   for ( int index = 0;  index < A.length; index ++ ) {
      sum += A[index];
   } 
   ```  

### Conversion of switch statement into TAC style

Instead of writing a set of embedded if-then-else statements, you can use the switch statement. This is highly desirable because it increases the readability and the maintainability of the code.  

Consider the following embedded if-the-else example:

  ```java
  value = expression;
  if (x == value) {
      ; // code block
  } else if (y == value) {
     ; // code block
  } else if (z == value) { 
     ; // code block
  } else {
     ; // code block
  }
  ```

The equivalent code using a switch statement is as follows:

  ```java
  switch(expression) {
          
    case x:
        ; // code block
        break; 
          
    case y:
        ; // code block
        break;

    case z:
        ; // code block
        break;
          
    default:
        ;    // code block
        break;

   }
   ```

Each case block corresponds directly to one of the consequence block of an `if-the-else` statement.  The default block corresponds directly to the last alternative block.  It is typical that each of case blocks end with a `break`.  These `break` statements are not required.  Without appending the `break` statement to the end of the case block, execution continues into the next case block.  As such, this is a common source of a programming bug.

Prior to converting a switch stytement into TAC style the following requirements must be met.

  1. each case value must be a single variable or immediate value (limitation of Java)
  1. each case block _should_ end with a `break` statement
  1. a default block must be included and it must be the last code block



Consider the following example of switch statement, and its control flow graph.

   ```java
   switch (x % 4) {
      case 1:
            m = 3;
            break;
      case 2:
            m = 2;
            break;
      case 3:
            m = 1;
            break;
      default:
            m = 0;
            break;

   }
   ```


![Control Flow Graph for a switch statement](switch.png)


Notice that the control flow graph depicts a box of code for the entire switch statement, and within this block there are six blocks of code and one control block. The names of these blocks are:

  1. {init}: the block of code that is executed prior to the controlling value of the switch expression
  1. {stmt}: the control block associated with the `switch` key word.
  1. {case 1}: the first case block 
  1. {case 2}: the second case block
  1. {case 3}: the third case block
  1. {default}: the default case block
  1. {done}: the implicit last line of code executed as part of switch statement
     * we insert a `null` statement into the statement to explicitly depict this line of code


Transforming the control flow graph into equivalent code, using the TAC style, results in the following:

  ```java tac
  init:  $t1 = x % 4;
  stmt: switch ($t1) {
           case 1:
                  m = 3;
                  break stmt;;
                  mips.merge();
           case 2:
                  m = 2;
                  break stmt;
                  mips.merge();
           case 3:
                  m = 1;
                  break stmt;
                  mips.merge();
           default:
                m = 0;
                break stmt;

         }
  done:  ; 
  ```

Notice the following
  1. a control variable, $t1, has been introduced
  1. the expression that computes the value of the control value is placed into the {init} section
  1. a label ({stmt}) has been associated with the switch keyword
  1. each `case <val>:`  effectively serves as the label for each case block
  1. the default keyword appears as if it is a label, which it is
  1. each break statement explicitly refers to the {stmt} label of the switch statement
  1. there is a `mips.merge();` instruction at the end of each case block
     * this statement is later used in the transliteration process to MIPS.


## Algorithm: switch statement --> TAC Transformation 

Consider the following code template:

  ```java
  switch( <expression> ) {
    case 1:
            <block_1>
    case 2:
            <block_2>
      ...
    case n:
            <block_n>

    default:
            <default_block>
  }
  ```

  1. Insert the {init} label, with a null statement, before the start of the for-loop
  1. Introduce a new variable to serve as the control variable, say $t1
  1. Insert the statement `$t1 = {expression};`  into the {init}
     * Transform the statement `$t1 = {expression};` into TAC style
  1. Associated the {stmp} label with `switch( $t1 ) {`
  1. Append the {done} label, with a null statement, after the end of the switch 
  1. For each case
     1. Insert a null statement as the first instruction 
     1. Modify all breaks to be explicit, i.e., `break;` --> `break {stmt};`
     1. Append `mips.merge();` as the last instruction
  1. For the default
     1. Ensure there is a default!
     1. Insert a null statement as the first instruction (associated with the `case`)
     1. Append `break {top};` as the last instruction

      * Example
        ```java tac
                  value = expression;
        top:      switch(value) {
                    case x:  ;
                             // code block
                             break top;
                             mips.merge();
                    case 2:  ;
                             // code block
                             break top;
                             mips.merge();
                    default: ;
                             // code block
                             break top;
                  }

        done:     ;
        ``` 

### Switch Statements with Ranges

Java does not allow you to include a range within a case statement. This is unfortunate since the use of ranges can yield more readable code. Consider the following C function that converts an ASCII character to an integer.

  ```c
  int toInteger(char input, int radix) {

    switch (input) {
      case '0'...'9' :   digit = digit - '0';
                         break;
      case 'A'...'F' :   digit = digit - 'A' 
                         digit = digit + 10;
                         break;
      case 'a'...'f' :   digit = digit - 'a' 
                         digit = digit + 10;
                         break;
      default:           digit = -1;
    }
    if (digit > (radix - 1)) {
      digit = -1;
    }
    return digit;
  }
  ```
To mimic this function in Java, you need to enumerate each and every case value.  For example,

   ```java
   case 'a':
   case 'b':
   case 'c':
   case 'd':
   case 'e':
   case 'f': digit = digit - 'a' 
             digit = digit + 10;
             break;
   ```
You could also write a set of if-then-else statements, but that would result in a mark decrease in the readability of your code.

We have modify the java_subroutine to allow you to use this extended syntax within your .j code. 

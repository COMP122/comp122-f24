Common Formatted Print Routines

Many languages use a common methodology to print information to the terminal. The information that is printed may be encoded in various ways.  As such these routines need to convert each individual value prior to be printed as a string. 

Java has the following three methods to print information.

  1. `void println( str )` : the string _str_ is printed followed by the '\n' character.
  1. `void print( value )` : the _value_ is converted to a string and then printed.  Note note no '\n' is printed.
  1. `void printf( str, arg ...)` : 
     - the _str_ may contain a number of conversion specification
     - for each conversion specification, a corresponding value is provided as an _arg_


| Data Type | Encoding    	| Spec  | Example              |
|-----------|---------------|-------|----------------------|
| int       | decimal		    | %d    | printf("%d\n", num); |
| int       | hexidecimal   | %x  	| printf("%x\n", num); |
| int       | octal		      | %o	  | printf("%o\n", num); |
| int       | unsigned dec. | %u	  | printf("%u\n", num); |
| char      | char			    | %c	  | printf("%c\n", c);   |
| string    | string        | %s	  | printf("%s\n", str); |

```java
class print_example {

	public static void main(String args[]) {
	
	   int num = -1;
	   char c  = '*';
	   String str = "string";
	
	   System.out.printf("%d\n", num);
	   System.out.printf("%x\n", num);
	   System.out.printf("%o\n", num);
	   System.out.printf("%u\n", num);
	   System.out.printf("%c\n", c);  
	   System.out.printf("%s\n", str);
	   
	   return;
	}
}
```	


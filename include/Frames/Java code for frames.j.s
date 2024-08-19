Java code for frames..


The follow

.macro sub_setup()
        nop    # Only used with the JAVA version
        # the Java compiler effectively does the necessary steps
.end_macro

.macro sub_cleanup(%retval)
        move $v0, %retval  # Only used with the JAVA version
        # the Java Compiler effectively does the necessary steps
.end_macro

.macro sub_precall
       # This is equivalent to pushing the args
.end_macro

.macro sub_postcall
      # This is equivalent to popping the args
      # and staging the $v0 value
      move $v0, 
.end_macro

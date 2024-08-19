
.include  "stack.s"
.include  "syscalls.s"

.data
my_lab: .ascii "hello"	
	
.macro print_string(%string)
                .data
str_label:      .asciiz %string
                .text
                print_si(str_label)
.end_macro


print_si(my_lab)

print_string("Hello")
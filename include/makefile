
J_FILES= syscalls.j stack.j io.j

.PHONEY: MIPS_library.java

MIPS_library.class: MIPS_library.java
	javac MIPS_library.java

MIPS_library.java: ${J_FILES}
	echo "}" | cat MIPS_library_header.java ${J_FILES} - > MIPS_library.java


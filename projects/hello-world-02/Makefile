# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: hello_from_c hello_from_assembly

clean:
	rm *.o
	rm hello

hello_from_c: hello.c
	clang hello.c -c -o hello.o
	ld hello.o -o hello -l System -syslibroot $(SYSLIBROOT) -e _main -arch arm64
	./hello

hello_from_assembly: hello.s
	as hello.s -o hello.o
	ld hello.o -o hello -l System -syslibroot $(SYSLIBROOT) -e _main -arch arm64
	./hello

disassembly_objdump:
	objdump -d --macho hello.o

disassembly_llvm_objdump:
	llvm-objdump -d --macho hello.o

disassembly_otool:
	otool -tvV hello.o

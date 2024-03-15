# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: hello

clean:
	rm *.o
	rm hello

hello_from_c:
	clang hello.c -c -o hello.o
	ld hello.o -o hello -l System -syslibroot $(SYSLIBROOT) -e _main -arch arm64
	./hello

hello_from_assembly:
	as hello.s -o hello.o
	ld hello.o -o hello -l System -syslibroot $(SYSLIBROOT) -e _main -arch arm64
	./hello

# true.o: true.s
# 	as -o true.o true.s
#
# true: true.o
# 	ld -o true true.o -lSystem -syslibroot $(SYSLIBROOT) -e _start
#
# false.o: false.s
# 	as -o false.o false.s
#
# false: false.o
# 	ld -o false false.o -lSystem -syslibroot $(SYSLIBROOT) -e _start

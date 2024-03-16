# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: main

clean:
	@rm -f *.o main

main: clean
	@echo "Start as for sum"
	@as sum.s -o sum.o
	@echo "Start as for dec_until_eql"
	@as dec_until_eql.s -o dec_until_eql.o
	@echo "Start clang"
	@clang -o main.o main.c -c
	@echo "Start ld"
	@ld main.o sum.o dec_until_eql.o -o main -l System -syslibroot $(SYSLIBROOT) -e _main -arch arm64
	@echo "Run executable"
	@./main

disassembly:
	objdump -d --macho main.o

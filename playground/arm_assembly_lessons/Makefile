# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: hello

clean:
	@rm -f *.o
	@rm -f lesson1
	@rm -f lesson2
	@rm -f lesson3

lesson01: lesson01-arm64-apple.s
	as lesson01-arm64-apple.s -o lesson01.o
	ld lesson01.o -o lesson01 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson01
	echo $?

lesson02: lesson02-arm64-apple.s
	as lesson02-arm64-apple.s -o lesson02.o
	ld lesson02.o -o lesson02 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson02
	echo $?

lesson03: lesson03-arm64-apple.s
	as lesson03-arm64-apple.s -g -o lesson03.o
	ld lesson03.o -o lesson03 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson03
	echo $?

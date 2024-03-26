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

lesson04: lesson04-arm64-apple.s
	as lesson04-arm64-apple.s -g -o lesson04.o
	ld lesson04.o -o lesson04 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson04
	echo $?

lesson05: lesson05-arm64-apple.s
	as lesson05-arm64-apple.s -g -o lesson05.o
	ld lesson05.o -o lesson05 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson05
	echo $?

lesson06: lesson06-arm64-apple.s
	as lesson06-arm64-apple.s -g -o lesson06.o
	ld lesson06.o -o lesson06 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson06
	echo $?

lesson07: lesson07-arm64-apple.s
	as lesson07-arm64-apple.s -g -o lesson07.o
	ld lesson07.o -o lesson07 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson07
	echo $?

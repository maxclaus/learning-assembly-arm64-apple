# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: hello

clean:
	@rm -f *.o
	@rm -f lesson1
	@rm -f lesson2
	@rm -f lesson3
	@rm -f lesson4
	@rm -f lesson5
	@rm -f lesson6
	@rm -f lesson7
	@rm -f lesson8
	@rm -f lesson9
	@rm -f lesson10
	@rm -f lesson11

lesson01: lesson01-arm64-apple.s
	as lesson01-arm64-apple.s -g -o lesson01.o
	ld lesson01.o -o lesson01 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson01
	echo $?

lesson02: lesson02-arm64-apple.s
	as lesson02-arm64-apple.s -g -o lesson02.o
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

lesson08: lesson08-arm64-apple.s
	as lesson08-arm64-apple.s -g -o lesson08.o
	ld lesson08.o -o lesson08 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson08
	echo $?

lesson09: lesson09-arm64-apple.s
	as lesson09-arm64-apple.s -g -o lesson09.o
	ld lesson09.o -o lesson09 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson09
	echo $?

lesson10: lesson10-arm64-apple.s
	as lesson10-arm64-apple.s -g -o lesson10.o
	ld lesson10.o -o lesson10 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64

lesson11: lesson11-arm64-apple.s
	as lesson11-arm64-apple.s -g -o lesson11.o
	ld lesson11.o -o lesson11 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64

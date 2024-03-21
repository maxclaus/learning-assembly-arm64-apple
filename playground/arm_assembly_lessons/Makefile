# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: hello

clean:
	rm *.o

lesson01: lesson01-arm64-apple.s
	as lesson01-arm64-apple.s -o lesson01.o
	ld lesson01.o -o lesson01 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64
	./lesson01
	echo $?

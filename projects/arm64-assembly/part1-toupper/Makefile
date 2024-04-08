# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: hello64

hello64.o: hello64.s
	as hello64.s -g -o hello64.o

hello64: hello64.o
	ld hello64.o -o hello64 -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64

clean:
	rm *.o
	rm hello64

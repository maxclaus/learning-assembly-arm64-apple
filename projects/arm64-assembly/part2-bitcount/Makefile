# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: bitcount

bitcount.o: bitcount.s
	as bitcount.s -g -o bitcount.o

bitcount: bitcount.o
	ld bitcount.o -o bitcount -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64

clean:
	rm *.o
	rm bitcount

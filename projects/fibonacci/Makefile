# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: fibonacci

fibonacci: fibonacci.s
	as fibonacci.s -g -o fibonacci.o
	ld fibonacci.o -o fibonacci -l System -syslibroot $(SYSLIBROOT) -e _main -arch arm64
	./fibonacci
	echo $?

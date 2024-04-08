# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: prompt

clean:
	rm *.o
	rm prompt

prompt: prompt.s
	as prompt.s -g -o prompt.o
	ld prompt.o -o prompt -l System -syslibroot $(SYSLIBROOT) -e _main -arch arm64

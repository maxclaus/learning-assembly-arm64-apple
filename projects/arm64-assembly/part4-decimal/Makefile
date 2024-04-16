# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`
OBJECTS 	 = common.o conversion.o decimal.o input.o

all: decimal

%.o: %.s
	as -g $< -o $@

decimal: $(OBJECTS)
	ld $(OBJECTS) -o decimal -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64

clean:
	rm *.o
	rm decimal

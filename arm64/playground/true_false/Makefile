APPLICATIONS = true false

# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: $(APPLICATIONS)

clean:
	rm *.o
	rm $(APPLICATIONS)

true.o: true.s
	as -o true.o true.s

true: true.o
	ld -o true true.o -lSystem -syslibroot $(SYSLIBROOT) -e _start

false.o: false.s
	as -o false.o false.s

false: false.o
	ld -o false false.o -lSystem -syslibroot $(SYSLIBROOT) -e _start

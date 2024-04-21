# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`
OBJECTS 	 = print.o atoi.o converter.o input.o exit.o temperature.o

all: converter

%.o: %.s
	as -g $< -o $@

converter: $(OBJECTS)
	ld $(OBJECTS) -o converter -l System -syslibroot $(SYSLIBROOT) -e _start -arch arm64

clean:
	rm *.o
	rm converter

converter_from_c: converter.c
	clang converter.c -c -o converter.o
	ld converter.o -o converter -l System -syslibroot $(SYSLIBROOT) -e _main -arch arm64
	./converter

disassembly_objdump:
	objdump -d --macho converter.o

disassembly_llvm_objdump:
	llvm-objdump -d --macho converter.o

disassembly_otool:
	otool -tvV converter.o

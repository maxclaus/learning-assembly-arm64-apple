# Make requires to have at least the System lib linked into the program.
SYSLIBROOT = `xcrun -sdk macosx --show-sdk-path`

all: hello

clean:
	rm -f hello

# Run the llvm file using llvm intepreter
hello:
	~/Development/llvm-project/build/bin/lli hello.ll

# Convert the llvm file to assembly
llvm_to_asm:
	~/Development/llvm-project/build/bin/llc hello.ll

build: llvm_to_asm
	gcc hello.s -o hello

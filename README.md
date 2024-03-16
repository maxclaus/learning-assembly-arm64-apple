# assembly-playground

Nothing fancy, just a personal repository to keep track of some code
I might write while learning Assembly and references I find helpful to Assembly resources.

So far it is focused only on Apple Silicon arm64 chip with Mach-O object file parsing.

> **Disclaimer**: For anyone out there using this as a resource. These are notes from a beginner on Assembly world. If you notice any mistakes please let me know.

## Resources

### Learning

- [How hello world for arm64 assembly really works (apple silicon)](https://www.youtube.com/watch?v=d0OXp0zqIo0)
- [Assembly no macOS M1/ARM64](https://www.youtube.com/watch?v=clyO5z_klrk)
- [ARM 64 assembly STR and LDR instructions for Apple Silicon](https://medium.com/@devslaf/arm64-assembly-str-and-ldr-instructions-for-apple-silicon-3961f621a43a)
- [Hello World in ARM64 Assembly](https://peterdn.com/post/2020/08/22/hello-world-in-arm64-assembly/)
- [Apple M1 Assembly Language Hello World](https://smist08.wordpress.com/2021/01/08/apple-m1-assembly-language-hello-world/)
- [HelloSilicon](https://github.com/below/HelloSilicon)

### Docs

- [Apple Syscall table](https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master)
- [Linux Syscall table](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [Writing ARM64 code for Apple platforms](https://developer.apple.com/documentation/xcode/writing-arm64-code-for-apple-platforms)
- [GNU Assembler](https://sourceware.org/binutils/docs/as/index.html)
- [Getting Started with Arm Assembly Language](https://developer.arm.com/documentation/107829/0200/)
- [Arm A-profile A64 Instruction Set Architecture](https://developer.arm.com/documentation/ddi0602/2022-09/Base-Instructions)
- [Overview of ARM64 ABI conventions](https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?view=msvc-170)
- [Mac OS X ABI Mach-O File Format Reference](https://web.archive.org/web/20090901205800/http://developer.apple.com/mac/library/documentation/DeveloperTools/Conceptual/MachORuntime/Reference/reference.html), also available on [this Github repository](https://github.com/aidansteele/osx-abi-macho-file-format-referencea).

### Videos

- [You can learn assembly FAST with this technique (arm64 breakdown)](https://www.youtube.com/watch?v=vhyettT7sdA)
- [Overview of ARM64 Architecture and Instruction Sets](https://www.youtube.com/watch?v=95SceqrO_TU)

### Tools

- [Compiler Explorer](https://godbolt.org/) - To have a similar assembly output from the ones we get locally with `objdump`, use it with `armv8-a clang` compiler, [example](https://godbolt.org/z/9TTEY5hf7).

## Assembly ARM

### Assembler and Syntax

Most examples of Assembly programming on the internet use the GCC Assembler with GNU-Syntax which has a good
documentation available on [GNU-Syntax Arm Assembly Language Reference Guide](https://software-dl.ti.com/codegen/docs/tiarmclang/compiler_tools_user_guide/gnu_syntax_arm_asm_language/index.html) and extensive list of resources about it. Also, they are based other CPUs than the one used by Apple (Apple silicon). That makes most of the program different then what we have here.

Since those options don't work for Apple development. We must use the Clang assembler with specific instruction set architecture for Apple processor. In this case my machine is running on [Apple M1](https://en.wikipedia.org/wiki/Apple_M1) (amr64) and has associated a ["A64" instruction set](https://developer.arm.com/documentation/ddi0602/2022-09/Base-Instructions) .

### Registers

#### x0-x30 / w0-w30

Those are the general-purpose registers used by ARM for fast access most close to the CPU. The `w` prefix is used for 32 bit and `x` prefix for 64 bit.
They are used basically as parameter and result arguments.

    The A64 ISA provides 31 general-purpose registers. For this guide, we will say that these registers are called x0 to x30, and they each contain 64 bits of data.

    In fact, A64 assembly code lets you use these registers in two different ways. Each register can be used as a 64-bit x register (x0..x30), or as a 32-bit w register (w0..w30). These are two separate ways of looking at the same register. But for this guide, we just use the x0..x30 registers.

    Reference: https://developer.arm.com/documentation/107829/0200/Assembly-language-basics/Registers

The `X18` register is reserved by Apple to its own use. We must not use it on our programs.

#### instructions

| Instruction | Description                                                 |
| ----------- | ----------------------------------------------------------- |
| `mov`       | Move a value to a register                                  |
| `store`     | Store data into the stack memory                            |
| `b`         | Branch the current execution into another label (function). |

##### Arithmetic operations

| Instruction | Signature                                     | Description                         |
| ----------- | --------------------------------------------- | ----------------------------------- |
| `add`       | `add <destination>, <register1>, <register2>` | Add the value from 2 registers      |
| `sub`       | `sub <destination>, <register1>, <register2>` | Subtract the value from 2 registers |
| `mul`       | `mul <destination>, <register1>, <register2>` | Multiply the value from 2 registers |

### Helpful commands

#### Convert decimal to hexadecimal

Numeric data is represented as hexadecimal in assembly. Here is a command to convert 1337 decimal value to hexadecimal:

    printf '%x\n' 1337
    // output: 539

And the command to convert it back to decimal:

    printf '%d\n' 0x539
    // output: 1337

Another option to convert numbers into different bases. Is using the Apple Calculator app. It has a
"Programmer Mode" which can be enabled on View → Programmer (⌘3).

---

### Notes

[Notes](NOTES.md) is a section with notes taken from different resources. Keeping them around as reference to be
used on writing my own summary later.

### Glossary

- `Darwin`: Apple OS: macOS, iOS, etc.
- [`XNU`](https://github.com/apple-oss-distributions/xnu): short for X is not Unix. Is the kernel used by Darwin based on the Mach kernel.
- `Mach-O`: short for Mach object file format. It determines the order which code and data in a binary
  file are read into memory. Programs compiled for Darwin will have this format.

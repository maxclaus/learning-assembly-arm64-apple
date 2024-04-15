# learning-assembly-arm64-apple

This is a personal repository to help me learning Assembly.

This project contains notes and small program examples on Assembly programming for Apple ARM64.

## Resources

### Articles

- [ARM 64 assembly STR and LDR instructions for Apple Silicon](https://medium.com/@devslaf/arm64-assembly-str-and-ldr-instructions-for-apple-silicon-3961f621a43a)
- [Hello World in ARM64 Assembly](https://peterdn.com/post/2020/08/22/hello-world-in-arm64-assembly/)
- [Apple M1 Assembly Language Hello World](https://smist08.wordpress.com/2021/01/08/apple-m1-assembly-language-hello-world/)
- [HelloSilicon: An introduction to assembly on Apple silicon Macs](https://github.com/below/HelloSilicon)
- [Writing ARM Assembly Programs](https://www.linuxbnb.net/home/writing-arm-assembly-programs/)(read
  this next)
- [arm64 Syscall Examples](https://github.com/l0psec/arm64_macOS_Syscalls)
- [ARMv8 AArch64/ARM64 Full Beginner's Assembly Tutorial](https://mariokartwii.com/armv8/)
- [Exploring Mach-O](https://gpanders.com/blog/exploring-mach-o-part-1/)
- [How to Read ARM64 Assembly Language](https://wolchok.org/posts/how-to-read-arm64-assembly-language/)
- [Fundamentals of ARMv8-A](http://classweb.ece.umd.edu/enee447.S2021/ARMv8-Documentation/fundamentals_of_armv8_a_100878_0100_en.pdf)
- [arm64 notes](https://johannst.github.io/notes/arch/arm64.html)

### Videos

- [How hello world for arm64 assembly really works (apple silicon)](https://www.youtube.com/watch?v=d0OXp0zqIo0)
- [Assembly no macOS M1/ARM64](https://www.youtube.com/watch?v=clyO5z_klrk) (BR Portuguese)
- [You can learn assembly FAST with this technique (arm64 breakdown)](https://www.youtube.com/watch?v=vhyettT7sdA)
- [Overview of ARM64 Architecture and Instruction Sets](https://www.youtube.com/watch?v=95SceqrO_TU)
- [ARM Assembly](https://www.youtube.com/playlist?list=PLn_It163He32Ujm-l_czgEBhbJjOUgFhg)
- [Practical ARM Assembly Tutorial Series](https://www.youtube.com/playlist?list=PLn_It163He32Ujm-l_czgEBhbJjOUgFhg)
  - [Notes about this series](/NOTES.md#armv7-assembly-lessons-by-lauriewired)
  - [Source and converted code to arm64 for Apple](/projects/arm-assembly-lessons)
- [ARM64 assembly](https://www.youtube.com/playlist?list=PLgVAKie80l4TIIAoIOmpHSccnY7TOhmNT).
  - [Converted code to arm64 for Apple](/projects/arm64-assembly)

### Docs

- [Apple Syscall table](https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master)
- [Data definition directives](https://developer.arm.com/documentation/101754/0622/armclang-Reference/armclang-Integrated-Assembler/Data-definition-directives?lang=en)
- [Writing ARM64 code for Apple platforms](https://developer.apple.com/documentation/xcode/writing-arm64-code-for-apple-platforms)
- [Getting Started with Arm Assembly Language](https://developer.arm.com/documentation/107829/0200/)
- [A64 -- Base Instructions (alphabetic order)](https://www.scs.stanford.edu/~zyedidia/arm64/index.html)
- [A64 general instructions in alphabetical order](https://developer.arm.com/documentation/dui0802/b/A64-General-Instructions/A64-general-instructions-in-alphabetical-order)
- [Arm A-profile A64 Instruction Set Architecture](https://developer.arm.com/documentation/ddi0602/2022-09/Base-Instructions)
- [Mac OS X ABI Mach-O File Format Reference](https://web.archive.org/web/20090901205800/http://developer.apple.com/mac/library/documentation/DeveloperTools/Conceptual/MachORuntime/Reference/reference.html), also available on [this Github repository](https://github.com/aidansteele/osx-abi-macho-file-format-referencea).
- [ARMv8-A A64 ISA Overview](https://armkeil.blob.core.windows.net/developer/Files/pdf/graphics-and-multimedia/ARMv8_InstructionSetOverview.pdf)
- [Armv8-A Instruction Set Architecture](https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Learn%20the%20Architecture/Armv8-A%20Instruction%20Set%20Architecture.pdf?revision=ebf53406-04fd-4c67-a485-1b329febfb3e)
- [ARM Directives](https://developer.arm.com/documentation/dui0802/b/Directives-Reference/Alphabetical-list-of-directives?lang=en)
- [armclang Integrated Assembler](https://developer.arm.com/documentation/100067/0611/armclang-Integrated-Assembler?lang=en)
- [Arm Compiler Migration and Compatibility Guide](https://developer.arm.com/documentation/100068/0612/)
- [The basics of Arm64 Assembly](https://www.deusinmachina.net/p/the-basics-of-arm64-assembly/comment/13511472)
- [Exploring AArch64 assembler](https://thinkingeek.com/categories/aarch64/)
- [Introduction to ARM AArch64 Architecture and Low-level Programming](https://hrishim.github.io/llvl_prog1_book/chapter_1.html)
- [Migrating code from ARM to ARM64](https://blog.linuxplumbersconf.org/2014/ocw/system/presentations/2343/original/08%20-%20Migrating%20code%20from%20ARM%20to%20ARM64.pdf)

### Projects/Examples

- https://github.com/sharifehsani/a64-assembly-language

### ARM64 (AArch64) Reference Sheets

- [ARM64 (AArch64) Reference Sheet](https://www.cs.swarthmore.edu/~kwebb/cs31/resources/ARM64_Cheat_Sheet.pdf)
- [ARM64 Calling Convention Cheat Sheet](https://dede.dev/posts/ARM64-Calling-Convention-Cheat-Sheet/)

### Not specific to ARM64 and Apple development, But still good Assembly References

- [RISC-V Assembler Reference](https://michaeljclark.github.io/asm.html)
- [ARM-32 Assembly By Example](https://armasm.com/)
- [Linux Syscall table](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [GNU Assembler](https://sourceware.org/binutils/docs/as/index.html)
- [GNU Assembler Directives](https://web.mit.edu/gnu/doc/html/as_7.html)
- [A Guide to ARM64 / AArch64 Assembly on Linux with Shellcodes and Cryptography](https://modexp.wordpress.com/2018/10/30/arm64-assembly/)

### Books

- Programming with 64-Bit ARM Assembly Language

### Tools

- [Compiler Explorer](https://godbolt.org/) - To have a similar assembly output from the ones we get locally with `objdump`, use it with `armv8-a clang` compiler with options `-O2 -Wall`, [example](https://godbolt.org/z/bK4e1dcfa).

## Assembly ARM64 for Apple

### Assembler and Syntax

Most examples of Assembly programming on the internet use the GCC Assembler with GNU-Syntax which has a good
documentation available on [GNU-Syntax Arm Assembly Language Reference Guide](https://software-dl.ti.com/codegen/docs/tiarmclang/compiler_tools_user_guide/gnu_syntax_arm_asm_language/index.html) and extensive list of resources about it. Also, they are based other CPUs than the one used by Apple (Apple silicon). That makes most of the program different then what we have here.

Since those options don't work for Apple development. We must use the Clang assembler with specific instruction set architecture for Apple processor. In this case my machine is running on [Apple M1](https://en.wikipedia.org/wiki/Apple_M1) (amr64) and has associated a ["A64" instruction set](https://developer.arm.com/documentation/dui0802/b/A64-General-Instructions/A64-general-instructions-in-alphabetical-order) .

### Registers

`x0-x30` / `w0-w30` are the general-purpose registers used by ARM for fast access most close to the CPU. The `w` prefix is used for 32 bit and `x` prefix for 64 bit.
They are used basically as parameter and result arguments.

    The A64 ISA provides 31 general-purpose registers. For this guide, we will say that these registers are called x0 to x30, and they each contain 64 bits of data.

    In fact, A64 assembly code lets you use these registers in two different ways. Each register can be used as a 64-bit x register (x0..x30), or as a 32-bit w register (w0..w30). These are two separate ways of looking at the same register. But for this guide, we just use the x0..x30 registers.

    Reference: https://developer.arm.com/documentation/107829/0200/Assembly-language-basics/Registers

Most common registers:

- `x0-x7`: These are general purpose registers used as input/output parameters for functions calls.
  If a function has more than 8 arguments, the rest of the arguments are passed through the stack.
- `x8`: Used as an indirect result location register.
- `x9-x15`: Temporary registers. Can be used freely within a function.
- `x16-x17`: Used as intra-procedure-call scratch registers (temporary).
- `x18`: Reserved by Apple to its own use. We must not use it on our programs.
- `x19-x28`: Callee-saved registers. Functions must save and restore these registers if used.
- `fp` (`x29`): Frame pointer, points to the stack base during a function call, to recover stack from calling function. It is used as base pointer to local variables on the stack per function. It won't change in a function scope and it will always hold the frame base pointer.
- `lr` (`x30`): Link register, saves the return address at a function call. It holds the address to return to when a subroutine call completes. It actually stores the address of the instruction to execute after the function call has been completed.
- `pc`: Program counter, contains address of the next instruction to be executed. It is incremented
  for every single instruction it runs.
- `sp`: Stack Pointer, used for dynamic memory allocation, points to the next available location on the stack.
  When the general purpose registers are not enough, we can use this to store data in the stack. It
  will be updated as the data is pushed and popped out of the stack.
- `xzr`: Zero register, always contains the value zero. [More details](https://stackoverflow.com/a/42794729/1050818).

#### Registers cheat sheet

Just a summary of the available registers for quick reference.

| Register 8 bytes   | Register 4 bytes | Short Description                          |
| ------------------ | ---------------- | ------------------------------------------ |
| `x0-x7`            | `w0-w7`          | input/output parameters for function calls |
| `x29` (alias `fp`) | `w29`            | frame pointer (FP)                         |
| `x30` (alias `lr`) | `w30`            | link register (LR)                         |
| `sp`               | `wsp`            | stack pointer (SP)                         |
| `pc`               |                  | program counter (PC)                       |
| `xzr`              | `wzr`            | zero register                              |

#### Other registers

Less used registers, but still important to mention:

- `cpsr`: Current Program Status Register - [doc](https://developer.arm.com/documentation/ddi0601/2023-12/AArch32-Registers/CPSR--Current-Program-Status-Register?lang=en).

#### Instructions

| Instruction | Description                                                 |
| ----------- | ----------------------------------------------------------- |
| `mov`       | Move a value to a register                                  |
| `store`     | Store data into the stack memory                            |
| `b`         | Branch the current execution into another label (function). |

##### Arithmetic operations

| Instruction | Signature                                      | Description                         |
| ----------- | ---------------------------------------------- | ----------------------------------- |
| `add`       | `add <destination>, <register1>, <register2>`  | Add the value from 2 registers      |
| `sub`       | `sub <destination>, <register1>, <register2>`  | Subtract the value from 2 registers |
| `mul`       | `mul <destination>, <register1>, <register2>`  | Multiply the value from 2 registers |
| `udiv`      | `udiv <destination>, <register1>, <register2>` | Divides two unsigned values         |

#### Directives

| Instruction                     | Description       | Absolute                               |
| ------------------------------- | ----------------- | -------------------------------------- |
| `.byte`                         | 8-bits (1 byte)   | Within the range [-128,255] only       |
| `.hword` (half word)            | 16-bits (2 bytes) | Within the range [-0x8000,0xffff] only |
| `.word`                         | 32-bits (4 bytes) | Within the range [-2^31,2^32-1] only   |
| `.quad`, `.dowrd` (double word) | 64-bits (8 bytes) | Within the range [-2^63,2^64-1] only   |

References:

- [Data definition directives](https://developer.arm.com/documentation/101754/0622/armclang-Reference/armclang-Integrated-Assembler/Data-definition-directives?lang=en)

### Helpful commands

#### Convert decimal to hexadecimal

Numeric data is represented as hexadecimal in assembly and some times we need to convert it to
decimal in order to better understand what that value represents.

Probably the simplest option to convert values between decimal and hexadecimal is using the Apple Calculator app.
It has a "Programmer Mode" which can be enabled on View → Programmer (⌘3).

Another option is using the terminal, here is a command to convert 1337 decimal value to hexadecimal:

    printf '%x\n' 1337
    // output: 539

And the command to convert it back to decimal:

    printf '%d\n' 0x539
    // output: 1337

---

### Notes

[Notes](NOTES.md) is a section with notes taken from different resources. Keeping them around as reference to be
used on writing my own summary later.

### Glossary

- `Darwin`: Apple OS: macOS, iOS, etc.
- [`XNU`](https://github.com/apple-oss-distributions/xnu): short for X is not Unix. Is the kernel used by Darwin based on the Mach kernel.
- `Mach-O`: short for Mach object file format. It determines the order which code and data in a binary
  file are read into memory. Programs compiled for Darwin will have this format.

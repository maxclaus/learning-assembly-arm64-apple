# Notes

This is a section with notes taken from different resources. Keeping them around as reference to be
used to write my own summary later.

## An Overview of the ARM Assembly Language Instruction Set

Notes taken from: [An Overview of the ARM Assembly Language Instruction Set](https://www.youtube.com/watch?v=GBRdzaAxHB8)

### Registers

- 31 64-bit integer registers labeled X0 to X30
- XZR is the Zero Register
- SP is the Stack Pointer
  - Both XZR and SP are encoded as X31
- Lower 32-bits can be referred to as W0 to W30 and WZR
- PC is the Program Counter
- SPSR is the Program Status Register
- There are shadow register for the SPSR, SP for each exception level to help with multitasking and
  interrupts

### How to Load a 64-bit Register?

One option, painful but guaranteed way, is to use 4 instructions, each loads 16-bits (1/4 of the address):

```asm
// Load X2 with 0x1234FEDC4F5D (1311953613649440314 in decimal):
MOV     X2 #Ox6E3A
MOVK    X2 #Ox4F5D
MOVK    X2 #OxFEDC
MOVK    X2 #Ox1234
```

`MOVK` it is an alias to another instruction, (which instruction though?)

There are more options using `LDR` instruction. Check out the video for more details.

### Arithmetic Logic Unit (ALU)

- ADD, SUB, MUL, DIV
- Many multiply-add instructions
- Comparisons
- Logical operations AND, XOR, etc.
- Bitwise operations

### Memory Accessing Modes

- `LDR X3, [X1]`: Load X3 with the 64-bits pointed to by the address in X1
- `LDR X3, [X1, #8]`: Load X3 with the 64-bits pointed to by the address in X1 plus 8
- `LDR X3, [X1, #8]!`: Same as above but `X1=X1+8` after
- `LDR X3, [X1], #8`: Load from X1, but `X1=X1+8` after

## Shellcode for macOS on M1 chips

Notes taken from [Shellcode for macOS on M1 chips - Part 1: Quick overview of ARM64](https://www.youtube.com/watch?v=9-rgo57Ew2g).

### ARM Architecture

ARM processors are designed by the [Arm Holdings Ltd.](https://www.arm.com/). The company does not produce chip itself, but licenses chip designs for production by other companies.
For instance, App designed its own [M1 Chip](https://en.wikipedia.org/wiki/Apple_M1) with RAM processors for macOS in late 2020. Previously,
it was only supported on Intel chips with x86/x64 architecture.

It uses RISC technology (Reduced Instruction Set Computer):

- Use simple, and more elementary instructions compared to CISC architectures (Complex Instruction
  Set Computer) such as x86/x64 by
  Intel or AMD.
- For example, memory access operations and arithmetic operations are always separate.
- This usually leads to longer programs with more instructions compared to x86/x64.

#### Registers

- Any data must be loaded into a general purpose register to operate on it and then stored back into
  memory.
- Every instruction encoding is 32 bit wide. Code must be aligned to 4-byte boundary.
- ARM64 has 31 general purpose registers named X0 to X30 (more than x86/x64). Their lower 32 bits
  can be addressed by the names W0 to W30.
- Special registers:
  - **Program counter** `PC`: contains address of the next instruction to be executed.
  - **Stack pointer** `SP`: points to dynamic memory available during program execution.
  - **Frame pointer** `FP` (`=x29`): points to the stack base during a function call, to recover stack
    from calling function.
  - **Link register** `LR` (`=30`): saves the return address at a function call.
  - **Zero register** `XZR`: always contains the value zero.
  - Specially on macOS: `X18` is reserved (do not use it!).
- Instructions set comprises the usual arithmetic, logical, and branching operations.
- ARM64 offers different levels of privilege for code execution; two are relevant for us:
  - **User mode** (`USR`): least privileged, standard for program execution.
  - **Surpervisor mode** (`SVC`): kernel level privileges.

```asm
.global _main
.align 4

_main:
    mov X0, #1          ; arg[0] = 1 = STDOUT
    adr X1, helloworld  ; arg[1] = string to pring
    mov X2, #16         ; arg[2] = length of our string
    mov X16, #4         ; Unix write system call

    mov X0, #0          ; Use 0 return code
    mov X16, #2         ; Unix exit system call
    svc #0xFFFF         ; call kernel to end program

helloworld: .ascii "Hello M1-World!\n"
```

Every ARM64 instruction is encoded by 32 bits.

- Can lead to larger code than equivalent x86/x64 code.
  How to work with 64-bit registers if instructions are only 32 bits wide?
- Usually, only 16 bit of data can be processed in one instruction.
- Combine multiple instructions to process larger chunks of data.

Recall that ARM processors cannot operate directly on data in memory.
First, load data into a register:

```asm
ldr X0, [X1]
```

Where X1 contains the memory address of our data, and when done, store that data back in memory:

```asm
str X0, [X1]
```

We can access memory at an offset from X1, say 4 bytes:

```asm
ldr X0, [X1, #4]
str X0, [X1, #4]
```

We can move data from other register or immediate values into a register

```asm
mov X0, X1
mov X0, #0x1234
```

Using `movn` instead of `mov` negates (bitwise) the argument before moving it.

We can only move 16-bit values into a register. TO fill it with larger values, use:

```asm
movk X0, #x5678, lsl #n
```

Where `n` is 0, 16, 32, or 48. This shifts the second argument (here 0x5678) to the position indicated by the `lsl` argument,
keeps all the over values in the register.

```asm
mov X0, #0x3210
mov X0, #0x7654, lsl #16
mov X0, #0xBA98, lsl #32
mov X0, #0xFEDC, lsl #48
```

Fills `X0` with the value `0xFEDCBA9876543210`.

## ARMV7 Assembly Lessons by LaurieWired

These are lessons on ARMv7 32-bit for Linux and the assembly syntax is a bit
different than the one used by ARMv8 64-bit for Apple. But they are similar enough
for us to use it as resource to learn about assembly programming, specially because
the lessons are very well explained by Laurie, going beyond just the syntax and covering
as well other important topics such as conversion between data formats and so on.

Code for these lessons and its conversion to arm64 are at [projects/arm-assembly-lessons](/projects/arm-assembly-lessons).

### ARM Assembly: Lesson 1 (MOV, Exit Syscall)

Notes taken from [ARM Assembly: Lesson 1 (MOV, Exit Syscall)](https://www.youtube.com/watch?v=kKtWsuuJEDs).

On ARMv7 registers are hexadecimal values (8 values) with 4-bits each, which gives the total of
32-bits per register.

**Registers**

- `r0-r6`: General purpose registers, that we can use through out our program
- `r7`: Special register, used to target the system call we want to run
- `sp`: Stack Pointer, points to the next available location on the stack. When the general purpose
  registers are not enough, we can use this to store data in the stack.
- `pc`: Program Counter, it is incremented for every single instruction it runs.

First program

- `.global`: Makes a label visible outside of the program for the linker.
- `.section .text`: Section that holds the instructions of the program.
- `.section .data`: Section that holds data such as strings and arrays used by the program.

### ARM Assembly: Lesson 2 (ADD, SUB, MUL, set CPSR)

Notes taken from [ARM Assembly: Lesson 2 (ADD, SUB, MUL, set CPSR)](https://www.youtube.com/watch?v=xQ--xX9rHeE).

- `add`, `sub`, `mul`: arithmetic instructions to sum, subtract, and multiply.
- `cpsr`: Current Program Status Register. It holds the current state of the running program. The
  bits in the CPSR register comprise different flags that are updated when certain conditions occur.
  [Documentation](https://developer.arm.com/documentation/ddi0406/cb/System-Level-Architecture/The-System-Level-Programmers--Model/ARM-processor-modes-and-ARM-core-registers/Program-Status-Registers--PSRs-. For instance, if an arithmetic instruction executions results on a negative number or an overlfow, it will set a flag in CPSR describing that state. In order to that state to be saved on CPRS though, the instruction needs to have the `s` suffix, so instead of using `add` we would use `adds`.

### ARM Assembly: Lesson 3 (LDR, STR)

Notes taken from [ARM Assembly: Lesson 3 (LDR, STR)](https://www.youtube.com/watch?v=fJcdt7WMQCs).

- ARM uses a load-store architecture. Only load and store instructions can access memory.
- `.data` segment contains any complex data that won't be stored inside the register such as an array
  or string. It contains the data that we need while executing the program.
- `.word` data type is comprised of 2-bytes (16-bits)
- `.text` segment contains the executed code.
- `ldr`: Load Register, load data from an area/label on memory into a register.

### ARM Assembly: Lesson 4 (Logical Operators)

Notes taken from [ARM Assembly: Lesson 4 (Logical Operators)](https://www.youtube.com/watch?v=IJw1wm3Kb0Q).

Logical operators manipulate the bits inside of the register.

- `AND`: Copy value if both are true.
- `ORR`: Copy value if any value is true.
- `EOR`: (Exclusive OR) Copy value if any value is true.
- `MVN`: Inverse value. Copy the inverse value.

### ARM Assembly: Lesson 5 (Signed Number Conversions)

Notes taken from [ARM Assembly: Lesson 5 (Signed Number Conversions)](https://www.youtube.com/watch?v=9wvzEOq1imo).

Data types:

- Nibble: 4-bits (fun fact, in English nibble means small bytes, eat gently).
- Byte: 8-bits
- Halfword: 16-bits
- Word: 32-bits

Each processor register has 8 hexadecimal numbers. Each digit are represented by 4-bits. Which means
each register holds 32-bits.

Negative numbers:

Computers use two's complement to represent signed numbers. 1 bit is suppose to represent the actual
sign of number.

- 1: means the number is negative
- 0: means the number is positive

And, all of the bits on the left hand side of the number are actually going to be padded the same
value of that individual sign bit.

| Hexadecimal | Decimal |
| ----------- | ------- |
| 0           | 0       |
| 1           | 1       |
| 2           | 2       |
| 3           | 3       |
| 4           | 4       |
| 5           | 5       |
| 6           | 6       |
| 7           | 7       |
| 8           | 8       |
| 9           | 9       |
| A           | 10      |
| B           | 11      |
| C           | 12      |
| D           | 13      |
| E           | 14      |
| F           | 15      |

Each bit on binary represents power of 2. Here is the table of values for power of 2
from right-left direction so it is easier to compare with binary format.

| 2⁵  | 2⁴  | 2³  | 2²  | 2¹  | 2⁰  |
| --- | --- | --- | --- | --- | --- |
| 32  | 16  | 8   | 4   | 2   | 1   |

To convert Hex to Binary, we get the hex value and find how much of the power of 2 we need to get
that value in hex, then we use the position for those values from the power of 2 table to build the
binary value.

Positive value examples:

| Type   | Data                                                  |
| ------ | ----------------------------------------------------- |
| Hex    | `   0    0    0    0    0    0       1       9`       |
| Binary | `0000 0000 0000 0000 0000 0000 0_0_0_1 1_0_0_1`       |
| Dec    | `   0    0    0         0           16+8+0+0+1  = 25` |

| Type   | Data                                                 |
| ------ | ---------------------------------------------------- |
| Hex    | `   0    0    0    0    0    0       1       0`      |
| Binary | `0000 0000 0000 0000 0000 0000 0_0_0_1 0_0_0_0`      |
| Dec    | `   0    0    0         0           16       0 = 16` |

Negative value examples:

Convert to positive by flipping all bits except the least significant bit (LSB) that is nonzero and
all bits to its right.

| Type     | Data                                                    |
| -------- | ------------------------------------------------------- |
| Hex      | `   f    f    f    f    f    f      e          7`       |
| Binary   | `1111 1111 1111 1111 1111 1111 _1_1_1__0 0_1_1_1`       |
| Positive | `0000 0000 0000 0000 0000 0000 _0_0_0__1 1_0_0_1`       |
| Dec      | `   0    0    0         0             16+8+0+0+1 = -25` |

Remembering, we know it is a negative number because all the numbers on binary
format are repeating on the left with the negative sign bit which is `1`.

| Type     | Data                                                |
| -------- | --------------------------------------------------- |
| Hex      | `   f    f    f    f    f    f    f       0`        |
| Binary   | `1111 1111 1111 1111 1111 1111 1_1_1_1 0000`        |
| Positive | `0000 0000 0000 0000 0000 0000 0_0_0_1 0000`        |
| Dec      | `   0    0    0         0           16    0  = -16` |

### ARM Assembly: Lesson 6 (Shift and Rotate)

Notes taken from [ARM Assembly: Lesson 6 (Shift and Rotate)](https://www.youtube.com/watch?v=aGJm3fuKLhA).

- `lsl`: Shift left. Shifts all bits to left. Basically, shifting left by 1 is equivalent to
  multiplying the number by 2.
- `lsr`: Shift right. Shifts all bits to right. Basically, shifting right by 1 is equivalent to
  dividing the number by 2. It does not recognize the sign bit though, so even if it a negative
  number, it will get padded with 0, which would turn that number positive.
- `asr`: Arithmetic shifts right pad to match the sign bit (it pads 0 for positive
  number and 1 for negative numbers).
- `ror`: Rotate right. Rotate bits around to right. The bit removed from the most right gets
  inserted back to the most left.
- `rrx`: Rotate right with Extended. THe same as `ror` but also uses the carry bit inside CPSR (Current Program Status Register).

### ARM Assembly: Lesson 7 (CMP)

Notes taken from [ARM Assembly: Lesson 7 (CMP)](https://www.youtube.com/watch?v=nDGy-PQ1gVs).

- `cpm`: Compare register by subtracting the second argument from the first argument, and CPSR (Current Program Status Register) gets set based on the result.
  - Negative bit is set when the result is negative (the first arg was smaller then the second arg)
  - Carry bit is set when the result is positive (the first arg was bigger then the second arg)
  - Zero and Carry bit is set when the result is zero (both args had the same value)

The CPM instruction is generally used right before branch instructions.

### ARM Assembly: Lesson 8 (Branching)

Notes taken from [ARM Assembly: Lesson 8 (Branching)](https://www.youtube.com/watch?v=VeDPnWA_GVI).

- `b`: unconditional branch,
  [reference](https://developer.arm.com/documentation/ddi0403/d/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-ARMv7-M-Thumb-instructions/B?lang=en). For conditional branch check out [conditional
  execution](https://developer.arm.com/documentation/ddi0406/c/Application-Level-Architecture/Instruction-Details/Conditional-execution) for extensions it support such as beq, bneq, and etc.

### ARM Assembly: Lesson 9 (While Loops)

Notes taken from [ARM Assembly: Lesson 9 (While Loops)](https://www.youtube.com/watch?v=rg3aBTjsUms).

- Labels name a certain location in memory.
- Use `cmp` and `b` to implement a loop.

### ARM Assembly: Lesson 10 (Function Calls)

Notes taken from [ARM Assembly: Lesson 10 (Function Calls)](https://www.youtube.com/watch?v=pnnOL7kfkz0).

- The first four arguments to a function are stored in registers r0-r3 and the remaining arguments
  are pushed into the stack.
- `lr` A link register is a register which holds the address to return to when a subroutine call completes. It actually stores the address of the instruction to execute after the function call has been completed.
- `bl` Branch link, goes to a branch and sets the `lr`.
- `bx` Branch and Exchange, causes a branch to an address and instruction set specified by a
  register, for instance `bx lr`.
- `push` Store registers on the stack to avoid losing their values during function calls.
- `pop` Pop the value that we last pushed on the stack and stores to specified register.
- `sp` Stack pointer. Holds the address of the stack memory.

[Armv8.1-M Pointer Authentication and Branch Target Identification Extension](https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/armv8-1-m-pointer-authentication-and-branch-target-identification-extension).

### ARM Assembly: Lesson 11 (Stack Operations)

Notes taken from [ARM Assembly: Lesson 11 (Stack Operations)](https://www.youtube.com/watch?v=56VrSY-F7_o).

- `sub` The subtract command can be used to allocate space on the stack.
  The stack grows downward in memory. Subtract from the stack pointer to allocate space
  for new values.
- `push` and `pop` commands update the stack pointer register automatically.

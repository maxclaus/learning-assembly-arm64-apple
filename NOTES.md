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

    // Load X2 with 0x1234FEDC4F5D (1311953613649440314 in decimal):
    MOV     X2 #Ox6E3A
    MOVK    X2 #Ox4F5D
    MOVK    X2 #OxFEDC
    MOVK    X2 #Ox1234

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
  - **Frame pointer** `FP` (`=x29`): points to the stack bacse during a function call, to recover stack
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

```
ldr X0, [X1]
```

Where X1 contains the memory address of our data, and when done, store that data back in memory:

```
str X0, [X1]
```

We can access memory at an offset from X1, say 4 bytes:

```
ldr X0, [X1, #4]
str X0, [X1, #4]
```

We can move data from other register or immediate values into a register

```
mov X0, X1
mov X0, #0x1234
```

Using `movn` instead of `mov` negates (bitwise) the argument before moving it.

We can only move 16-bit values into a register. TO fill it with larger values, use:

```
movk X0, #x5678, lsl #n
```

Where `n` is 0, 16, 32, or 48. This shifts the second argument (here 0x5678) to the position indicated by the `lsl` argument,
keeps all the over values in the register.

```
mov X0, #0x3210
mov X0, #0x7654, lsl #16
mov X0, #0xBA98, lsl #32
mov X0, #0xFEDC, lsl #48
```

Fills `X0` with the value `0xFEDCBA9876543210`.

### ARMV7 Assembly Lessons by LaurieWired

Notes taken from [ARM Assembly: Lesson 1 (MOV, Exit Syscall)](https://www.youtube.com/watch?v=kKtWsuuJEDs&t=304s).

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

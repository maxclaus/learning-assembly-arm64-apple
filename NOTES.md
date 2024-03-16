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

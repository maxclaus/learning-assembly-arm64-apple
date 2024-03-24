// Program based on this tutorial:
// https://www.youtube.com/watch?v=kKtWsuuJEDs
//
// This program can be tested on https://cpulator.01xz.net/ with ARMV7
.global _start

.section .text

_start:
	// https://developer.arm.com/documentation/dui0068/b/ARM-Instruction-Reference
	// https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md#arm-32_bit_EABI
	// r0 = register used for the first argument, which will be passed to the syscall
	// 42 = exist status code
	// r7 register is used to mark a syscall execution
	// 1 = exit syscall
	mov r0, #42
	mov r7, #1
	swi 0

// Program based on this tutorial:
// https://www.youtube.com/watch?v=kKtWsuuJEDs
//
// This program can be tested on https://cpulator.01xz.net/ with ARMV7
//
// References:
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/ADD--immediate--ARM-
// - https://developer.arm.com/documentation/ddi0406/cb/Application-Level-Architecture/Instruction-Details/Alphabetical-list-of-instructions/SUB--immediate--ARM-

.global _start

.section .text

// ADD{S}<c> <Rd>, <Rn>, #<const>
// SUB{S}{<c>}{<q>}  {<Rd>,} <Rn>, #<const>
_start:
	mov r0, #4
	add r1, r0, #3 // sum instruction

	mov r0, #10
	mov r1, #5
	sub r2, r0, r1 // subtraction instruction


	mov r0, #2
	mov r1, #3
	mul r2, r0, r1 // multiply instruction


	mov r0, #3
	mov r1, #3
	subs r2, r0, r1 // subtraction instruction saving flags to CPSR
	// In the case above the result will be 0, since we are using
	// the `s` suffix for the `sub` instruction, it will save a zero
	// flag on CPSR.

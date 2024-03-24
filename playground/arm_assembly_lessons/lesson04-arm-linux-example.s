// Program based on this tutorial:
// https://www.youtube.com/watch?v=IJw1wm3Kb0Q
//
// This program can be tested on https://cpulator.01xz.net/ with ARMV7

// To convert values
// https://www.rapidtables.com/convert/number/decimal-to-hex.html
// https://www.rapidtables.com/convert/number/decimal-to-binary.html
// https://www.rapidtables.com/convert/number/binary-to-decimal.html

.global _start

_start:

	mov r0, #0x42		// decimal=66, binary=001000010
	and r1, r0, #0x26	// decimal=38, binary=000100110
	// result should be	   decimal=2,  binary=000000010

	mov r0, #0x42		// decimal=66,	binary=001000010
	orr r1, r0, #0x26	// decimal=38,	binary=000100110
	// result should be	   decimal=102, binary=001100110

	mov r0, #0x42		// decimal=66,	binary=001000010
	eor r1, r0, #0x26	// decimal=38,	binary=000100110
	// result should be	   decimal=100, binary=001100100

	mov r0, #0x42		// decimal=66,	binary=001000010
	mvn r1, r0
	// result should be	   decimal=411, binary=110011011

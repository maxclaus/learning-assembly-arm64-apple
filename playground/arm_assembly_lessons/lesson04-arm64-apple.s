// Program adapted from linux arm to apple arm64
// based on "lesson04-arm-linux-example.s".

.global _start

_start:
	// Different than the original code from arm 32,
	// in arm 64 we cannot use immediate as argument
	// for anything bigger than 4-bit (in decimal 4).
	// Because of that, we need to set the bigger values
	// to a register first.
	// https://kddnewton.com/2022/08/11/aarch64-bitmask-immediates.html#bitmask-immediates
	// https://stackoverflow.com/q/30904718/1050818
	mov x0, #0x42	//                  decimal=66, binary=001000010
	mov x1, #0x26   //                  decimal=38, binary=000100110
	and x2, x0, x1  // result should be decimal=2,  binary=000000010

	mov x0, #0x42   //                  decimal=66,  binary=001000010
	mov x1,  #0x26	//                  decimal=38,  binary=000100110
	orr x2, x0, x1  // result should be decimal=102, binary=001100110

	mov x0, #0x42	//                  decimal=66,	 binary=001000010
	mov x1, #0x26	//                  decimal=38,	 binary=000100110
	eor x2, x0, x1	// result should be	decimal=100, binary=001100100

	mov x0, #0x42	//	                decimal=66,	 binary=001000010
	mvn x1, x0      // result should be	decimal=411, binary=110011011

	// Exit program
	mov X0, 0		// 0 status code
	mov X16, 1
	svc 0

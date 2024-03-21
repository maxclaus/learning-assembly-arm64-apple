; Program adapted from arm 32 to apple arm64
; based on "lesson01-arm32-linux-example.s".
.global _start

_start:
	; X0 = register used for the first argument, which will be passed to the syscall
	; 42 = exist status code
	; X16 register is used to mark a syscall execution
	; 1 = exit syscall
	mov X0, #42
	mov X16, #1
	svc 0

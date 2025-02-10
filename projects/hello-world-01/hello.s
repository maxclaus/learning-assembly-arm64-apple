; Based on example from https://www.youtube.com/watch?v=9-rgo57Ew2g
.global _main

_main:
    mov X0, #1          ; arg[0] = 1 = STDOUT
    adr X1, helloworld  ; arg[1] = string to print
    mov X2, #16         ; arg[2] = length of our string
    mov X16, #4         ; Unix write system call
	svc 0				; call kernel for the above syscall

    mov X0, #0          ; Use 0 return code
    mov X16, #1         ; Unix exit system call
	svc 0				; call kernel for the above syscall

helloworld:
	.ascii "Hello M1-World!\n"

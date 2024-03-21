; TODO: convert this to macOS arm64
; Example from https://www.youtube.com/watch?v=HlUBE70h2C0
; but it has been adaptated for arm64
.section .text

allocate:
	push {lr}

	mov r0, #0      ; addr: NULL, let the kernel choose the memroy address
	mov r1, #4096   ; lenght: size of memory to map (e.g. one page of 4096 bytes)
	mov r2, #3		; prot: PROT_READ | PROT_WRITE
	mov r3, #0x22   ; flags: MAP_PRIVATE | MAP_ANONYMOUS
	mov r4, #-1     ; fd: -1 because  we are not mapping a file
	mov r5, #0		; offset: 0

	mov r7, #182    ; set we will call the mmap2 syscall next
	svc #0          ; call surpervisor for the previous syscall,
					; the response, which is the memory address, will be at r0 register

	cpm r0, #-1			; if the allocation fails, the syscall will return -1
	beq alloc_failed	; if -1, then call alloc_failed

	mov r1, #42			; move 42 immediate value into the r1 register
	str r1, [r0]		; store the value from r1, into the memory address at r0

	b alloc_exit        ; call alloc_exit to pop out of this current funcition
						; and get back to main

alloc_failed:
	mov r0, #-1

alloc_exit:
	pop {pc}		; pop out of the current function

main:
	push {r4-r7, lr}

	; Allocate space for the number
	bl allocate
	cpm r0, #-1
	beq print_fail

	push {r0}
	ldr r1, [r0] ; pointer is inside r0

	; Print to the console
	ldr r0, =format_str
	bl printf

	; Deallocate the memory
	pop {r0}
	mov r1, #4096		; bytes length to dealocate starting from the address on r0

	; munmap syncall
	mov r7, #215
	svc #0

	b exit

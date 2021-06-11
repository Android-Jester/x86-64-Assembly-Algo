;running commands
;nasm -f elf64 input+compare.asm
;ld -m elf_x86_64 -s -o input+compare input+compare.o


section .data
	question db "Please enter three numbers: "
	lenQue equ $ - question
	msg db "The largest number is: ",
	lenmsg equ $ - msg

section .bss
	num1 resb 20
	num2 resb 20./
	num3 resb 20
	large resb 20

section .text
	global _start

_start:
	call _printQuestion
	call _getFirstValue
	call _getSecondValue
	call _getThirdValue
	call _compare
	call _exit

_printQuestion:
	mov rax, 1
	mov rdi, 1
	mov rsi, question
	mov rdx, lenQue
	syscall
	ret

_getFirstValue:	
	mov rax, 0
	mov rdi, 2
	mov rsi, num1
	mov rdx, 5
	syscall
	ret

_getSecondValue:
	mov rax, 0
	mov rdi, 2
	mov rsi, num2
	mov rdx, 5
	syscall
	ret

_getThirdValue:
	mov rax, 0
	mov rdi, 2
	mov rsi, num3
	mov rdx, 5
	syscall
	ret

_compare:
mov rcx, [num1]
cmp rcx, [num2]
jl replace
jg check_third

replace:
    mov rcx, [num2]

check_third:
    cmp rcx, [num3]
    jg _exit
    mov rcx, [num3]

_exit:
    mov [large], rcx
	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, lenmsg
	syscall
    
	mov rax, 1
	mov rdi, 1
	mov rsi, large
	mov rdx, 5
	syscall
	
	mov rax, 60
	syscall

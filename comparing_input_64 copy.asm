
;running commands
;nasm -f elf64 input+compare.asm
;ld -m elf_x86_64 -s -o input+compare input+compare.o


section .data
	question db 'Please enter a number: '
	lenQue equ $ - question
	msg db "The largest number is: ",
	lenmsg equ $ - msg
    num2 dq '35'
    num3 dq '65'

section .bss
	num1 resb 5
	large resb 5

section .text
	global _start

_start:
	call _printQuestion
	call _getInputValue
	call _compare
	call _exit

_printQuestion:
	mov rax, 1
	mov rdi, 1
	mov rsi, question
	mov rdx, lenQue
    syscall
	ret

_getInputValue:	
	mov rax, 0
	mov rdi, 2
	mov rsi, num1
	mov rdx, 5
	syscall
	ret

_compare:
mov rsi, [num1]
cmp rsi, [num2]
jl replace
jg check_third

replace:
    mov rsi, [num2]

check_third:
    cmp rsi, [num3]
    jg _exit
    mov rsi, [num3]

_exit:
    mov [large], rsi
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
	; mov ebx, 0
	syscall

;rename the extension from .txt to .asm
;running commands
;nasm -f elf input+compare.asm
;ld -m elf_i386 -s -o input+compare input+compare.o

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
	mov eax, 4
	mov ebx, 1
	mov ecx, question
	mov edx, lenQue
	int 0x80
	ret

_getInputValue:	
	mov eax, 3
	mov ebx, 2
	mov ecx, num1
	mov edx, 5
	int 0x80
	ret

_compare:
	mov ecx, [num1]
	cmp ecx, [num2]
	jl replace
	jg check_third

replace:
    mov ecx, [num2]
	jmp check_third

check_third:
    cmp ecx, [num3]
    jg _exit
    mov ecx, [num3]

_exit:
    mov [large], ecx
    mov eax, 4
	mov ebx, 1
	mov ecx, msg
    mov edx, lenmsg
    int 0x80
    
    mov eax, 4
    mov ebx, 1
	mov ecx, large
	mov edx, 5
    int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80

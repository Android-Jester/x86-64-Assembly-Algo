;running commands
;nasm -f elf input+compare.asm
;ld -m elf_i386 -s -o input+compare input+compare.o


section .data
	question db 'Please enter three number: '
	lenQue equ $ - question
	msg db "The largest number is: ",
	lenmsg equ $ - msg

section .bss
	num1 resb 5
	num2 resb 5
	num3 resb 5
	large resb 5

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
	mov eax, 4
	mov ebx, 1
	mov ecx, question
	mov edx, lenQue
	int 0x80
	ret

_getFirstValue:	
	mov eax, 3
	mov ebx, 2
	mov ecx, num1
	mov edx, 5
	int 0x80
	ret

_getSecondValue:
	mov eax, 3
	mov ebx, 2
	mov ecx, num2
	mov edx, 5
	int 0x80
	ret

_getThirdValue:
	mov eax, 3
	mov ebx, 2
	mov ecx, num3
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


	; mov eax, 4
	; mov ebx, 1
	; mov ecx, dispMsg
	; mov edx, lenDispMsg
	; int 0x80

	; mov eax, 4
	; mov ebx, 1
	; mov ecx, num
	; mov edx, 5
	; int 0x80

	

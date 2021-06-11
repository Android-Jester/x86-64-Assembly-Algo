section .text
    global _start

%macro print 2
    mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro input 2
    mov rax, 0
	mov rdi, 2
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro


_start:
    input count, 20
    print msg, len	
    print s2, 9
    
	
    mov rax, 60
    syscall

section .bss
    count resb 20

section .data
    msg db "Displaying 9 stars ", 0xa
    len equ $ - msg
    s2 times 9 db "*"
	

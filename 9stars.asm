section .text
    global _start

_start:

    call _printQuestion
    call _readInput
    call _compare

    ; writes out the question "What is your input?"
_printQuestion:
    mov rax, 1
    mov rdi, 1
    mov rsi, question
    mov rdx, lenQue
    syscall
    ret

    ;reads the input of the reader
_readInput:
    mov rax, 0 
	mov rdi, 2 
	mov rsi, count 
	mov rdx, 20 
	syscall
    ret


_compare:
    mov rcx, [printifG]
    cmp rcx, [count]
    jl _printStart
    

_exit:
    mov rax, 60 ;standard exit code
    syscall

_printStart:
    mov rax, 1 ;system write
	mov rdi, 1 ;file descriptor(standard output)
	mov rsi, msg ;takes in the byte space by label to read value
	mov rdx, len ;takes in the size of the byte space
	syscall

    mov rax, 1 ;system write
	mov rdi, 1 ;file descriptor(standard output)
	mov rsi, s2 ;takes in the byte space by label to read value
	mov rdx, 9 ;takes in the size of the byte space
	syscall

    jmp _exit

section .bss
    count resb 20 ;reserves 20 bytes of memory space for a value in count

section .data
    question db "What is the input? "
    lenQue equ $ - question
    printifG dq '12'
    msg db "Displaying 9 stars ", 0xa ;sets the value of msg as 
    len equ $ - msg ;takes the length
    s2 times 9 db "*" ;sets the value of s2 9 times 
	

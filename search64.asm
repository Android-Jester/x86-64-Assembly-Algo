section .data
        ; fmt db "%d", 10,0

        msg1 db "The position is "
        lenmsg1 equ $- msg1

        indication db "The value to be found is "
        lenindi equ $- indication
        ; target dd 3
        list dd 0,1,2,3,4,5,6,7,8,9
        len equ $ - list

section .bss
        printing resb 1
        target resb 1
section .text

; macro to write the values
%macro write 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

; macro to read the values
%macro read 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

; macro to exit the code
%macro exit 0
    mov rax, 60
    syscall
%endmacro

        global main
        ; extern printf

main:
        write indication, lenindi ;prints out the text "The value to be found is "
        read target, 1 ; reads the input value and stores it in the target
        
        ;removes 48("0") from the input 
        mov rax, [target]
        sub rax, 48
        mov [target], rax


        mov r12, list ;moves the initial value into the r12 register "0"
        mov r13, len >> 3;moves the length of the array, shifts it to the right by three thus divided by 2^3
        test r13, 0 ;performs a "TEST" to see if the value is equal to 0
        jz is_even ;when the test is zero it jumps to is_even
        inc r13 ;increments the value of r13 when the value is greater than than of zero

is_even: 
        push r13 ;pushes unto the stack
        shl r13,2 ;shifts the value to the left by 2 thus multiplied by 2^2 
        add r12,r13 ;add the len+1 to the r12 value
        pop r13 ;removes the value from the stack and stores it in r13


search:
        shr r13,1 ;shifts the value to the right by 1 thus divided by 2^1 
        push r13 ; pushes the len+1 to the stack
        shl r13,2 ;shifts the value of len+1 to the left by 2 thus multiplies the value by 2^2

    
        mov r14d,dword[r12]  ;increases the byte space of the value in r12(midpoint) and moves it towards the value r14d
        cmp r14d,dword[target] ;compares the input and the value of r14d
        je finish ;if the values are the same, it jumps to finish
        jl search_right ;if the value is less than that of the input it jumps to search_right
        jg search_left ;if the value is greater than that of the input it jumps to search_left
    
    
search_left:
        sub r12,r13 ;subtracts the value of r13 from the midpoint
        pop r13 ;removes the value from the stack and places it in r13
        jmp search ;jumps to search
    
search_right:
        add r12,r13 ;adds the value of r13 to the midpoint
        pop r13 ;removes the value from the stack and places it in r13
        jmp search ;jumps to search

finish:
        write msg1, lenmsg1 ;writes the value "The position is "
        ; lea rcx,[fmt] 
        mov rdx, r12 ;moves the position found to the rdx register
        sub rdx, list ;removes the first value from the position to get the exact position
        shr rdx, 2 ;shifts to the right by 2 thus multiplies the value by 2^2
        add rdx, 49 ;adds "0" to get the ascii value for the number
        mov [printing], rdx ;moves the value of the position to "printing" memory location

        ; sub rsp,40
        write printing, 1
        ; add rsp,40
        exit        
        ; mov rax,0
        ; mov rdi, 0
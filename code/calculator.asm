section .bss 
    msg resb 20 ; this is the msg
    i1 resb 20 ; this is input 1
    i2 resb 20 ; this is input 2
    sum resb 20 ; sum of i1 and i2

section .text
    global _start

_start:
    ; read i1
    mov rax, 0
    mov rdi, 0
    lea rsi, [i1]
    mov rdx, 20
    syscall
    mov rbx, rax        ; save length of i1

    ; read i2
    mov rax, 0
    mov rdi, 0
    lea rsi, [i2]
    mov rdx, 20
    syscall
    mov rcx, rax        ; length of i2

    lea rsi, [i1]
    lea rdi, [sum]
    mov rdx, rbx        ; length of i1

    lea rsi, [i2]
    mov rdx, rcx        ; length of i2



    mov rax, 1
    mov rdi, 1
    lea rsi, [sum]
    mov rdx, rbx
    add rdx, rbx        ; total length
    syscall


    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall

.copy_i1:
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    dec rdx
    jnz .copy_i1

.copy_i2:
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    dec rdx
    jnz .copy_i2

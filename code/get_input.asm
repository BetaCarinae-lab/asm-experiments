section .bss
    input resb 20      ; reserve 20 bytes for user input

section .text
    global _start

_start:
    ; --- read input ---
    mov rax, 0       ; sys_read
    mov rdi, 0       ; stdin
    lea rsi, [input] ; buffer
    mov rdx, 20      ; max bytes to read
    syscall          ; rax = number of bytes read

    ; --- for demo, just write it back ---
    mov rdx, rax     ; length = bytes read
    mov rax, 1       ; sys_write
    mov rdi, 1       ; stdout
    lea rsi, [input] ; buffer
    syscall

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall
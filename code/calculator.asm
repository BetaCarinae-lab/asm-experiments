section .bss 
    msg resb 20 ; this is the msg
    i1 resb 20 ; this is input 1
    i2 resb 20 ; this is input 2

section .text
    global _start

_start:
    ; --- read input ---
    mov rax, 0       ; sys_read
    mov rdi, 0       ; stdin
    lea rsi, [msg]   ; buffer
    mov rdx, 20      ; max bytes to read
    syscall          ; rax = number of bytes read

    ; --- for demo, just write it back ---
    mov rdx, rax     ; length = bytes read
    mov rax, 1       ; sys_write
    mov rdi, 1       ; stdout
    lea rsi, [msg] ; buffer
    syscall

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall
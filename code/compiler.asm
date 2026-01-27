section .bss
input   resb 256
output  resb 1024

section .data
template1 db "section .data",10
          db "msg db ",0
template2 db ", 10",10
          db "len equ $ - msg",10,10
          db "section .text",10
          db "global _start",10,10
          db "_start:",10
          db "    mov rax, 1",10
          db "    mov rdi, 1",10
          db "    mov rsi, msg",10
          db "    mov rdx, len",10
          db "    syscall",10,10
          db "    mov rax, 60",10
          db "    xor rdi, rdi",10
          db "    syscall",10
template_end:

section .text
global _start

_start:
    ; read input.txt
    mov rax, 2          ; sys_open
    mov rdi, filename
    mov rsi, 0
    syscall

    mov rdi, rax        ; fd
    mov rax, 0          ; sys_read
    lea rsi, [input]
    mov rdx, 256
    syscall

    ; find first quote
    lea rsi, [input]
.find_quote:
    cmp byte [rsi], '"'
    je .copy_string
    inc rsi
    jmp .find_quote

.copy_string:
    lea rdi, [output]
    mov rcx, template_end - template1
    lea rsi, [template1]
    rep movsb

    ; copy string literal
.copy_loop:
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    cmp al, '"'
    jne .copy_loop

    ; append rest
    lea rsi, [template2]
    mov rcx, template_end - template2
    rep movsb

    ; write out.asm
    mov rax, 2
    mov rdi, outname
    mov rsi, 577        ; O_CREAT|O_WRONLY|O_TRUNC
    mov rdx, 0644
    syscall

    mov rdi, rax
    mov rax, 1
    lea rsi, [output]
    mov rdx, 1024
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

section .data
filename db "input.txt",0
outname  db "out.asm",0

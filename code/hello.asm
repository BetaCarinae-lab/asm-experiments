section .bss
    buffer resb 20

section .text
    global _start

_start:
    mov rax, 5
    mov rbx, 7
    add rax, rbx ; rax = rax + rbx

    call print_number

    mov rdi, 1    ; exit with 1
    mov rax, 60     ; sys_exit
    syscall

print_number:
    mov rbx, 10     ; divisor for decimal
    lea rsi, [buffer + 19] ; point to end of buffer
    mov byte [rsi], 10
    dec rsi

.convert_loop:
    xor rdx, rdx           ; Clear rdx for div
    div rbx                ; Divide rax by 10: rax = quotient, rdx = remainder
    add dl, '0'            ; Convert remainder to ASCII
    mov [rsi], dl          ; Store ASCII digit in buffer
    dec rsi                ; Move backwards in buffer
    test rax, rax          ; Is quotient 0?
    jnz .convert_loop      ; If not, continue

    inc rsi                ; Adjust pointer to first digit

    ; --- Write buffer to stdout ---
    mov rax, 1             ; sys_write
    mov rdi, 1             ; stdout
    mov rdx, buffer + 20
    sub rdx, rsi           ; Calculate length of number + newline
    syscall
    ret

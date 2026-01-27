; -----------------------------
; Print a positive integer in Linux x86-64
; -----------------------------

section .data
newline db 10             ; ASCII newline, stored in .data

section .bss
buffer resb 20            ; reserve 20 bytes for number + newline

section .text
global _start

_start:
    ; --- Example number ---
    mov rax, 123          ; number to print

    call print_number

    ; --- Exit ---
    mov rax, 60           ; sys_exit
    xor rdi, rdi          ; exit code 0
    syscall

; -----------------------------
; Function: print_number
; Input: rax = number to print
; Uses: rbx, rdx, rsi, rax
; -----------------------------
global print_number
print_number:
    mov rbx, 10               ; divisor for decimal
    lea rsi, [buffer + 19]    ; point to end of buffer
    mov al, [newline]         ; store newline at end
    mov [rsi], al
    dec rsi

.convert_loop:
    xor rdx, rdx              ; clear rdx for division
    div rbx                   ; rax /= 10, remainder → rdx
    add dl, '0'               ; convert remainder to ASCII
    mov [rsi], dl             ; store digit
    dec rsi
    test rax, rax             ; is quotient 0?
    jnz .convert_loop          ; if not, loop

    inc rsi                   ; adjust pointer to first digit

    ; --- Write buffer to stdout ---
    mov rax, 1                ; sys_write
    mov rdi, 1                ; stdout
    mov rdx, buffer + 20
    sub rdx, rsi              ; length = end - start
    syscall
    ret
global _start

section .data

    tickrate dq 10
    money dq 0
    buff dq 100

    clear_cmd db 0x1B, "[H", 0x1B, "[J"
    clear_len equ $ - clear_cmd

    newline db 0xA

    musor db "==============================", 0xA
    musor_len: equ $ - musor

    musor2 db "boost :"
    musor2_len: equ $ - musor2

    apple:
        incbin "apple.txt"
    apple_len: equ ($ - apple) - 1

    exit:
        incbin "exit.txt"
    exit_len: equ $ - exit

    com:
        incbin "com.txt"
    com_len: equ ($ - com) - 1

    shop_img:
        incbin "shop.txt"
    shop_len: equ ($ - shop_img) - 1

    final:
        incbin "final.txt"
    final_len: equ $ - final

    cheat:
        incbin "cheat.txt"
    cheat_len: equ $ - cheat

section .bss
    key_buf: resb 2
    buffer: resb 20

section .text
_start:

    mov rax, 1
    mov rdi, 1
    mov rsi, clear_cmd
    mov rdx, clear_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, apple
    mov rdx, apple_len
    syscall

    jmp money_out
    money_off:

    mov rax, 1
    mov rdi, 1
    mov rsi, musor2
    mov rdx, musor2_len
    syscall

    jmp buff_out
    buff_off:

    mov rax, 1
    mov rdi, 1
    mov rsi, musor
    mov rdx, musor_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, com
    mov rdx, com_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, key_buf
    mov rdx, 2
    syscall

    cmp byte [key_buf], 'e'
    je quit
    cmp byte [key_buf], 's'
    je sleep
    cmp byte [key_buf], 'b'
    je shop
    cmp byte [key_buf], 'n'
    je setting

    mov rax, 60
    syscall

quit:
    mov rax, 1
    mov rdi, 1
    mov rsi, clear_cmd
    mov rdx, clear_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, exit
    mov rdx, exit_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, key_buf
    mov rdx, 2
    syscall

    mov rax, 60
    syscall

sleep:
    mov r12, [tickrate]
    imul r12, 1000000000

sleep_loop:
    sub r12, 1
    cmp r12, 0
    jne sleep_loop

    mov r13, [buff]
    add [money], r13
    jmp _start

money_out:
    mov rax, [money]

    mov rcx, buffer
    add rcx, 19
    mov rbx, 10

.loop:
    xor rdx, rdx
    div rbx
    add dl, '0'
    dec rcx
    mov [rcx], dl
    test rax, rax
    jnz .loop

    mov rdx, buffer
    add rdx, 19
    sub rdx, rcx

    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

jmp money_off

buff_out:
    mov rax, [buff]

    mov rcx, buffer
    add rcx, 19
    mov rbx, 10

.looop:
    xor rdx, rdx
    div rbx
    add dl, '0'
    dec rcx
    mov [rcx], dl
    test rax, rax
    jnz .looop

    mov rdx, buffer
    add rdx, 19
    sub rdx, rcx

    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

jmp buff_off

shop:

    mov rax, 1
    mov rdi, 1
    mov rsi, clear_cmd
    mov rdx, clear_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, shop_img
    mov rdx, shop_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, key_buf
    mov rdx, 2
    syscall

    cmp byte [key_buf], 'a'
    je ten
    cmp byte [key_buf], 'r'
    je _start
    cmp byte [key_buf], 'b'
    je sotka
    cmp byte [key_buf], 'c'
    je end

    jmp shop
ten:

    mov rax, [money]
    cmp rax, 4900
    ja buy_ten
    jmp shop

buy_ten:
    mov rbx, [buff]
    imul rbx, 10
    mov [buff], rbx

    mov rcx, [money]
    sub rcx, 5000
    mov [money], rcx

    jmp _start

sotka:
    mov rax, [money]
    cmp rax, 49900
    ja buy_sotka
    jmp shop

buy_sotka:
    mov rbx, [buff]
    imul rbx, 100
    mov [buff], rbx

    mov rcx, [money]
    sub rcx, 50000
    mov [money], rcx
    jmp _start

end:
    mov rax, [money]
    cmp rax, 9999900
    ja the_end
    jmp shop

the_end:
    mov rax, 1
    mov rdi, 1
    mov rsi, clear_cmd
    mov rdx, clear_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, final
    mov rdx, final_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, key_buf
    mov rdx, 2
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, clear_cmd
    mov rdx, clear_len
    syscall

    mov rax, 60
    syscall

setting:

    mov rax, 1
    mov rdi, 1
    mov rsi, clear_cmd
    mov rdx, clear_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, cheat
    mov rdx, cheat_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, key_buf
    mov rdx, 2
    syscall

    mov rax, 60
    syscall











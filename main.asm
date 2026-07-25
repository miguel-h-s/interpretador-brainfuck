; os 8 operadores do brainfuck
; > avanca o ponteiro na memoria
; < recua o ponteiro na memoria
; + soma 1 na celula atual
; - subtrai 1 na celula atual
; . imprime o caractere na tela
; , le um caractere do teclado
; [ comeca um loop se a celula for 0
; ] volta para o [ se a celula nao for 0

section .data
    arquivo db "main.bf", 0

section .bss
    buffer resb 100 ; buffer para ler o arquivo
    fita resb 30000 ; fita de memoria padrao do brainfuck

section .text
    global _start

_start:
    

    ; abre o arquivo brainfuck com sys_open
    mov rax, 2
    mov rdi, arquivo ; nome do arquivo
    xor rsi, rsi ; modo apenas de leitura
    syscall

    

    ; guardamos o fd
    mov rbx, rax

    ; le o arquivo com sys_read
    mov rax, 0
    mov rdi, rbx
    mov rsi, buffer
    mov rdx, 100
    syscall

    mov r12, fita 

    ; sys_read retorna a quantidade de bytes lidos no rax
    mov rcx, rax

    ; rsi aponta pro comeco do buffer
    mov rsi, buffer

.loop:
    ; verifica se ja leu todos os bytes
    cmp rcx, 0
    je .sair

    mov al, [rsi]

    ; logica de comparacao para cada operador do brainfuck

    cmp al, '>'
    je .avanca

    cmp al, '<'
    je .recua

    cmp al, '+'
    je .mais

    cmp al, '-'
    je .menos

    cmp al, '.'
    je .imprime

    cmp al, ','
    je .le

    cmp al, '['
    je .loop_comeco

    cmp al, ']'
    je .fecha_loop

.proximo:
    inc rsi             ; move o ponteiro rsi para o proximo byte do buffer
    dec rcx             ; diminui 1 no contador de bytes restantes
    jmp .loop

.avanca:
    inc r12
    jmp .proximo

.recua:
    dec r12
    jmp .proximo

.mais:
    inc byte [r12]
    jmp .proximo

.menos:
    dec byte [r12]
    jmp .proximo

.imprime:
    push rcx
    push rsi

    mov rax, 1  
    mov rdi, 1  
    mov rsi, r12
    mov rdx, 1  
    syscall

    pop rsi
    pop rcx
    jmp .proximo

.le:
    push rcx
    push rsi

    mov rax, 0
    mov rdi, 0   
    mov rsi, r12   
    mov rdx, 1     
    syscall

    pop rsi
    pop rcx
    jmp .proximo


; logica do loop
.loop_comeco:
    ; se a celula atual for zero pula pra depois do ]
    cmp byte [r12], 0
    je .fim_do_loop

    ; se nao for 0 entramos no loop
    push rsi
    jmp .proximo

.fecha_loop:
    ; se a celula atual da fita nao for zero volta para o [
    cmp byte [r12], 0
    jne .volta_para_inicio_do_loop

    ; se for 0 o loop acabou
    ; tira o endereço velho da pilha para limpar a memoria
    pop rax             ; joga num registrador qualquer so pra limpar a pilha
    jmp .proximo

.volta_para_inicio_do_loop:
    mov rax, [rsp]      
    sub rsi, rax        
    add rcx, rsi        
    mov rsi, rax        
    jmp .proximo

.fim_do_loop:
    ; cria um mini loop interno para achar o fechamento
.acha_fechamento:
    inc rsi             ; anda uma casa para frente no arquivo
    dec rcx             ; diminui o contador geral de bytes
    cmp byte [rsi], ']' ; pergunta se e o fechamento
    jne .acha_fechamento ; se nao for continua rodando
    
    jmp .proximo


.sair:
    ; forca quebra de linha
    mov byte [buffer], 10  
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 1
    syscall

    ; fecha o arquivo e sai do codigo
    mov rax, 3
    mov rdi, rbx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
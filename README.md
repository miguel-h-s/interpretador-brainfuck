# Brainfuck Interpreter (x86-64 Assembly)

Um interpretador da linguagem **Brainfuck** escrito em **Assembly x86-64 (NASM)** para Linux.

> Este é o meu primeiro projeto maior em Assembly.

## Características

- Interpretador dos 8 operadores da linguagem Brainfuck
- Leitura do código a partir de um arquivo `.bf`
- Fita de memória com 30.000 células
- Entrada e saída usando syscalls do Linux
- Escrito em NASM (Intel Syntax)

## Operadores suportados

| Operador | Função |
|----------|--------|
| `>` | Avança o ponteiro |
| `<` | Recua o ponteiro |
| `+` | Incrementa a célula atual |
| `-` | Decrementa a célula atual |
| `.` | Imprime um caractere |
| `,` | Lê um caractere |
| `[` | Início de loop |
| `]` | Fim de loop |

## Exemplo

o arquivo `main.bf` é apenas um exemplo.

ele le um caractere do teclado e imprime o caractere tres posições à frente na tabela ASCII.

exemplo:

```text
entrada:
A

saida:
D
```

## compilação

```bash
nasm -f elf64 -o main.o main.asm
ld -o main main.o
./main
```

## tecnologias que usei

- NASM
- Linux x86-64
- Syscalls do Linux

## Observações

Este projeto foi desenvolvido como estudo utilizando apenas minhas anotações pessoais sobre Assembly.

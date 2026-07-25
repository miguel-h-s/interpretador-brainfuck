# interpretador-brainfuck

→ ignore o readme mau feito e curto

meu primeiro projeto serio com Assembly ate agora
isso **nao foi feito com IA**, apenas com as coisas que estao no meu caderno :P

## o que o ``main.bf`` faz?

→ o ``main.bf`` é apenas um codigo de exemplo, altere ele se quiser

ele pede um caractere e avança 3 casas
exemplo de saida:

```
$ user@exemplo: ./main.asm
A ← caractere que digitei
D ← avança 3 casas
$ user@exemplo:
```

## como executar o projeto?

use:
```
$ user@exemplo: nasm -f elf64 -o main.o main.asm
$ user@exemplo: ld -o main main.o
$ user@exemplo: ./main
```

certifique-se de ter as ferramentas certas instaladas!

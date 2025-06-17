# Testes Unitários em COBOL
  
Walter BUGA Ramos  
buga.bug.buga@gmail.com

---
# Índice - Esse Documento

---

## Compilação e Execução de Módulos Cobol

- **CLG#001** - Compila, linka e executa módulo fonte Cobol  
- **CLG#002** - Compila, linka e executa módulo fonte Cobol *(evolução)*  
- **CLG#003** - Compila, linka e executa módulo fonte Cobol *(evolução 2)*  

---

## Pre-compilador

- **ZUTZCPC** - Código fonte do pre-compilador  
- **ZUTZCPD** - Book de instruções do pre-compilador  
- **ZUTZCWS** - Book de variáveis do pre-compilador  

---

## Programa de Teste

- **SAMPLE** - Programa Cobol que será objeto do teste  
- **SAMPLET** - Instruções do que quer que seja testado  
          ❗ *Não consegui rodar como particionado*  
           ⚠ *Utilize: `BUGAARQ.SIGLA.SAMPLET`*  

---

## Arquivo de Configuração

- **UTSTCFG** - *Configuration file*  

---

Essa versão mantém a estrutura original e melhora a legibilidade com **Markdown**, incluindo títulos, negrito, itálico e ícones para destacar pontos importantes. Se quiser ajustes, me avise! 🚀😃

## Entendendo o cenário de desenvolvimento de Software

**Cobol Unit Test - CUT**  
- Projeto colaborativo disponível no [GitHub](https://github.com/neopragma/cobol-unit-test)[1]
- Pré-Compilador escrito em Cobol que gera um programa Cobol específico com o caso de testes a ser executado[1]

---

## Pirâmide de Testes
```            
             /  \
            /     \
           /        \
          /           \
         /Exploratórios\
        /________________\
       / End to End       \
      /____________________\
     / Testes de Componente \  
    /________________________\
   /       Integração         \
  /____________________________\
 /           UNITÁRIO           \
/________________________________\

```
- **Exploratórios**: Testes manuais para descobrir comportamentos inesperados.
- **End to End**: Testes que validam o fluxo completo do sistema.
- **Testes de Componente**: Validam partes isoladas do sistema.
- **Integração**: Verificam a interação entre componentes.
- **Unitário**: Testam unidades individuais de código.
---

## Metodologia de desenvolvimento

A arquitetura mainframe é diferente da distribuída e da nuvem[1].  
A linguagem procedural (Cobol/PL1/Rexx) é diferente da orientação a objetos[1].  
Entretanto, vamos utilizar conceitos de outras arquiteturas e linguagens para melhorar a qualidade de nosso código e facilitar a codificação[1]!

---

## (Des)conceituando o teste unitário

Procura verificar se o código está correto, em sua menor parte[1].  
A menor parte do fonte a ser testado é um método de uma classe[1].  
Sendo assim, os testes unitários são aplicados a esses métodos, a partir da criação de classes de testes[1].

---

## Então o que testar no COBOL?

Ainda não temos um conceito formado sobre isso, mas esperamos que seja algo parecido com o mock de outras linguagens[1].  
Num dos exemplos do projeto da ferramenta, o teste versa sobre o conteúdo de variável esperada depois da execução de uma section[1].

---

## Funcionamento da ferramenta

Por algum motivo que desconheço, não tem nada sobre como rodar a ferramenta no mainframe; no micro funciona de boa, só seguir o texto base que tem lá no Git[1].  
A importação dos fontes e adaptações foram tranquilas e alguns ajustes foram necessários[1].  
O que mais demorou e que apanhei um bocado foi pra gerar o JCL “redondinho”[1].

---

## Etapas

Depois da ferramenta ter sido compilada e linkeditada, temos[1]:
- Rodar a ferramenta informando o programa e os casos de teste[1]
- Compilar/Linkeditar o “programa” gerado[1]
- Executar esse ‘programa’ com os casos de teste[1]

---

## Mãos à obra!

Particionado com os componentes necessários está disponível em:  
**WALBUGA.SIGLA.CUT.COBOL**[1]

---

## Obrigado!


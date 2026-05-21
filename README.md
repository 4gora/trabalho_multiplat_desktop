# Trabalho de Desenvolvimento Multiplataforma Desktop - Musicolector
Este projeto é um aplicativo para organização de coleções musicais de álbuns, singles, CDs, Vinis, etc.

## Requisitos Implementados para Avaliação

* CRUD Local: Cadastro, leitura, edição e exclusão de itens persistidos direto no computador.
* Banco de Dados: Uso do SQLite configurado para rodar no Windows (Desktop) e possível implementação para Android.
* Frontend: Telas baseadas no layout planejado no Figma, utilizando pop-ups modais para cadastro e exclusão.

## Estrutura do Código

* lib/models/ - Definição da classe do objeto e conversores de dados.
* lib/services/ - Código de criação da tabela e comandos SQL.
* lib/controllers/ - Lógica de cálculo dos valores e atualização da tela.
* lib/screens/ e lib/widgets/ - Telas de login, início e caixas de diálogo.

## Como rodar o projeto

1. Baixar as dependências do Flutter:
   flutter pub get

2. Compilar e rodar nativamente no Windows Desktop:
   flutter run -d windows

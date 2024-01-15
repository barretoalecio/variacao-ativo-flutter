# Variação de Ativos 🚀

Este projeto, desenvolvido em **Flutter**, tem como principal funcionalidade buscar informações de ativos da bolsa de valores, exibindo a variação nos últimos 30 pregões.

## Arquitetura e Construção do Projeto 🏗️

A arquitetura adotada é a *Clean Architecture*. Utilizamos o *Modular 6* para gerenciamento de rotas e injeção de dependência, *Bloc* para gerenciamento de estado e programação reativa, e seguimos os princípios do *SOLID*. Durante o desenvolvimento, aplicamos padrões de commits semânticos e adotamos o GitFlow.

## Comunicação do Código 🗣️

A comunicação entre as camadas é linear, cada uma com sua responsabilidade específica, impedindo a quebra do fluxo horizontal.

## Exemplo básico do funcionamento: ⚙️

A chamada entre as camadas da arquitetura ocorre da seguinte forma:

`Bloc <- UseCase <- Repository <- DataSource`

O Bloc (camada de apresentação) solicita dados ao UseCase (camada de domínio), que por sua vez chama o repositório (camada de infraestrutura). O repositório busca os dados no DataSource (camada externa).

## Explicando o Código: 👨‍💻

O código segue um padrão de projeto com um núcleo que contém arquivos compartilhados e úteis para toda a aplicação.

O projeto foi dividido em 3 módulos:

**Coordinator Module:** Este módulo, que é estático no exemplo "Variação de Ativos", coordena o usuário para a rota a ser acessada. Implementamos para demonstrar a importância de seguir padrões e facilitar futuras atualizações.

**Help Module:** Um módulo simples que orienta o usuário sobre os padrões necessários para buscar ativos e explica por que esses padrões são essenciais para o funcionamento adequado da API.

**Asset Module:** O módulo mais crucial, concentrando regras de negócio, gerenciamento de rotas, estados e falhas. Sendo completo, é possível visualizar o fluxo da arquitetura desde a camada de apresentação até a camada externa.

## Como Executar 🌀

O código possui 4 flavors (2 para Android e 2 para iOS, para desenvolvimento e produção cada). No Visual Studio Code, fornecemos um arquivo `launch.json` para facilitar a execução com o flavor desejado.

Recomendamos a execução no Android, com liberdade para escolher o flavor desejado. Esta recomendação é devido à ausência de testes em dispositivos iOS durante uma viagem no fim de semana. Para evitar problemas, fornecemos scripts na pasta "Scripts" para gerar builds via terminal. Também estão disponíveis APKs na raiz do aplicativo na pasta `outputs` para simplificar o processo.

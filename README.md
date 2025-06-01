# Desafio TechCare
## Nome do aluno: Paulo Roberto Gonçalves da Silva Junior
## Perfil escolhido: Dev / Admin

## Caso de Uso:
A TechCare é uma empresa de suporte a clientes que lançou um Portal de Atendimento
em Salesforce. A empresa solicita os seguintes requisitos no referido portal de atendimento:
* A criação de um objeto customizado para recepcionar e registrar os pedidos de suporte;

* Processos de negócio claros (triagem, escalonamento e resolução);

* Relatórios e dashboards gerenciais para acompanhamento de métricas;

* Funcionalidades automáticas e customizadas via código.

## Intruções de Instalação:
>Necessária a instalação do Git e do Salesforce CLI para executar os comandos

Abra o prompt de comando e digite o seguinte código para clonar o repositório git
```bash
git clone https://github.com/DreeParker/projeto-TechCare.git
```
Navegue até o novo diretório
```bash
cd TechCare
```

Autorize sua org com o Salesforce CLI, salve com um alias "projectTechCare" e defina o usuário atual como usuário padrão
```bash
sf org login web -s -a projectTechCare
```

Implante o código do aplicativo na org
```bash
sf project deploy start -d force-app/main/default
```

# Fluxo de atendimento

## - Perfis:

* Foram criados dois perfis para acessarem as funcionalidades do app TechCare Support, o perfil "Support Premium", destinado a operadores de suporte de casos alto nível, tendo como prioridade casos do tipo Premium, mas que também podem atender eventualmente a outros tipos de casos de acordo com a demanda. Esses usuários tem acesso a todas as informações relativas aos casos de qualquer categoria e podem criar, alterar, fechar, reabrir e excluir ambos os tipos de casos.

* O outro perfil é o "Support Standard", que se destina a operadores de suporte de casos nível médio e baixo, este perfil não tem acesso total a todas as informações relativas ao caso, e não podem reabrir casos fechados.


## - Grupos públicos:

* Foram criados 3 grupos públicos para atender ao fluxo de casos, Premium Group, destinado aos usuários com o perfil Support Premium, Standard Group, destinado aos usuários com perfil Support Standard, e High Priority Group, destinado a usuários com habilidades para resolver casos de alta complexidade 

## - Filas:

* Seguindo a mesma logica dos grupos públicos, foram criadas 3 filas para o redirecionamento dos casos e ágil atendimento dos mesmos, High Priority Cases, para casos escalados, Premium Cases, para casos do tipo Premium, Standard Cases para casos do tipo Standard.


# Instruções para testes do App:

## Como criar um caso?

 1 - Clique no botão "New"
     
 2 - Selecione o record type "Premium"

 3 - Preencha o campo Subject

 4 - Mantenha o campo Status com o valor "New" ou altere para "In Progress"

 5 - Mantenha o campo Priority com o valor "High" ou altere para "Medium" / "Low"

 6 - Clique em "Salve"

> Ao criar um caso, o fluxo de assigment deverá ser chamado automaticamente, atribuindo o caso a fila correspondente ao seu record type após o usuário clicar em salvar


## Como escalar um caso?

1 - Crie um caso segundo os passos apresentados anteriormente

2 - Clique no botão Escalate Case

3 - Insira um texto na caixa de texto apresentada

4 - Clique em next

5 - Clique na aba "Case Requests", e depois no numero do caso que acabamos de escalar


## Como fechar um caso?

1 - Crie um caso segundo os passos apresentados anteriormente

2 - Clique no botão Close Case 

3 - Insira um texto na caixa de texto apresentada

4 - Clique em Close Case

5 - Clique na aba "Case Requests", e depois no numero do caso que acabamos de escalar


## Como reabrir um caso?

> Para executar esse passo, você deve ter um caso fechado, siga os passos de como abrir um caso, e como fechar um caso para executar as orientações a seguir

1 - Clique no botão Reopen Case


## Como verificar os Dashboards?

1 - Clique na aba "Dashboards"

2 - No menu a esquerda, clique em "All Folders"

3 - Clique na pasta "Case Requests Dashboard"

4 - Clique no dashboard "Case Graphics" para exibir as informações dos painéis


## Como verificar os Reports?

1 - Clique na aba "Reports"

2 - No menu a esquerda, clique em "All Folders"

3 - Clique na pasta "Case Request Reports"

4 - Clique em um dos relatórios para visualizar suas informações



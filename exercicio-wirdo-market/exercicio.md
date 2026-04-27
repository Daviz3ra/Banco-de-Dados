## 🛍️ PROJETO WIRDO MARKET – Sistema de E-commerce em 3 Níveis

### Contexto Geral

A **Wirdo Market** é uma pequena loja virtual que vende produtos físicos. Você, como desenvolvedor backend, precisa **projetar o banco de dados** que sustentará a operação. O negócio vai crescer em etapas, então você deve construir de forma modular e pensando nas futuras expansões.

O entregável final será:
- Um **script SQL completo** (arquivo `.sql`) com todas as instruções `CREATE TABLE`, `INSERT` (dados de exemplo) e as consultas solicitadas em cada nível.
- Um **documento explicativo** (`.txt` ou `.md`) justificando cada decisão de design e mostrando as consultas.

---

## 🥇 NÍVEL 1 – MVP (Mínimo Produto Viável)

Objetivo: **A loja precisa começar a vender e controlar o básico do estoque.**

### Requisitos de negócio

1. A loja tem um **catálogo de produtos**. Para cada produto, é preciso saber:
   - Um identificador único
   - Nome do produto
   - Descrição (texto curto)
   - Preço atual de venda
   - Quantidade disponível em estoque

2. A loja precisa registrar **quando o estoque muda** (entrada por compra ou saída por venda), mas por enquanto **não precisa associar a um cliente específico** – apenas saber que houve uma movimentação. Para cada movimentação, registre:
   - Data e hora
   - Quantidade movimentada (positiva = entrada, negativa = saída)
   - Motivo (ex: 'compra_fornecedor', 'venda_cliente', 'ajuste_manual')
   - Produto envolvido

3. No nível 1, **não há cadastro de clientes** nem autenticação.

### Entregas esperadas para o Nível 1

**A. Esquema do banco**
- Crie as tabelas necessárias para atender aos requisitos acima.
- Defina chaves primárias, chaves estrangeiras (se houver) e constraints pertinentes (`NOT NULL`, `UNIQUE`, `CHECK`, etc.).

**B. Dados de exemplo**
- Insira pelo menos 5 produtos diferentes (ex: camiseta, caneca, livro, etc.).
- Insira pelo menos 8 movimentações de estoque (algumas entradas, algumas saídas).

**C. Consultas obrigatórias (escreva em SQL)**
1. Listar todos os produtos com **estoque abaixo de 5 unidades** (precisa repor).
2. Mostrar o **valor total do estoque atual** (soma de preço × quantidade disponível de cada produto).
3. Listar as **últimas 5 movimentações** (qualquer tipo), ordenadas da mais recente para a mais antiga.
4. Mostrar o **histórico completo de movimentações de um produto específico** (escolha um ID fictício).

---

## 🥈 NÍVEL 2 – Clientes e Pedidos

Objetivo: **A loja agora identifica quem está comprando e organiza as vendas em pedidos.**

### Novos requisitos (mantenha tudo do nível 1)

1. Agora a loja precisa **cadastrar clientes**. Para cada cliente, armazene:
   - Identificador único
   - Nome completo
   - E-mail (não pode repetir)
   - Data de cadastro

2. Quando um cliente compra, isso deve ser registrado como um **pedido** (order). Um pedido contém:
   - Identificador único
   - Data/hora do pedido
   - Cliente que fez o pedido
   - Status atual do pedido (ex: 'pendente', 'pago', 'enviado', 'entregue', 'cancelado')

3. Um pedido pode ter **um ou mais produtos** (quantidades diferentes por produto). Para isso, registre:
   - Qual produto
   - Quantidade comprada
   - Preço unitário **no momento da compra** (o preço do produto pode mudar depois, mas o pedido guarda o valor histórico)

4. Quando um pedido é finalizado (status = 'pago'), o estoque deve **diminuir automaticamente** (conceitualmente – ele precisa garantir que a movimentação de estoque seja registrada com motivo 'venda_cliente' e referenciando o pedido).

### Entregas esperadas para o Nível 2

**A. Evolução do esquema**
- Adicione as tabelas necessárias para clientes, pedidos e itens do pedido.
- Altere a tabela de movimentações de estoque (do nível 1) para **referenciar o pedido** quando a movimentação for causada por uma venda.

**B. Dados de exemplo**
- Insira pelo menos 3 clientes.
- Insira pelo menos 5 pedidos (com diferentes status), cada um com 1 a 3 produtos.

**C. Consultas obrigatórias (nível 2)**
1. Listar todos os pedidos de um cliente específico (use o nome ou e-mail).
2. Mostrar o **valor total de cada pedido** (soma de quantidade × preço unitário de cada item).
3. Listar os **clientes que mais gastaram** (total em reais), em ordem decrescente.
4. Mostrar **todos os pedidos que contêm um determinado produto** (ex: 'camiseta'), incluindo informações do cliente.

---

## 🥇 NÍVEL 3 – Estornos, Cancelamentos e Relatórios

Objetivo: **A loja agora lida com cancelamentos de pedido, estornos de estoque e gera relatórios gerenciais.**

### Novos requisitos (mantenha tudo dos níveis 1 e 2)

1. Quando um pedido é **cancelado** (status muda para 'cancelado'), o estoque dos produtos daquele pedido deve ser **devolvido** (movimentação positiva de estoque). Essa movimentação deve ter motivo 'estorno_cancelamento'.

2. O sistema precisa registrar **quem cancelou ou alterou o status de um pedido** (pode ser o próprio cliente ou um administrador). Para isso, adicione ao pedido: `ultima_alteracao_por` (ex: 'cliente' ou 'admin') e `data_ultima_alteracao`.

3. A loja quer um **relatório mensal de desempenho**. Para cada mês, mostre:
   - Total de pedidos finalizados (status 'entregue')
   - Valor total vendido (soma dos totais dos pedidos)
   - Quantidade total de itens vendidos
   - Média de valor por pedido

4. A loja também quer **identificar produtos parados** (sem movimentação de saída nos últimos 30 dias).

### Entregas esperadas para o Nível 3

**A. Evolução do esquema**
- Adicione colunas necessárias para controle de alterações de status.
- Opcional: crie uma tabela de log de alterações de pedido (se quiser mais robustez).

**B. Dados de exemplo**
- Insira pelo menos 2 pedidos cancelados.
- Adicione movimentações de estoque para os estornos.
- Garanta que haja dados de pelo menos 2 meses diferentes (use datas variadas nos pedidos).

**C. Consultas obrigatórias (nível 3)**
1. Para um pedido cancelado específico, mostre **todos os produtos estornados** e as quantidades devolvidas ao estoque.
2. Gerar o **relatório mensal de desempenho** (mês, total_pedidos, valor_total, itens_vendidos, valor_medio_por_pedido).
3. Listar **produtos parados** (sem venda nos últimos 30 dias).
4. Mostrar o **histórico de status** (se ele criou log) ou a última alteração de cada pedido que foi cancelado.


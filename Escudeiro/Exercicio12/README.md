## Você precisa montar um relatório para buscar os vendedores agrupados por nome, cliente e mostrando o total que cada um realizou de vendas por cliente. Para isso considere as seguintes tabelas:
```sql
        CREATE TABLE vendedor (
            id        INT NOT NULL,
            nome      varchar(100) NOT NULL,
            cpf       varchar(30)  NOT NULL,
            telefone  varchar(40)  NULL,
            dtcriacao date,
            email     varchar(60)  NULL,
            PRIMARY KEY (id));

        CREATE TABLE cliente (
            id        INT NOT NULL,
            nome      varchar(100) NOT NULL,
            cpf       varchar(30)  NOT NULL,
            telefone  varchar(40)  NULL,
            dtcriacao date,
            email     varchar(60)  NULL,
            PRIMARY KEY (id));

        CREATE TABLE vendas (
            id         int NOT NULL PRIMARY KEY,
            code       int NOT NULL,
            totalvenda float,
            dt_venda   date   /* ESTÁ COM ERRO AQUI (FALTA UMA VÍRGULA) : CORRIGIR NO MESTRE DOS CÓDIGOS */
            clienteID  int FOREIGN KEY REFERENCES cliente(id),
            vendedorID  int FOREIGN KEY REFERENCES vendedor(id));
```
SQL:
```sql
SELECT v.nome                          AS vendedor,
       COALESCE(c.nome, '--')          AS cliente,
       SUM(COALESCE(v2.totalvenda, 0)) AS total
  FROM vendedor v
  LEFT JOIN vendas v2 ON v2.vendedorID = v.id
  LEFT JOIN cliente c ON c.id = v2.clienteID
 GROUP BY v.nome, c.nome;
```

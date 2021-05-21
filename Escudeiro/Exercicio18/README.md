## Analise o cenário:
## Você tem um banco de dados com as tabelas abaixo:
```sql
        CREATE TABLE cliente (
            id        INT NOT NULL,
            nome      varchar(100) NOT NULL,
            PRIMARY KEY (id));

        CREATE TABLE vendas (
            id         int NOT NULL PRIMARY KEY,
            dtcriacao  date,
            clienteID  int FOREIGN KEY REFERENCES cliente(id))
```
## Após a criação das tabelas foram inseridos os seguintes registros:
```sql
        insert cliente values (1, 'ESCUDEIRO');
        insert cliente values (2, 'CAVALEIRO');
        insert cliente values (3, 'MESTRE');

        insert vendas values(1, '01/01/2019', 1);
        insert vendas values(2, '01/01/2019', 2);
        insert vendas values(3, '01/01/2019', 3);
```
## O analista responsável pelo gerenciamento do banco de dados precisa excluir a tabela cliente. Levando em consideração o relacionamento entre as duas tabelas. Como seria o único comando que iria excluir a tabela cliente e vendas de uma só vez.

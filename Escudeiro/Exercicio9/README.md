## Temos 2 tabelas: serviceorder e client. Análise os códigos abaixo e aponte qual é o correto para a criação de uma chave estrangeira na tabela serviceorder referenciando a tabela client.

Nenhuma das alternativas. A que mais se aproxima do resultado é a opção 1 porém deveria ter essa adaptação no código para estar correta:

```sql
alter table serviceorder add constraint fk_serviceorder_client
     foreign key(id_client)
       references client (id_client /*ou*/ id)
         on delete no action
         on update no action;
```

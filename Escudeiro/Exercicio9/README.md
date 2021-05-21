## Temos 2 tabelas: serviceorder e client. Análise os códigos abaixo e aponte qual é o correto para a criação de uma chave estrangeira na tabela serviceorder referenciando a tabela client.

Opção 1:

```sql
alter table serviceorder add constraint fk_serviceorder_client
     foreign key(id_client)
       references client (id_serviceorder)
         on delete no action
         on update no action;
```

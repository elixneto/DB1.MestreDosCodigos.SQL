# 10. (Oracle, SQL Server) Dado que em seu banco de dados possua a tabela "DB1", com atributos I e J, e outra, "DB2", com atributos I e J. Com isso, será preciso criar uma consulta que retorna os registros de "DB1" que não têm um registro correspondente em "DB2" e que os valores dos atributos I em cada tabela tenham o mesmo valor. Assinale a opção que indica o comando que não produz esse resultado corretamente.
Opção 3:
```sql
     select db1.*
     from db1 
     inner join db2 
     on db1.I <> db2.I
```

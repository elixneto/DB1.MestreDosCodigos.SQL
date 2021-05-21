## É muito comum termos a necessidade de buscar diversas informações utilizando um único comando. Ex: Precisamos trazer em uma única consulta todos os nomes dos clientes referentes aos ids "12", "10", "199", "18", "01", "2016". Construa uma consulta utilizando a tabela "cliente" e o campo "id".
SQL:
```sql
SELECT *
  FROM cliente
 WHERE id IN (12, 10, 199, 18, 1, 2016);
```

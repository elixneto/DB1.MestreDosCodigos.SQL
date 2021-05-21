## Muitas vezes queremos buscar um registro no banco de dados mas não sabemos o termo completo que queremos consultar. Ex: Você foi instruído para consultar o nome de todos os clientes que possuem o texto "Souza" no nome. Para isso você recebeu o comando abaixo incorreto. Análise a consulta e reescreva da maneira correta.
```sql
SELECT nome
  FROM cliente
 WHERE nome = '>Souza'
```
Correção:
```sql
SELECT nome
  FROM cliente
 WHERE nome LIKE '%Souza%'
```

## Utilizamos a função GROUP BY para agrupar informações iguais de determidas colunas. Com base nos seus conhecimentos a respeito da função GROUP BY, assinale o código correto:
Opção 1:
```sql
SELECT c.nome, sum(v.total_venda)
  FROM cliente c
 INNER JOIN vendas v on v.id_cliente = c.id
 WHERE v.dt_venda > '01/01/2019'
 GROUP BY c.nome
 ORDER BY 1
```

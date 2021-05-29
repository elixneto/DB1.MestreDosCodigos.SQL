# 11. (Oracle, SQL Server, Mysql, PostgreSQL) Dado que você tem criado as seguintes tabelas e os seguintes registros;
## Tabela: User
```sql
idUser    codUser
1         3883-3881-1812-2828
2         5483-8762-3246-8735
3         1024-8950-3068-1024 
```
## Tabela: Student
```sql
idUser    country               codUser
1         3883-3881-1812-2828   3883-3881-1812-2828
2         5483-8762-3246-8735   5483-8762-3246-8735
3         1024-8950-3068-1024   1024-8950-3068-1024
```
## Um dos comandos que podemos utilizar para excluir uma tabela é o "DROP TABLE". Mas no caso deste cenário. O que acontecerá quando você executar o comando "DROP TABLE" para a tabela "User"? Qual comando você utilizaria para excluir as duas tabelas de uma só vez nessa situação e por que?

Resposta:

Não é possível identificar o relacionamento entre as tabelas pelo enunciado proposto então assumirei que a tabela Student possui uma FK da tabela User - Nesse suposto cenário o DROP TABLE de User causaria um erro informando que existe(m) chave(s) primária(s) referenciada(s) como chave(s) extrangeira(s) em outras tabelas.

O comando a ser utilizado nesse suposto cenário funciona em todos os SGBDs propostos menos no Oracle:
```sql
DROP TABLE Student, User;
```
Esse comando excluirá primeiramente a tabela Student eliminando a Constraint de chave estrangeira e logo em seguida a tabela User será excluída com sucesso pois a sua única referência acabara de ser excluída.

No Oracle não é possível excluir múltiplas tabelas com um único comando. Contudo podemos excluir as chaves estrangeiras automaticamente com o opção CASCADE CONSTRAINT:
```sql
DROP TABLE User CASCADE CONSTRAINT;
```
Esse comando não excluirá a tabela Student, porém todas as referências de chave estrangeira serão excluídas e assim a tabela está livre pra ser excluída também.

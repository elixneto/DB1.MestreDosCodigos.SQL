# 5. (Oracle) Com base no código PL/SQL abaixo:
```sql
 CREATE TABLE outra_tabela (ch CHAR (3 CHAR));

 DECLARE 
     str VARCHAR2(5 CHAR) := 'DREAM';
 BEGIN
     INSERT INTO outra_tabela(ch) VALUES(str);
 END;
 /
```
## Executar o código acima no Oracle 12c ou superiores, resulta em:
Opção 3: ERROR: value too large for column;

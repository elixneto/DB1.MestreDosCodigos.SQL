## Dado a tabela abaixo, criamos um comando de INSERT, no entanto ele esta apresentando um erro. Reescreva o código corrigindo-o:
```sql
insert into cliente(
      id,
      nome_cliente,
      razao_social,
      dt_cadastro,
      cnpj,
      telefone,
      cidade,
      estado)
    values (
      1,
      '0001',
      'AARONSON',
      'AARONSON FURNITURE LTDA',
      '2015-02-17',
      '17.807.928/0001-85',
      '(21) 8167-6584',
      'MARINGA',
      'PR'
    );
```

Correção:
```sql
insert into cliente(
      id,
      nome_cliente,
      razao_social,
      dt_cadastro,
      cnpj,
      telefone,
      cidade,
      estado)
    values (
      1,
      'AARONSON',
      'AARONSON FURNITURE LTDA',
      '2015-02-17',
      '17.807.928/0001-85',
      '(21) 8167-6584',
      'MARINGA',
      'PR'
    );
```

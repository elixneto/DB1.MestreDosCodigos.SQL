/* |ORACLE| */

-- DROP TABLE vendas;
CREATE TABLE vendas (
    codigo int,
    valor decimal,
    dataHora date
);

INSERT INTO vendas 
SELECT 1, 56.89, sysdate FROM DUAL
UNION
SELECT 2, 48.90, sysdate FROM DUAL
UNION
SELECT 3, 68.99, sysdate FROM DUAL;

INSERT INTO vendas 
SELECT 4, 14.79, sysdate-1 FROM DUAL
UNION
SELECT 5, 45.87, sysdate-1 FROM DUAL
UNION
SELECT 6, 12.12, sysdate-1 FROM DUAL;


-- DROP MATERIALIZED VIEW mv_resumo_de_vendas;
CREATE MATERIALIZED VIEW mv_resumo_de_vendas AS
SELECT TRUNC(dataHora) as DIA,
       SUM(valor) as VALOR_TOTAL
  FROM vendas
 WHERE TRUNC(dataHora) < TRUNC(SYSDATE)
 GROUP BY TRUNC(dataHora);
 

CREATE OR REPLACE PROCEDURE sp_refresh_vendas AS
BEGIN
    DBMS_MVIEW.REFRESH('mv_resumo_de_vendas', 'C');
END;


DECLARE
    job_id NUMBER;
BEGIN
    DBMS_JOB.SUBMIT(
     JOB       => job_id,
     WHAT      => 'sp_refresh_vendas;',
     NEXT_DATE => SYSDATE,
     INTERVAL  => 'SYSDATE+1');
END;
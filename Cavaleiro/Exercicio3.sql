/* |ORACLE| */

CREATE MATERIALIZED VIEW mv_atendimentos AS
SELECT data_atendimento,
       COUNT(1) as quantidade
  FROM atendimento
  GROUP BY data_atendimento
  HAVING COUNT(1) >= 2;
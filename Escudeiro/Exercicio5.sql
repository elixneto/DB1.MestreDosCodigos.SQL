-- UNION: apenas valores distintos são retornados (como SELECT DISTINCT)
SELECT p.id, p.data_nascimento as dt FROM paciente p
UNION
SELECT a.id, a.data_atendimento as dt FROM atendimento a;

-- UNION ALL: retorna todos os valores (valores duplicados)
SELECT p.id, p.data_nascimento as dt FROM paciente p
UNION ALL
SELECT a.id, a.data_atendimento as dt FROM atendimento a;



-- INTERSECT
SELECT a.data_atendimento, p.data_nascimento 
  FROM atendimento a
  INNER JOIN paciente p on p.data_nascimento = a.data_atendimento;
  
  
  
-- MINUS INTERSECT
SELECT p.nome, p2.nome 
  FROM profissional p
  FULL OUTER JOIN profissional p2 ON p2.id = p.id_profissional_superior
 WHERE p.id IS NULL
   OR p2.id IS NULL;
   
-- MINUS LEFT+INTERSECT
SELECT p.nome, p2.nome 
  FROM profissional p
  RIGHT JOIN profissional p2 ON p2.id = p.id_profissional_superior
 WHERE p.id IS NULL;

-- MINUS RIGHT+INTERSECT
SELECT p.nome, p2.nome 
  FROM profissional p
  LEFT JOIN profissional p2 ON p2.id = p.id_profissional_superior
 WHERE p2.id IS NULL;

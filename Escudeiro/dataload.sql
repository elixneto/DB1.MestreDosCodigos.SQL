USE mestredoscodigos;

DELETE atendimento;
DELETE usuario;
DELETE paciente;
DELETE clinica_profissional;
DELETE profissional;
DELETE tipo_profissional;
DELETE clinica;
-----------------------------------------------------------------

INSERT INTO clinica (cnpj, nome_fantasia) VALUES
('04204018000166', 'DB1 CLINICA');

INSERT INTO tipo_profissional (descricao) VALUES
('MÉDICO'),
('FISIOTERAPEUTA'),
('PSIQUIATRA');

INSERT INTO profissional (id_tipo_profissional, nome) VALUES
((SELECT id FROM tipo_profissional WHERE descricao = 'MÉDICO'), 'ÉLIX NETO');

INSERT INTO clinica_profissional (id_clinica, id_profissional)
SELECT c.id, p.id
  FROM profissional p
  CROSS JOIN clinica c;
  
INSERT INTO paciente (nome, data_nascimento) VALUES
('TESTE 1', '2000-01-01'),
('TESTE 2', '2000-02-15'),
('TESTE 3', '2000-03-17'),
('TESTE 4', '2000-04-21'),
('TESTE 5', '2000-05-18'),
('TESTE 6', '2000-06-09');

INSERT INTO usuario (email, nome, hash_senha) VALUES
('superuser@db1.com.br', 'ADMIN', 'UuK7O2BhEM+q/Gz+hi/1E+RVbDQ9q7UUIw9Zhm8YwbFx/cMrtx+6tA==');

WITH ElixNeto_DB1 AS (
SELECT TOP 1 id_clinica, id_profissional
  FROM clinica_profissional cp 
  INNER JOIN clinica c ON c.id = cp.id_clinica
  INNER JOIN profissional p ON p.id = cp.id_profissional
 WHERE c.nome_fantasia = 'DB1 CLINICA'
   AND p.nome = 'ÉLIX NETO'
)
INSERT INTO atendimento (id_clinica, id_profissional, id_paciente, id_usuario_inclusao, data_atendimento, aprovado)
SELECT ElixNeto_DB1.id_clinica,
	   ElixNeto_DB1.id_profissional,
       p.id,
       u.id,
       DATEADD(day, (ABS(CHECKSUM(NEWID())) % 2), GETDATE()),
       1
  FROM paciente p
  CROSS JOIN ElixNeto_DB1
  CROSS JOIN usuario u
 WHERE u.nome = 'ADMIN';
 
-----------------------------------------------------------------
-- SELECT * FROM clinica;
-- SELECT * FROM tipo_profissional;
-- SELECT * FROM profissional;
-- SELECT * FROM clinica_profissional;
-- SELECT * FROM paciente;
-- SELECT * FROM usuario;
-- SELECT * FROM atendimento;

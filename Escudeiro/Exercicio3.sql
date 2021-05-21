-- UPDATE paciente SET data_nascimento = NULL WHERE nome = 'TESTE 6';
SELECT COUNT(1) as quantidadeTotalDePacientes,
       COUNT(data_nascimento) as quantidadeDePacientesComDataDeNascimento
  FROM paciente;

 
SELECT MIN(data_nascimento) as menorDataDeNascimento,
       MAX(data_nascimento) as maiorDataDeNascimento
  FROM paciente;
  
 
SELECT data_atendimento,
       COUNT(1) as quantidade
  FROM atendimento
  GROUP BY data_atendimento
  HAVING COUNT(1) >= 2;

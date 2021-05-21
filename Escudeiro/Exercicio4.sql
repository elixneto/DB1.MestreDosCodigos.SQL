ALTER TABLE profissional ADD id_profissional_superior INT;
ALTER TABLE profissional ADD FOREIGN KEY (id_profissional_superior) REFERENCES profissional (id)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;
INSERT INTO profissional (id_tipo_profissional, nome) VALUES ((SELECT id FROM tipo_profissional WHERE descricao = 'MÉDICO'), 'ALGUÉM SUPERIOR');
INSERT INTO profissional (id_tipo_profissional, nome) VALUES ((SELECT id FROM tipo_profissional WHERE descricao = 'MÉDICO'), 'ALGUÉM MENOR NIVEL');
UPDATE profissional SET id_profissional_superior = (SELECT id FROM profissional WHERE nome = 'ALGUÉM SUPERIOR') WHERE nome = 'ÉLIX NETO';
UPDATE profissional SET id_profissional_superior = (SELECT id FROM profissional WHERE nome = 'ÉLIX NETO') WHERE nome = 'ALGUÉM MENOR NIVEL';


WITH recursive_cte_profissional AS
(
	SELECT p.id,
	       p.nome,
	       1 as nivel
	  FROM profissional p
	 WHERE p.id_profissional_superior IS NULL
	
	UNION ALL
	
	SELECT p.id,
	       p.nome,
	       p_cte.nivel + 1 as nivel
	FROM recursive_cte_profissional p_cte
    JOIN profissional p ON p.id_profissional_superior = p_cte.id
)

SELECT id, nome, nivel
  FROM recursive_cte_profissional
 ORDER BY 3

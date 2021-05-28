-- DROP TABLE ex6_aliquota_inss;
CREATE TABLE ex6_aliquota_inss (
    valor_minimo decimal(6, 2),
    valor_maximo decimal(6, 2),
    aliquota decimal(6, 2),
    deducao decimal(6, 2),
    teto decimal(6, 2)
);
INSERT INTO ex6_aliquota_inss VALUES (1100, 1100, 7.5, 0, 82.5);
INSERT INTO ex6_aliquota_inss VALUES (1100.01, 2203.48, 9, 16.50, 181.81);
INSERT INTO ex6_aliquota_inss VALUES (2203.49, 3305.22, 12, 82.61, 314.01);
INSERT INTO ex6_aliquota_inss VALUES (3305.23, 6433.57, 14, 148.72, 751.97);


CREATE OR REPLACE FUNCTION fc_percentual_inss(salario DECIMAL)
RETURN DECIMAL AS
    vvalor_minimo DECIMAL(6, 2);
    vvalor_maximo DECIMAL(6, 2);
    vteto        DECIMAL(6, 2);
    vcontribuicao DECIMAL(6, 2);
BEGIN

    SELECT MIN(valor_minimo)
      INTO vvalor_minimo
      FROM ex6_aliquota_inss;
      
    IF salario < vvalor_minimo THEN
        RETURN 0;
    END IF;
    
    SELECT MAX(valor_maximo), MAX(teto)
      INTO vvalor_maximo, vteto
      FROM ex6_aliquota_inss;
    
    IF salario > vvalor_maximo THEN
        RETURN vteto;
    END IF;
    
    SELECT (salario * (inss.aliquota/100)) - inss.deducao
      INTO vcontribuicao
      FROM ex6_aliquota_inss inss
     WHERE salario BETWEEN valor_minimo AND valor_maximo;
     
    RETURN vcontribuicao;
END;

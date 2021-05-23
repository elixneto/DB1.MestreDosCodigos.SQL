/* |ORACLE| */


CREATE TABLE usuario (
    nome VARCHAR(100),
    email VARCHAR(100)
);


CREATE OR REPLACE FUNCTION fc_email_eh_valido (email VARCHAR) 
RETURN VARCHAR AS
BEGIN
    DECLARE
        padrao VARCHAR(54) := '^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
        aux VARCHAR(2);
    BEGIN
        SELECT 'ok'
          INTO aux
          FROM DUAL
         WHERE REGEXP_LIKE(email, padrao);
    
        RETURN 'TRUE';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN 'FALSE';
    END;
END;


CREATE OR REPLACE TRIGGER trg_usuario_email_valido
BEFORE INSERT OR UPDATE ON usuario
FOR EACH ROW
DECLARE
BEGIN
    IF fc_email_eh_valido(:new.email) = 'FALSE' THEN
        RAISE_APPLICATION_ERROR(-20101, 'Não é possível inserir um email inválido!');
        ROLLBACK;
    END IF;
END;
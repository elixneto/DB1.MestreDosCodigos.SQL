------------------------------
-- Executar com o usuário DB1
------------------------------

DROP TABLE ex4_auditoria;
CREATE TABLE ex4_auditoria (
	sid VARCHAR2(15),
    username VARCHAR2(100),
    ip VARCHAR2(20),
    hostname VARCHAR2(100),
    data_hora DATE DEFAULT SYSDATE
);

DROP TABLE ex4_auditoria_comando;
CREATE TABLE ex4_auditoria_comando (
	sid VARCHAR2(15),
    comando VARCHAR2(100),
    data_hora DATE DEFAULT SYSDATE
);

CREATE OR REPLACE PACKAGE pk_ex4 AS
    TYPE rec_usuario IS RECORD (sid VARCHAR2(15), username VARCHAR(100), ip VARCHAR2(20), hostname VARCHAR2(100));
    
    PROCEDURE sp_logon(usuario rec_usuario);
	PROCEDURE sp_audit(operacao VARCHAR2, tabela VARCHAR2);
END pk_ex4;

CREATE OR REPLACE PACKAGE BODY pk_ex4 AS
    PROCEDURE sp_logon(usuario rec_usuario) IS
    BEGIN
        INSERT INTO ex4_auditoria (sid, username, ip, hostname)
        VALUES (usuario.sid, usuario.username, usuario.ip, usuario.hostname);
    END;
	
	PROCEDURE sp_audit(operacao VARCHAR2, tabela VARCHAR2) IS
		vsid     VARCHAR2(15);
		vcomando VARCHAR2(110) := operacao || ' ' || tabela;
    BEGIN
	
		SELECT USERENV('sessionid')
		  INTO vsid
		  FROM DUAL;
	
        INSERT INTO ex4_auditoria_comando (sid, comando)
        VALUES(vsid, vcomando);
    END;
END;


CREATE TABLE minha_tabela (
    chave VARCHAR2(10),
    valor VARCHAR2(100)
);
CREATE OR REPLACE TRIGGER trg_minha_tabela_aud
AFTER INSERT OR UPDATE OR DELETE ON minha_tabela
FOR EACH ROW
DECLARE
    voperacao VARCHAR2(6);
BEGIN
    case
        when inserting then
            voperacao := 'INSERT';
        when updating then
            voperacao := 'UPDATE';
        when deleting then
            voperacao := 'DELETE';
    end case;
    
    PK_EX4.sp_audit(voperacao, 'minha_tabela');
END;



------------------------------
-- Executar com o usuário SYS
------------------------------

CREATE OR REPLACE TRIGGER trg_ex4_logon
 AFTER LOGON ON DATABASE
 DECLARE
    rec DB1.PK_EX4.rec_usuario;
 BEGIN
    SELECT s.audsid, s.username, ora_client_ip_address, s.MACHINE
      INTO rec.sid, rec.username, rec.ip, rec.hostname
      FROM v$session s
     WHERE audsid = USERENV('sessionid');
     
    DB1.PK_EX4.sp_logon(rec);
 END;

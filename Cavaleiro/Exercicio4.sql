CREATE TABLE ex4_auditoria (
    ip VARCHAR2(20),
    hostname VARCHAR2(100),
    comando_executado VARCHAR2(4000),
    data_hora DATE DEFAULT SYSDATE
);


CREATE PACKAGE pk_ex4 AS
    TYPE rec_usuario IS RECORD (ip VARCHAR2(20), hostname VARCHAR2(100));
    
    PROCEDURE sp_logon(usuario rec_usuario);
END pk_ex4;

CREATE PACKAGE BODY pk_ex4 AS
    PROCEDURE sp_logon(usuario rec_usuario) IS
    BEGIN
        INSERT INTO ex4_auditoria (ip, hostname, comando_executado)
        VALUES (usuario.ip, usuario.hostname, 'LOGON');
    END;
END;

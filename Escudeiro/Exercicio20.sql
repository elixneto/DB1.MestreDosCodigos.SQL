USE mestredoscodigos;

DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS fornecedor;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS endereco;
DROP TABLE IF EXISTS cidade;
DROP TABLE IF EXISTS estado;


CREATE TABLE estado (
	id INT IDENTITY PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	uf VARCHAR(2) NOT NULL
);
CREATE UNIQUE INDEX idx_estado_uf ON estado (uf);

CREATE TABLE cidade (
	id INT IDENTITY PRIMARY KEY,
	id_estado INT NOT NULL,
	nome VARCHAR(50) NOT NULL,
	codigo_ibge VARCHAR(7) NOT NULL,
	
	FOREIGN KEY (id_estado) REFERENCES estado (id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);
CREATE UNIQUE INDEX idx_cidade_codigo_ibge ON cidade (codigo_ibge);

CREATE TABLE endereco (
	id INT IDENTITY PRIMARY KEY,
	id_cidade INT NOT NULL,
	bairro VARCHAR(100) NOT NULL,
	logradouro VARCHAR(100) NOT NULL,
	cep VARCHAR(8),
		
	FOREIGN KEY (id_cidade) REFERENCES cidade (id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE cliente (
	id INT IDENTITY PRIMARY KEY,
	id_endereco INT,
	nome VARCHAR(100) NOT NULL,
	telefone VARCHAR(20),
	email VARCHAR(100),
	
	FOREIGN KEY (id_endereco) REFERENCES endereco (id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);
CREATE INDEX idx_cliente_endereco ON cliente (id_endereco);

CREATE TABLE fornecedor (
	id INT IDENTITY PRIMARY KEY,
	id_endereco INT,
	nome VARCHAR(100) NOT NULL,
		
	FOREIGN KEY (id_endereco) REFERENCES endereco (id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE funcionario (
	id INT IDENTITY PRIMARY KEY,
	id_endereco INT,
	nome VARCHAR(100) NOT NULL,
		
	FOREIGN KEY (id_endereco) REFERENCES endereco (id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

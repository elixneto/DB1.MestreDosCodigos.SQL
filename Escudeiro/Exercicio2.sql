USE mestredoscodigos;

DROP TABLE IF EXISTS atendimento;
DROP TABLE IF EXISTS historico_clinica_profissional;
DROP TABLE IF EXISTS clinica_profissional;
DROP TABLE IF EXISTS profissional;
DROP TABLE IF EXISTS tipo_profissional;
DROP TABLE IF EXISTS paciente;
DROP TABLE IF EXISTS clinica;
DROP TABLE IF EXISTS usuario_endereco;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS endereco;

CREATE TABLE clinica (
	id INT IDENTITY PRIMARY KEY,
	cnpj VARCHAR(14) NOT NULL,
	nome_fantasia VARCHAR(100) NOT NULL
);
CREATE UNIQUE INDEX idx_clinica_cnpj ON clinica (cnpj);


CREATE TABLE tipo_profissional (
	id INT IDENTITY PRIMARY KEY,
	descricao VARCHAR(100) NOT NULL
);


CREATE TABLE profissional (
	id INT IDENTITY PRIMARY KEY,
	id_tipo_profissional INT NOT NULL,
	nome VARCHAR(100) NOT NULL
	
	FOREIGN KEY (id_tipo_profissional) REFERENCES tipo_profissional (id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);


CREATE TABLE clinica_profissional (
	id_clinica INT NOT NULL,
	id_profissional INT NOT NULL,
	
	FOREIGN KEY (id_clinica) REFERENCES clinica (id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
		
	FOREIGN KEY (id_profissional) REFERENCES profissional (id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
		
	PRIMARY KEY (id_clinica, id_profissional)
);


CREATE TABLE historico_clinica_profissional (
	uuid UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	id_clinica INT NOT NULL,
	id_profissional INT NOT NULL,
	data_historico DATE DEFAULT GETDATE() NOT NULL,
	
	FOREIGN KEY (id_clinica, id_profissional) REFERENCES clinica_profissional (id_clinica, id_profissional)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);
CREATE INDEX idx_historico_clinica_profissional_clinica ON historico_clinica_profissional (id_clinica);
CREATE INDEX idx_historico_clinica_profissional_profissional ON historico_clinica_profissional (id_profissional);
CREATE INDEX idx_historico_clinica_profissional_data_historico ON historico_clinica_profissional (data_historico DESC);


CREATE TABLE paciente (
	id INT IDENTITY PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	data_nascimento DATE
);


CREATE TABLE usuario (
	id INT IDENTITY PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	hash_senha VARCHAR(500) NOT NULL
);
CREATE INDEX idx_usuario_email ON usuario (email);


CREATE TABLE atendimento (
	id INT IDENTITY PRIMARY KEY,
	id_paciente INT NOT NULL,
	id_clinica INT NOT NULL,
	id_profissional INT NOT NULL,
	id_usuario_inclusao INT NOT NULL,
	data_atendimento DATE NOT NULL,
	aprovado BIT NOT NULL,
	
	FOREIGN KEY (id_paciente) REFERENCES paciente (id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,

	FOREIGN KEY (id_clinica, id_profissional) REFERENCES clinica_profissional (id_clinica, id_profissional)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
		
	FOREIGN KEY (id_usuario_inclusao) REFERENCES usuario (id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);
CREATE INDEX idx_atendimento_data_atendimento ON atendimento (data_atendimento DESC);
CREATE INDEX idx_atendimento_paciente ON atendimento (id_paciente);


CREATE TABLE endereco (
	id INT IDENTITY PRIMARY KEY,
	rua VARCHAR(100) NOT NULL,
	bairro VARCHAR(100) NOT NULL,
	cep VARCHAR(8)
);
CREATE INDEX idx_endereco_cep ON endereco (cep);
CREATE INDEX idx_endereco_bairro_rua ON endereco (bairro, rua);


CREATE TABLE usuario_endereco (
	id_usuario INT NOT NULL,
	id_endereco INT NOT NULL,
	
	FOREIGN KEY (id_usuario) REFERENCES usuario (id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
		
	FOREIGN KEY (id_endereco) REFERENCES endereco (id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
		
	PRIMARY KEY (id_usuario, id_endereco)
);
CREATE UNIQUE INDEX unq_usuario_endereco_usuario ON usuario_endereco (id_usuario);
CREATE UNIQUE INDEX unq_usuario_endereco_endereco ON usuario_endereco (id_endereco);

USE mestredoscodigos;

-- DROP TABLE clinica;
CREATE TABLE clinica (
	id INT IDENTITY PRIMARY KEY,
	cnpj VARCHAR(14) NOT NULL
);

-- DROP TABLE tipo_profissional;
CREATE TABLE tipo_profissional (
	id INT IDENTITY PRIMARY KEY,
	descricao VARCHAR(100) NOT NULL
);

-- DROP TABLE profissional;
CREATE TABLE profissional (
	id INT IDENTITY PRIMARY KEY,
	id_tipo_profissional INT NOT NULL,
	nome VARCHAR(100) NOT NULL
	
	FOREIGN KEY (id_tipo_profissional) REFERENCES tipo_profissional (id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);

-- DROP TABLE clinica_profissional;
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

-- DROP TABLE historico_clinica_profissional;
CREATE TABLE historico_clinica_profissional (
	uuid UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
	id_clinica INT NOT NULL,
	id_profissional INT NOT NULL,
	data_historico DATE DEFAULT GETDATE() NOT NULL,
	
	FOREIGN KEY (id_clinica, id_profissional) REFERENCES clinica_profissional (id_clinica, id_profissional)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);

-- DROP TABLE paciente;
CREATE TABLE paciente (
	id INT IDENTITY PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	data_nascimento DATE
);

-- DROP TABLE atendimento;
CREATE TABLE atendimento (
	id INT IDENTITY PRIMARY KEY,
	id_paciente INT NOT NULL,
	id_clinica INT NOT NULL,
	id_profissional INT NOT NULL,
	data_atendimento DATE NOT NULL,
	aprovado BIT NOT NULL,
	
	FOREIGN KEY (id_paciente) REFERENCES paciente (id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,

	FOREIGN KEY (id_clinica, id_profissional) REFERENCES clinica_profissional (id_clinica, id_profissional)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);

-- DROP TABLE usuario;
CREATE TABLE usuario (
	id INT IDENTITY PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	hash_senha VARCHAR(500) NOT NULL
);

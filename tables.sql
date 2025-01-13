CREATE SEQUENCE codigo_disciplina 
    INCREMENT BY 1 
    START WITH 1;

CREATE TABLE Curso(
    nome_curso VARCHAR2(50),
    carga_horaria NUMBER NOT NULL,
    CPF_coordenador CHAR(11) NOT NULL,
    CONSTRAINT curso_pk PRIMARY KEY(nome_curso)
);

CREATE TABLE Disciplina(
    codigo_disciplina INTEGER,
    nome_disciplina VARCHAR2(20) NOT NULL,
    carga_horaria NUMBER NOT NULL,
    nome_curso VARCHAR2(50) NOT NULL,
    CONSTRAINT disciplina_pk PRIMARY KEY(codigo_disciplina),
    CONSTRAINT disciplina_nome_curso_fk FOREIGN KEY(nome_curso) REFERENCES Curso(nome_curso)
);

CREATE TABLE Sala(
    predio VARCHAR2(20),
    num_sala VARCHAR2(4),
    capacidade NUMBER,
    CONSTRAINT sala_pk PRIMARY KEY(predio,num_sala)
);

CREATE TABLE Turma(
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    CONSTRAINT turma_pk PRIMARY KEY(codigo_turma,codigo_disciplina),
    CONSTRAINT turma_codigo_disciplina_fk FOREIGN KEY(codigo_disciplina) REFERENCES Disciplina(codigo_disciplina)
);

CREATE TABLE Data_aula(
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    horario DATE,
    dia_semana VARCHAR(13),
    CONSTRAINT data_aula_pk PRIMARY KEY (codigo_turma,codigo_disciplina,horario,dia_semana),
    CONSTRAINT data_aula_codigo_turma_fk FOREIGN KEY(codigo_turma,codigo_disciplina) REFERENCES Turma(codigo_turma,codigo_disciplina),
    CONSTRAINT data_aula_codigo_disciplina_fk FOREIGN KEY(codigo_disciplina) REFERENCES Disciplina(codigo_disciplina),
    CONSTRAINT data_aula_horario_check CHECK (dia_semana IN ('SEGUNDA','TERCA','QUARTA','QUINTA','SEXTA','SABADO','DOMINGO')),
	CONSTRAINT data_aula_dia_semana_check CHECK (TO_CHAR(horario, 'HH24:MI:SS') BETWEEN '00:00:00' AND '23:59:59')
);

CREATE TABLE Pessoa(
    CPF CHAR(11),
    rua VARCHAR2(50),
    cidade VARCHAR2(20),
    numero NUMBER,
    CEP CHAR(8),
    data_nascimento DATE,
    email VARCHAR2(30),
    nome VARCHAR2(50),
    CONSTRAINT pessoa_pk PRIMARY KEY(CPF)
);

CREATE TABLE Telefone(
    telefone CHAR(11),
    CPF CHAR(11),
    CONSTRAINT telefone_pk PRIMARY KEY(telefone,CPF),
    CONSTRAINT telefone_CPF_fk FOREIGN KEY(CPF) REFERENCES Pessoa(CPF)
);

CREATE TABLE Aluno(
    CPF_aluno CHAR(11),
    numero_matricula VARCHAR2(11),
    status VARCHAR2(20),
    data_matricula DATE,
    nome_curso VARCHAR2(50),
    CONSTRAINT aluno_pk PRIMARY KEY (CPF_aluno),
    CONSTRAINT aluno_CPF_aluno_fk FOREIGN KEY (CPF_aluno) REFERENCES Pessoa(CPF)
);

CREATE TABLE Professor_cargo(
    cargo VARCHAR(20),
    salario NUMBER,
    CONSTRAINT professor_cargo_pk PRIMARY KEY(cargo)
);

CREATE TABLE Professor(
    CPF_professor CHAR(11),
    cargo VARCHAR(30),
    data_contratacao DATE,
    CPF_supervisor CHAR(11),
    CONSTRAINT profesor_pk PRIMARY KEY(CPF_professor),
    CONSTRAINT professor_CPF_professor_fk FOREIGN KEY(CPF_professor) REFERENCES Pessoa(CPF),
    CONSTRAINT professor_CPF_supervisor_fk FOREIGN KEY(CPF_supervisor) REFERENCES Professor(CPF_professor),
    CONSTRAINT professor_cargo_fk FOREIGN KEY(cargo) REFERENCES Professor_cargo(cargo) 
);

CREATE TABLE Ensina(
    predio_sala VARCHAR2(20),
    num_sala VARCHAR2(4),
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,--
    horario_reserva DATE,
    CPF_professor CHAR(11),
    CONSTRAINT ensina_pk PRIMARY KEY(predio_sala,num_sala,codigo_turma,codigo_disciplina,horario_reserva),
    CONSTRAINT ensina_predio_sala_fk FOREIGN KEY(predio_sala, num_sala) REFERENCES Sala(predio, num_sala),
    CONSTRAINT ensina_cod_turma_fk FOREIGN KEY(codigo_turma,codigo_disciplina) REFERENCES Turma(codigo_turma,codigo_disciplina),
    CONSTRAINT ensina_CPF_professor_fk FOREIGN KEY(CPF_professor) REFERENCES Professor(CPF_professor)
);

CREATE TABLE Prova (
    codigo_prova INTEGER,
    CPF_aluno CHAR(11),
    codigo_turma VARCHAR2(10),
    descricao VARCHAR(100),
    pontuacao NUMBER(4,2),
    codigo_disciplina INTEGER,
    CONSTRAINT prova_codigo_prova_pkey PRIMARY KEY(codigo_prova),
    CONSTRAINT prova_CPF_aluno_fkey1 FOREIGN KEY (CPF_aluno) REFERENCES Aluno(CPF_aluno),
    CONSTRAINT prova_codigo_turma_fkey2 FOREIGN KEY (codigo_turma,codigo_disciplina) REFERENCES Turma(codigo_turma,codigo_disciplina),
    CONSTRAINT prova_codigo_disciplina_fkey3 FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina(codigo_disciplina),
    CONSTRAINT prova_pontuacao_check CHECK (pontuacao BETWEEN 0 AND 10)
);

CREATE TABLE Matricula (
    CPF_aluno CHAR(11),
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    CONSTRAINT matricula_pkey PRIMARY KEY (CPF_aluno,codigo_turma,codigo_disciplina),
    CONSTRAINT matricula_CPF_aluno_fkey1 FOREIGN KEY (CPF_aluno) REFERENCES Aluno(CPF_aluno),
    CONSTRAINT matricula_codigo_turma_fkey2 FOREIGN KEY (codigo_turma,codigo_disciplina) REFERENCES Turma(codigo_turma,codigo_disciplina),
    CONSTRAINT matricula_codigo_disciplina_fkey3 FOREIGN KEY (codigo_disciplina) REFERENCES Disciplina(codigo_disciplina)
);

ALTER TABLE Curso ADD(CONSTRAINT curso_CPF_coordenador_fk FOREIGN KEY(CPF_coordenador) REFERENCES Professor(CPF_professor));


/*GRANT SERVE PARA DAR PRIVILÉGIOS A UM DADO USUÁRIO PARA UMA DADA TABELA OU VIEW. ESSES PRIVILÉGIOS PODEM SER VÁRIOS, COMO INSERT, DELETE, ETC.
SEGUE COMANDO GERAL: GRANT <PRIVILEGIOS> ON <TABELA/VIEW> TO <USUARIO>; O USUARIO PODE SER UM USUARIO CADASTRADO OU PODE SER SETADO EM PUBLIC

O REVOKE É JUSTAMENTE O OPOSTO DO GRATN, OU SEJA, REMOVE PROVILEGIOS DE UM DADO USUARIO DE UMA DETERMINADA TABELA OU VIEW. SEGUE COMANDO GERAL:
REVOKE <PRIVILEGIOS> ON <TABELA/VIEW> FORM <USUARIO>;*/



INSERT INTO Pessoa VALUES('45678912564', 'Avenida Magica', 'Recife', 444499, '50030098', TO_DATE('30-11-1990', 'DD-MM-YYYY'), 'sininho@gmail.com', 'Sininho');
INSERT INTO Pessoa VALUES('45678912009', 'Terra do Nunca', 'Recife', 2019029, '50030099', TO_DATE('11-08-1989', 'DD-MM-YYYY'), 'peter.pan@gmail.com', 'Peter Pan');

INSERT INTO Professor VALUES('45678912564', 'Titular', TO_DATE('15-06-1968', 'DD-MM-YYYY'), '85619370518'); 
INSERT INTO Professor VALUES('45678912009', 'Titular', TO_DATE('14-03-1972', 'DD-MM-YYYY'), '85619370518'); 
	
SELECT P.CPF_professor, P.data_contratacao, PC.cargo, PC.salario FROM Professor P INNER JOIN Professor_cargo PC ON P.cargo = PC.cargo WHERE PC.salario = (SELECT MAX(salario) FROM Professor_cargo);

SELECT * FROM Curso WHERE carga_horaria = (SELECT MIN(carga_horaria) FROM Curso);

SELECT * FROM Sala WHERE capacidade IN (30, 50);

SELECT P.CPF_professor, P.data_contratacao, PC.cargo, PC.salario FROM Professor P INNER JOIN Professor_cargo PC ON P.cargo = PC.cargo WHERE PC.salario > (SELECT AVG(salario) FROM Professor_cargo);

SELECT nome_curso, COUNT(CPF_aluno) FROM Aluno GROUP BY nome_curso HAVING COUNT(*) > 2;

SELECT codigo_prova, D.nome_disciplina, P.CPF_aluno, P.pontuacao FROM Prova P INNER JOIN Disciplina D ON P.codigo_disciplina = D.codigo_disciplina WHERE P.pontuacao BETWEEN 8 AND 9;

SELECT nome_curso, carga_horaria FROM Curso WHERE nome_curso LIKE 'Engenharia%' ORDER BY carga_horaria;

SELECT nome_disciplina FROM Disciplina WHERE nome_curso = 'Engenharia da Computação' UNION (SELECT nome_disciplina FROM Disciplina WHERE nome_curso = 'Ciência da Computação');

CREATE INDEX Dis_carga_horaria ON Disciplina (carga_horaria);

CREATE VIEW join_MaDis AS SELECT CPF_aluno, codigo_turma, M.codigo_disciplina FROM Matricula M INNER JOIN Disciplina D ON M.codigo_disciplina = D.codigo_disciplina;

SELECT CPF_aluno, codigo_turma FROM join_MaDis WHERE codigo_disciplina = ANY (SELECT codigo_disciplina FROM Disciplina WHERE carga_horaria >= 100);

-- SELECT CPF_aluno, codigo_turma FROM Matricula M WHERE M.CPF_aluno IN (SELECT nome_disciplina FROM Disciplina WHERE carga_horaria <= ALL (SELECT carga_horaria FROM Disciplina WHERE carga_horaria > 100)
-- );

SELECT A.CPF_aluno FROM Aluno A LEFT JOIN Matricula M ON A.CPF_aluno = M.CPF_aluno WHERE M.CPF_aluno IS NULL;

SELECT P.pontuacao, D.nome_disciplina, P.CPF_aluno
FROM Prova P INNER JOIN Disciplina D ON P.codigo_disciplina = D.codigo_disciplina
WHERE D.nome_disciplina = 'Algoritmos Avançados'
AND P.pontuacao > ALL (
    SELECT P.pontuacao
    FROM Prova P
    INNER JOIN Disciplina D ON P.codigo_disciplina = D.codigo_disciplina
    WHERE D.nome_disciplina = 'Introdução à Programação'
);

--SELECT CPF_aluno, codigo_turma FROM Matricula M INNER JOIN Disicplina D ON M.codigo_disciplina = D.codigo_disciplina WHERE M.codigo_disciplina = ANY (SELECT codigo_disciplina FROM Disciplina WHERE carga_horaria >= 100);

--SET SERVEROUTPUT ON; NÃO PRECISA NO ORACLE LIVE SQL

DECLARE
    v_disciplina Disciplina%ROWTYPE;
BEGIN
    FOR v_disciplina IN (SELECT * FROM Disciplina) LOOP
        IF v_disciplina.nome_curso = 'Ciência da Computação' AND v_disciplina.nome_disciplina = 'Sistemas Digitais' THEN
            UPDATE Disciplina
            SET nome_disciplina = 'SD'
            WHERE codigo_disciplina = v_disciplina.codigo_disciplina;
        ELSIF v_disciplina.nome_curso = 'Engenharia da Computação' AND v_disciplina.nome_disciplina = 'Introdução à Programação' THEN
            UPDATE Disciplina
            SET nome_disciplina = 'Programação 1'
            WHERE codigo_disciplina = v_disciplina.codigo_disciplina;
        END IF;
    END LOOP;
END;
/
-- Segue SELECT para verificar a consulta acima
SELECT * FROM Disciplina;
-- DECLARE 
-- 	v_disciplina Disciplina%ROWTYPE;
-- BEGIN
-- 	SELECT * INTO v_disciplina FROM Disciplina WHERE nome_disciplina = 'Banco de Dados';
--   DBMS_OUTPUT.PUT_LINE(v_disciplina.codigo_disciplina ||  ' ' || v_disciplina.nome_disciplina || 'está sendo renomeada para GDI')
--   UPDATE Disciplina SET nome_disciplina = "GDI" WHERE nome_disciplina = 'Banco de Dados'
-- END;


DECLARE
    v_cod_disciplina NUMBER := 1;
    soma_horas_disciplinas NUMBER := 0;
    v_ch Disciplina.carga_horaria%TYPE;
    max_cod NUMBER;
BEGIN
    SELECT MAX(codigo_disciplina) INTO max_cod FROM Disciplina;
    WHILE v_cod_disciplina <= max_cod LOOP
        BEGIN
        SELECT carga_horaria INTO v_ch FROM Disciplina WHERE codigo_disciplina = v_cod_disciplina;
        soma_horas_disciplinas := soma_horas_disciplinas + v_ch;
        END;
        v_cod_disciplina := v_cod_disciplina + 1;
    END LOOP;
		DBMS_OUTPUT.PUT_LINE('Total de horas: ' || soma_horas_disciplinas);
END;
/


DECLARE
  TYPE rv_dis IS RECORD(
    output_carga_horaria Disciplina.carga_horaria%TYPE,
    output_nome_disciplina Disciplina.nome_disciplina%TYPE
  );	

  Ex_record rv_dis;

  CURSOR diminuir_horas IS SELECT carga_horaria, nome_disciplina FROM Disciplina;
BEGIN
  OPEN diminuir_horas;
  LOOP
    FETCH diminuir_horas INTO Ex_record;
    EXIT WHEN diminuir_horas%NOTFOUND;
    IF Ex_record.output_carga_horaria >= 120 THEN
      DBMS_OUTPUT.PUT_LINE('A Disciplina: ' || Ex_record.output_nome_disciplina || ' tem carga horária elevada de: ' || Ex_record.output_carga_horaria);
    END IF;
  END LOOP;
  CLOSE diminuir_horas;
END;
/


-- DECLARE
-- 	output_carga_horaria Disciplina.carga_horaria%TYPE;
--   output_nome_disciplina Disciplina.nome_disciplina%TYPE
--   CURSOR diminuir_horas IS SELECT carga_horaria, nome_disciplina FROM Disciplina;
-- BEGIN
-- 	OPEN diminuir_horas;
-- 	LOOP
--   	FETCH diminuir_horas INTO output_carga_horaria, output_nome_disciplina;
--     EXIT WHEN diminuir_horas%NOTFOUND;
--     IF output_carga_horaria >= 120 THEN
--     	DBMS_OUTPUT.PUT_LINE('A Disciplina: ' || output_nome_disciplina || 'Tem carga horária elevada de: ' || output_carga_horaria);
--     END IF;
--   END LOOP;
--   CLOSE diminuir_horas;
-- END;
CREATE OR REPLACE PROCEDURE reajuste_salario IS
  v_salario Professor_cargo.salario%TYPE;
  v_cargo Professor_cargo.cargo%TYPE;
  
  CURSOR aumento_salarial IS SELECT cargo, salario FROM Professor_cargo;
  BEGIN
    OPEN aumento_salarial;

    LOOP
      FETCH aumento_salarial INTO v_cargo, v_salario;
      EXIT WHEN aumento_salarial%NOTFOUND;

      CASE 
        WHEN v_cargo = 'Titular' THEN 
          UPDATE Professor_cargo 
          SET salario = v_salario * 1.2 
          WHERE cargo = v_cargo;

        WHEN v_cargo = 'Professor' THEN 
          UPDATE Professor_cargo 
          SET salario = v_salario * 1.1 
          WHERE cargo = v_cargo;
        ELSE NULL;
      END CASE;
  	END LOOP;
  	CLOSE aumento_salarial;
  
END reajuste_salario;
/
--Checa a consulta acima  
EXEC reajuste_salario;
SELECT * FROM Professor_cargo;


-- CREATE OR REPLACE FUNCTION calcula_id_dis RETURN INTEGER IS
-- novo_id INTEGER;
-- BEGIN
-- 	select max(id) into  novo_id from Disciplina;	
-- 	novo_id :=  novo_id + 1;
-- 	RETURN novo_id;
-- END calcula;

CREATE OR REPLACE PACKAGE pacote AS 
PROCEDURE inserir_sala(s_predio Sala.predio%TYPE, s_num Sala.num_sala%TYPE, s_capacidade Sala.capacidade%TYPE);
PROCEDURE dizer_capacidade_sala(s_predio IN Sala.predio%TYPE, s_num IN Sala.num_sala%TYPE, s_capacidade OUT Sala.capacidade%TYPE);
END pacote;
/
CREATE OR REPLACE PACKAGE BODY pacote AS
PROCEDURE inserir_sala(s_predio Sala.predio%TYPE, s_num Sala.num_sala%TYPE, s_capacidade Sala.capacidade%TYPE) IS
BEGIN
  INSERT INTO Sala (predio, num_sala, capacidade) VALUES (s_predio, s_num, s_capacidade);
END inserir_sala;

PROCEDURE dizer_capacidade_sala(s_predio IN Sala.predio%TYPE, s_num IN Sala.num_sala%TYPE, s_capacidade OUT Sala.capacidade%TYPE) IS
BEGIN
    SELECT capacidade INTO s_capacidade
    FROM Sala 
    WHERE predio = s_predio AND num_sala = s_num;
  	EXCEPTION WHEN NO_DATA_FOUND THEN s_capacidade := NULL;
  END dizer_capacidade_sala;
END pacote;
/

BEGIN
  pacote.inserir_sala('Prédio A', 'H101', 50);
END;
/
SELECT * FROM Sala WHERE predio = 'Prédio A' AND num_sala = 'H101';
DECLARE
  capacidade Sala.capacidade%TYPE;
BEGIN
  pacote.dizer_capacidade_sala('Prédio A', 'H101', capacidade);
  DBMS_OUTPUT.PUT_LINE('Capacidade da sala: ' || capacidade);
END;
/


CREATE OR REPLACE TRIGGER trg_codigo_disciplina
BEFORE INSERT ON Disciplina
FOR EACH ROW
BEGIN
  IF :NEW.codigo_disciplina IS NULL THEN
    SELECT codigo_disciplina.NEXTVAL
    INTO :NEW.codigo_disciplina
    FROM dual;
  END IF;
END;
/

INSERT INTO Disciplina (nome_disciplina, carga_horaria, nome_curso) 
VALUES ('Eletromagnetismo', 100, 'Engenharia da Computação');

SELECT * FROM Disciplina;

--TRIGGER DE COMANDO

CREATE TABLE salvar_data_insert_disciplina (
    id_salvamento NUMBER GENERATED ALWAYS AS IDENTITY, -- Gerando automaticamente
    descricao VARCHAR2(255),
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_id_salvamento PRIMARY KEY (id_salvamento)
);

CREATE OR REPLACE TRIGGER salvar_hora
AFTER INSERT ON Disciplina
BEGIN
  INSERT INTO salvar_data_insert_disciplina (descricao)
  VALUES ('Um ou mais registros foram inseridos na tabela Disciplina');
END;
/
--TESTANDO O TRIGGER	
INSERT INTO Disciplina VALUES(codigo_disciplina.NEXTVAL, 'IA 2', 140, 'Ciência de Dados'); 
SELECT * FROM salvar_data_insert_disciplina;

-- Criando um tipo de coleção do tipo TABLE que irá armazenar os valores.
CREATE OR REPLACE TYPE tipo_resultado_media_tab IS TABLE OF NUMBER;
/

CREATE OR REPLACE FUNCTION calcular_media_aluno(p_cpf_aluno IN CHAR, p_codigo_disciplina IN INTEGER) 
RETURN tipo_resultado_media_tab IS
    v_total_pontuacao NUMBER := 0;
    v_num_provas INTEGER := 0;
    v_media NUMBER := 0;
    v_resultado tipo_resultado_media_tab := tipo_resultado_media_tab();  -- Inicializa a coleção
BEGIN
    -- Obtém a soma da pontuação e o número de provas
    SELECT SUM(pontuacao), COUNT(*) INTO v_total_pontuacao, v_num_provas
    FROM Prova 
    WHERE CPF_aluno = p_cpf_aluno AND codigo_disciplina = p_codigo_disciplina;

    -- Se houver provas, calcula a média
    IF v_num_provas > 0 THEN
        v_media := v_total_pontuacao / v_num_provas;
    ELSE
        v_media := 0; -- Se não houver provas, a média será 0
    END IF;

    -- Expande a coleção para armazenar 2 elementos
    v_resultado.EXTEND(2);
    v_resultado(1) := v_media;  -- Armazena a média
    v_resultado(2) := v_num_provas;  -- Armazena o número de provas

    RETURN v_resultado;
END;
/

-- Testando a função
DECLARE
    v_resultado tipo_resultado_media_tab;
BEGIN
    v_resultado := calcular_media_aluno('56189023471', 1);
    DBMS_OUTPUT.PUT_LINE('Média: ' || v_resultado(1));
    DBMS_OUTPUT.PUT_LINE('Quantidade de provas: ' || v_resultado(2));
END;
/



/* ESTES DEVEM SER OS ÚLTIMOS COMANDOS, JÁ QUE VÃO ALTERAR SIGNIFICATIVAMENTE AS TABELAS */

-- ALTER TABLE Disciplina ALTER COLUMN codigo_disciplina SET DEFAULT codigo_disciplina.NEXTVAL;
ALTER TABLE Curso ADD CONSTRAINT carga_horaria_positiva CHECK (carga_horaria > 0);

UPDATE Professor_cargo SET salario = salario*1.2 WHERE cargo = 'Professor';

DELETE FROM Aluno WHERE CPF_aluno IN (SELECT A.CPF_aluno FROM Aluno A LEFT JOIN Matricula M ON A.CPF_aluno = M.CPF_aluno WHERE M.CPF_aluno IS NULL);






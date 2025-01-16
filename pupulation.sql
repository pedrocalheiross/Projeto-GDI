INSERT INTO Pessoa VALUES('85619370518', 'Rua Conselheiro Portela', 'Recife', 139, '52020212', TO_DATE('01-01-1980', 'DD-MM-YYYY'), 'carlos.silva@gmail.com', 'Carlos Silva');
INSERT INTO Pessoa VALUES('32450176829', 'Rua Real da Torre', 'Recife', 705, '50610000', TO_DATE('15-06-1985','DD-MM-YYYY'), 'ana.souza@gmail.com', 'Ana Souza');
INSERT INTO Pessoa VALUES('48273956108', 'Avenida 17 de Agosto', 'Recife', 2413, '52061540', TO_DATE('10-12-2000','DD-MM-YYYY'), 'joao.santos@gmail.com', 'João Santos');
INSERT INTO Pessoa VALUES('56189023471', 'Rua São Bento', 'Olinda', 358, '53020080', TO_DATE('20-03-1995', 'DD-MM-YYYY'), 'maria.oliveira@gmail.com', 'Maria Oliveira');
INSERT INTO Pessoa VALUES('71028394615', 'Rua do Futuro', 'Recife', 180, '52050005', TO_DATE('11-07-1978', 'DD-MM-YYYY'), 'roberto.lima@gmail.com', 'Roberto Lima');
INSERT INTO Pessoa VALUES('26678900981', 'Rua do Bom Jesus ', 'Recife', 432, '50030170', TO_DATE('11-09-1990', 'DD-MM-YYYY'), 'marcelo.lima@gmail.com', 'Marcelo Cristian');

INSERT INTO Professor_cargo  VALUES('Coordenador', 8000);
INSERT INTO Professor_cargo  VALUES('Professor', 5000);
INSERT INTO Professor_cargo  VALUES('Adjunto', 4000);

INSERT INTO Professor VALUES('85619370518', 'Coordenador', TO_DATE('01-01-2010', 'DD-MM-YYYY'), NULL);
INSERT INTO Professor VALUES('32450176829', 'Professor', TO_DATE('03-05-2015', 'DD-MM-YYYY'), '85619370518');
INSERT INTO Professor VALUES('26678900981', 'Coordenador', TO_DATE('21-10-1978', 'DD-MM-YYYY'), '85619370518');
INSERT INTO Professor VALUES('48273956108', 'Adjunto', TO_DATE('23-09-2018', 'DD-MM-YYYY'), '85619370518');

INSERT INTO Curso  VALUES('Engenharia da Computação', 3000, '85619370518');
INSERT INTO Curso  VALUES('Ciência da Computação', 3200, '26678900981');

INSERT INTO Disciplina VALUES(codigo_disciplina.NEXTVAL, 'Introdução à Programação', 120, 'Engenharia da Computação');
INSERT INTO Disciplina VALUES(codigo_disciplina.NEXTVAL, 'Matemática Discreta', 90, 'Engenharia da Computação');
INSERT INTO Disciplina VALUES(codigo_disciplina.NEXTVAL, 'Sistemas Digitais', 100, 'Ciência da Computação');
INSERT INTO Disciplina VALUES(codigo_disciplina.NEXTVAL, 'Redes de Computadores', 80, 'Ciência da Computação');

INSERT INTO Sala VALUES('Prédio A', 'D005', 30);
INSERT INTO Sala VALUES('Prédio A', 'D002', 40);
INSERT INTO Sala VALUES('Prédio B', 'E101', 30);
INSERT INTO Sala VALUES('Prédio B', 'E102', 60);

INSERT INTO Turma VALUES('T01', 1);
INSERT INTO Turma VALUES('T02', 2);
INSERT INTO Turma VALUES('T03', 3);
INSERT INTO Turma VALUES('T04', 4);


INSERT INTO Data_aula (codigo_turma, codigo_disciplina, horario, dia_semana) VALUES('T01', 1, TO_TIME('10:00:00', ' HH24:MI:SS'), 'SEGUNDA');
INSERT INTO Data_aula (codigo_turma, codigo_disciplina, horario, dia_semana) VALUES('T02', 2, TO_TIME('10:00:00', 'HH24:MI:SS'), 'TERCA');
INSERT INTO Data_aula (codigo_turma, codigo_disciplina, horario, dia_semana) VALUES('T03', 3, TO_TIME('14:00:00', 'HH24:MI:SS'), 'QUARTA');
INSERT INTO Data_aula (codigo_turma, codigo_disciplina, horario, dia_semana) VALUES('T04', 4, TO_TIME('16:00:00', 'HH24:MI:SS'), 'QUINTA');

INSERT INTO Aluno (CPF_aluno, numero_matricula, status, data_matricula, nome_curso) VALUES('56189023471', '20250001', 'Ativo', TO_DATE('12-01-2022', 'DD-MM-YYYY'), 'Engenharia da Computação');
INSERT INTO Aluno (CPF_aluno, numero_matricula, status, data_matricula, nome_curso) VALUES('71028394615', '20230008', 'Ativo', TO_DATE('13-01-2020', 'DD-MM-YYYY'), 'Ciência da Computação');

INSERT INTO Telefone (telefone, CPF) VALUES('81982374309', '85619370518');
INSERT INTO Telefone (telefone, CPF) VALUES('81983433337', '32450176829');
INSERT INTO Telefone (telefone, CPF) VALUES('83983493847', '48273956108');
INSERT INTO Telefone (telefone, CPF) VALUES('83984918304', '56189023471');
INSERT INTO Telefone (telefone, CPF) VALUES('81999999083', '71028394615');

INSERT INTO Ensina (predio_sala, num_sala, codigo_turma, codigo_disciplina, horario_reserva, CPF_professor) VALUES('Prédio A', 'D005', 'T01', 1, TO_DATE('16-01-2025 07:50:00', 'DD-MM-YYYY HH24:MI:SS'), '85619370518');
INSERT INTO Ensina (predio_sala, num_sala, codigo_turma, codigo_disciplina, horario_reserva, CPF_professor) VALUES('Prédio A', 'D002', 'T02', 2, TO_DATE('16-01-2025 09:50:00', 'DD-MM-YYYY HH24:MI:SS'), '32450176829');
INSERT INTO Ensina (predio_sala, num_sala, codigo_turma, codigo_disciplina, horario_reserva, CPF_professor) VALUES('Prédio B', 'E101', 'T03', 3, TO_DATE('17-01-2025 13:50:00', 'DD-MM-YYYY HH24:MI:SS'), '32450176829');
INSERT INTO Ensina (predio_sala, num_sala, codigo_turma, codigo_disciplina, horario_reserva, CPF_professor) VALUES('Prédio B', 'E102', 'T04', 4, TO_DATE('18-01-2025 15:50:00', 'DD-MM-YYYY HH24:MI:SS'), '85619370518');

INSERT INTO Prova VALUES(86869, '56189023471', 'T01', 'Prova 1 de Introdução à Programaçaõ', 8.5, 1);
INSERT INTO Prova VALUES(09090, '71028394615', 'T03', 'Prova de Sistemas Digitais', 9.0, 3);

INSERT INTO Matricula (CPF_aluno, codigo_turma, codigo_disciplina) VALUES('56189023471', 'T01', 1);
INSERT INTO Matricula (CPF_aluno, codigo_turma, codigo_disciplina) VALUES('71028394615', 'T03', 3);

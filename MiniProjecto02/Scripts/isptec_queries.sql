USE ISPTEC;

-- ================================================================
-- 1. CONSULTAS BÁSICAS (SELECT SIMPLES)
-- ================================================================

-- 1.1 Obter todos os professores
SELECT * FROM teachers;

-- 1.2 Obter apenas o nome e email dos professores
SELECT TeacherName, TeacherEmail FROM teachers;

-- 1.3 Obter todos os cursos
SELECT * FROM courses;

-- 1.4 Obter os nomes de todos os cursos
SELECT CourseName FROM courses;

-- 1.5 Obter todos os estudantes
SELECT * FROM students;

-- 1.6 Obter todas as disciplinas
SELECT * FROM subjects;

-- 1.7 Obter todas as salas de aula
SELECT * FROM classrooms;

-- 1.8 Obter todas as aulas
SELECT * FROM classes;

-- ================================================================
-- 2. CONSULTAS COM CONDIÇÕES (WHERE)
-- ================================================================

-- 2.1 Obter professores com email específico
SELECT * FROM teachers WHERE TeacherEmail = 'cipriano.inacio@isptec.co.ao';

-- 2.2 Obter estudantes de um curso específico (Engenharia Informática)
SELECT * FROM students WHERE CourseId = 1;

-- 2.3 Obter estudantes de uma sala específica (BA5_3)
SELECT * FROM students WHERE ClassroomId = 1;

-- 2.4 Obter disciplinas de um professor específico
SELECT * FROM subjects WHERE TeacherId = 3;

-- 2.5 Obter aulas de uma sala específica
SELECT * FROM classes WHERE ClassroomId = 1;

-- 2.6 Obter estudantes cujo nome começa com 'E' (LIKE)
SELECT * FROM students WHERE StudentName LIKE 'E%';

-- 2.7 Obter estudantes cujo nome termina com 'Santos' (LIKE)
SELECT * FROM students WHERE StudentName LIKE '%Santos';

-- 2.8 Obter estudantes cujo nome contém 'Carlos' (LIKE)
SELECT * FROM students WHERE StudentName LIKE '%Carlos%';

-- 2.9 Obter professores cujo nome começa com 'C' ou 'J' (REGEXP - MySQL)
SELECT * FROM teachers WHERE TeacherName REGEXP '^[CJ]';

-- 2.10 Obter estudantes que NÃO são do curso de Engenharia Informática
SELECT * FROM students WHERE CourseId != 1;

-- ================================================================
-- 3. CONSULTAS COM MÚLTIPLAS CONDIÇÕES (AND, OR, IN, NOT IN)
-- ================================================================

-- 3.1 Obter estudantes do curso 1 E da sala 1 (AND)
SELECT * FROM students WHERE CourseId = 1 AND ClassroomId = 1;

-- 3.2 Obter estudantes do curso 1 OU do curso 2 (OR)
SELECT * FROM students WHERE CourseId = 1 OR CourseId = 2;

-- 3.3 Obter estudantes dos cursos 1, 2 ou 3 (IN)
SELECT * FROM students WHERE CourseId IN (1, 2, 3);

-- 3.4 Obter estudantes que NÃO são dos cursos 2 e 3 (NOT IN)
SELECT * FROM students WHERE CourseId NOT IN (2, 3);

-- 3.5 Obter aulas de professores específicos (IN)
SELECT * FROM classes WHERE TeacherId IN (1, 3);

-- ================================================================
-- 4. CONSULTAS COM JUNÇÕES (JOINS)
-- ================================================================

-- 4.1 Obter o nome e email dos estudantes da sala BA5_3 (INNER JOIN)
SELECT S.StudentName, S.StudentEmail 
FROM students S
INNER JOIN classrooms C ON S.ClassroomId = C.ClassroomId 
WHERE C.ClassroomName = 'BA5_3';

-- 4.2 Obter estudantes com nome da sala e nome do curso (INNER JOIN com 2 tabelas)
SELECT S.StudentName, S.StudentEmail, C.ClassroomName, CR.CourseName
FROM students S
INNER JOIN classrooms C ON S.ClassroomId = C.ClassroomId
INNER JOIN courses CR ON S.CourseId = CR.CourseId;

-- 4.3 Obter a sala, o nome do professor, a disciplina e o curso de todas as aulas (MÚLTIPLOS JOINS)
SELECT CM.ClassroomName, T.TeacherName, SB.SubjectName, CR.CourseName 
FROM classes CE
INNER JOIN classrooms CM ON CE.ClassroomId = CM.ClassroomId
INNER JOIN teachers T ON CE.TeacherId = T.TeacherId
INNER JOIN subjects SB ON CE.SubjectId = SB.SubjectId
INNER JOIN courses CR ON SB.CourseId = CR.CourseId;

-- 4.4 Obter disciplinas com o nome do professor (INNER JOIN)
SELECT S.SubjectName, T.TeacherName
FROM subjects S
INNER JOIN teachers T ON S.TeacherId = T.TeacherId;

-- 4.5 Obter professores e suas disciplinas (LEFT JOIN - inclui professores sem disciplinas)
SELECT T.TeacherName, S.SubjectName
FROM teachers T
LEFT JOIN subjects S ON T.TeacherId = S.TeacherId;

-- 4.6 Obter cursos e seus estudantes (LEFT JOIN - inclui cursos sem estudantes)
SELECT C.CourseName, S.StudentName
FROM courses C
LEFT JOIN students S ON C.CourseId = S.CourseId;

-- 4.7 Obter apenas professores que TÊM disciplinas (INNER JOIN)
SELECT DISTINCT T.TeacherName
FROM teachers T
INNER JOIN subjects S ON T.TeacherId = S.TeacherId;

-- 4.8 Consulta com WHERE após JOIN
SELECT S.StudentName, C.CourseName
FROM students S
INNER JOIN courses C ON S.CourseId = C.CourseId
WHERE C.CourseName = 'Engenharia Informática';

-- ================================================================
-- 5. FUNÇÕES AGREGADORAS (COUNT, SUM, AVG, MAX, MIN)
-- ================================================================

-- 5.1 Quantidade total de professores
SELECT COUNT(*) AS Quantidade FROM teachers;

-- 5.2 Quantidade total de estudantes
SELECT COUNT(*) AS Quantidade FROM students;

-- 5.3 Quantidade total de cursos
SELECT COUNT(*) AS Quantidade FROM courses;

-- 5.4 Quantidade total de disciplinas
SELECT COUNT(*) AS Quantidade FROM subjects;

-- 5.5 Quantidade total de salas
SELECT COUNT(*) AS Quantidade FROM classrooms;

-- 5.6 Quantidade total de aulas registradas
SELECT COUNT(*) AS Quantidade FROM classes;

-- 5.7 Quantidade de salas DISTINTAS onde já tiveram aulas
SELECT COUNT(DISTINCT ClassroomId) AS Quantidade FROM classes;

-- 5.8 Quantidade de professores DISTINTOS que ministram aulas
SELECT COUNT(DISTINCT TeacherId) AS Quantidade FROM classes;

-- 5.9 Quantidade de disciplinas DISTINTAS que têm aulas
SELECT COUNT(DISTINCT SubjectId) AS Quantidade FROM classes;

-- 5.10 Quantidade de cursos DISTINTOS frequentados pelos estudantes
SELECT COUNT(DISTINCT CourseId) AS Quantidade FROM students;

-- ================================================================
-- 6. CONSULTAS COM GROUP BY (AGRUPAMENTO)
-- ================================================================

-- 6.1 Quantidade de estudantes por curso
SELECT C.CourseName, COUNT(S.StudentId) AS Quantidade
FROM courses C
LEFT JOIN students S ON C.CourseId = S.CourseId
GROUP BY C.CourseId, C.CourseName;

-- 6.2 Quantidade de estudantes por sala
SELECT C.ClassroomName, COUNT(S.StudentId) AS Quantidade
FROM classrooms C
LEFT JOIN students S ON C.ClassroomId = S.ClassroomId
GROUP BY C.ClassroomId, C.ClassroomName;

-- 6.3 Quantidade de disciplinas por professor
SELECT T.TeacherName, COUNT(S.SubjectId) AS Quantidade
FROM teachers T
LEFT JOIN subjects S ON T.TeacherId = S.TeacherId
GROUP BY T.TeacherId, T.TeacherName;

-- 6.4 Quantidade de aulas por sala
SELECT C.ClassroomName, COUNT(CL.ClassId) AS Quantidade
FROM classrooms C
LEFT JOIN classes CL ON C.ClassroomId = CL.ClassroomId
GROUP BY C.ClassroomId, C.ClassroomName;

-- 6.5 Quantidade de aulas por professor
SELECT T.TeacherName, COUNT(CL.ClassId) AS Quantidade
FROM teachers T
LEFT JOIN classes CL ON T.TeacherId = CL.TeacherId
GROUP BY T.TeacherId, T.TeacherName;

-- 6.6 Quantidade de aulas por disciplina
SELECT S.SubjectName, COUNT(CL.ClassId) AS Quantidade
FROM subjects S
LEFT JOIN classes CL ON S.SubjectId = CL.SubjectId
GROUP BY S.SubjectId, S.SubjectName;

-- 6.7 Quantidade de aulas por curso (através de subjects)
SELECT C.CourseName, COUNT(CL.ClassId) AS Quantidade
FROM courses C
LEFT JOIN subjects S ON C.CourseId = S.CourseId
LEFT JOIN classes CL ON S.SubjectId = CL.SubjectId
GROUP BY C.CourseId, C.CourseName;

-- ================================================================
-- 7. CONSULTAS COM HAVING (FILTRO APÓS AGRUPAMENTO)
-- ================================================================

-- 7.1 Cursos com mais de 2 estudantes
SELECT C.CourseName, COUNT(S.StudentId) AS Quantidade
FROM courses C
LEFT JOIN students S ON C.CourseId = S.CourseId
GROUP BY C.CourseId, C.CourseName
HAVING COUNT(S.StudentId) > 2;

-- 7.2 Professores com mais de 1 disciplina
SELECT T.TeacherName, COUNT(S.SubjectId) AS Quantidade
FROM teachers T
LEFT JOIN subjects S ON T.TeacherId = S.TeacherId
GROUP BY T.TeacherId, T.TeacherName
HAVING COUNT(S.SubjectId) > 1;

-- 7.3 Salas com mais de 1 aula
SELECT C.ClassroomName, COUNT(CL.ClassId) AS Quantidade
FROM classrooms C
LEFT JOIN classes CL ON C.ClassroomId = CL.ClassroomId
GROUP BY C.ClassroomId, C.ClassroomName
HAVING COUNT(CL.ClassId) > 1;

-- 7.4 Cursos sem estudantes (HAVING COUNT = 0)
SELECT C.CourseName, COUNT(S.StudentId) AS Quantidade
FROM courses C
LEFT JOIN students S ON C.CourseId = S.CourseId
GROUP BY C.CourseId, C.CourseName
HAVING COUNT(S.StudentId) = 0;

-- ================================================================
-- 8. SUBCONSULTAS (SUBQUERIES)
-- ================================================================

-- 8.1 Subconsulta NÃO correlacionada - Obter estudantes do curso 'Engenharia Informática'
SELECT * FROM students 
WHERE CourseId = (SELECT CourseId FROM courses WHERE CourseName = 'Engenharia Informática');

-- 8.2 Subconsulta com IN - Obter estudantes de cursos que começam com 'Engenharia'
SELECT * FROM students 
WHERE CourseId IN (SELECT CourseId FROM courses WHERE CourseName LIKE 'Engenharia%');

-- 8.3 Subconsulta com NOT IN - Obter estudantes que NÃO são de cursos que começam com 'Engenharia'
SELECT * FROM students 
WHERE CourseId NOT IN (SELECT CourseId FROM courses WHERE CourseName LIKE 'Engenharia%');

-- 8.4 Subconsulta correlacionada no SELECT - Quantidade de disciplinas por curso
SELECT C.CourseName, 
       (SELECT COUNT(*) FROM subjects S WHERE S.CourseId = C.CourseId) AS Quantidade
FROM courses C;

-- 8.5 Subconsulta correlacionada no SELECT - Quantidade de estudantes por curso
SELECT C.CourseName, 
       (SELECT COUNT(*) FROM students S WHERE S.CourseId = C.CourseId) AS Quantidade
FROM courses C;

-- 8.6 Subconsulta correlacionada no SELECT - Quantidade de aulas por professor
SELECT T.TeacherName, 
       (SELECT COUNT(*) FROM classes CL WHERE CL.TeacherId = T.TeacherId) AS Quantidade
FROM teachers T;

-- 8.7 Subconsulta com EXISTS - Professores que TÊM disciplinas
SELECT T.TeacherName 
FROM teachers T
WHERE EXISTS (SELECT 1 FROM subjects S WHERE S.TeacherId = T.TeacherId);

-- 8.8 Subconsulta com NOT EXISTS - Professores que NÃO TÊM disciplinas
SELECT T.TeacherName 
FROM teachers T
WHERE NOT EXISTS (SELECT 1 FROM subjects S WHERE S.TeacherId = T.TeacherId);

-- 8.9 Subconsulta com NOT EXISTS - Cursos sem estudantes
SELECT C.CourseName 
FROM courses C
WHERE NOT EXISTS (SELECT 1 FROM students S WHERE S.CourseId = C.CourseId);

-- 8.10 Subconsulta com NOT EXISTS - Salas sem aulas
SELECT C.ClassroomName 
FROM classrooms C
WHERE NOT EXISTS (SELECT 1 FROM classes CL WHERE CL.ClassroomId = C.ClassroomId);

-- ================================================================
-- 9. OPERAÇÕES DE MODIFICAÇÃO (INSERT, UPDATE, DELETE)
-- ================================================================

-- 9.1 Inserir um novo professor
INSERT INTO teachers (TeacherName, TeacherEmail) 
VALUES ('Maria Silva', 'maria.silva@isptec.co.ao');

-- 9.2 Inserir múltiplos professores de uma vez
INSERT INTO teachers (TeacherName, TeacherEmail) VALUES 
    ('João Pedro', 'joao.pedro@isptec.co.ao'),
    ('Ana Costa', 'ana.costa@isptec.co.ao');

-- 9.3 Atualizar o email de um professor
UPDATE teachers 
SET TeacherEmail = 'novo.email@isptec.co.ao' 
WHERE TeacherId = 1;

-- 9.4 Atualizar o nome de um estudante
UPDATE students 
SET StudentName = 'Emanuel dos Santos Silva' 
WHERE StudentId = 1;

-- 9.5 Atualizar múltiplos campos de uma vez
UPDATE students 
SET StudentName = 'Carlos Tchípia Junior', 
    StudentEmail = 'carlos.junior@isptec.co.ao' 
WHERE StudentId = 2;

-- 9.6 Deletar um professor específico (cuidado com constraints!)
-- DELETE FROM teachers WHERE TeacherId = 5;

-- 9.7 Deletar estudantes de um curso específico
-- DELETE FROM students WHERE CourseId = 3;

-- 9.8 Deletar com subconsulta - Deletar estudantes de cursos que começam com 'Contabilidade'
-- DELETE FROM students 
-- WHERE CourseId IN (SELECT CourseId FROM courses WHERE CourseName LIKE 'Contabilidade%');

-- ================================================================
-- 10. ORDENAÇÃO (ORDER BY)
-- ================================================================

-- 10.1 Listar professores em ordem alfabética
SELECT * FROM teachers ORDER BY TeacherName ASC;

-- 10.2 Listar professores em ordem alfabética inversa
SELECT * FROM teachers ORDER BY TeacherName DESC;

-- 10.3 Listar estudantes ordenados por curso e depois por nome
SELECT * FROM students ORDER BY CourseId ASC, StudentName ASC;

-- 10.4 Listar estudantes com nome do curso, ordenados
SELECT S.StudentName, C.CourseName
FROM students S
INNER JOIN courses C ON S.CourseId = C.CourseId
ORDER BY C.CourseName, S.StudentName;

-- 10.5 Listar quantidade de estudantes por curso, em ordem decrescente
SELECT C.CourseName, COUNT(S.StudentId) AS Quantidade
FROM courses C
LEFT JOIN students S ON C.CourseId = S.CourseId
GROUP BY C.CourseId, C.CourseName
ORDER BY Quantidade DESC;

-- ================================================================
-- 11. LIMITAÇÃO DE RESULTADOS (LIMIT)
-- ================================================================

-- 11.1 Obter os primeiros 3 professores
SELECT * FROM teachers LIMIT 3;

-- 11.2 Obter os 2 primeiros estudantes
SELECT * FROM students LIMIT 2;

-- 11.3 Obter os 5 cursos com mais estudantes
SELECT C.CourseName, COUNT(S.StudentId) AS Quantidade
FROM courses C
LEFT JOIN students S ON C.CourseId = S.CourseId
GROUP BY C.CourseId, C.CourseName
ORDER BY Quantidade DESC
LIMIT 5;

-- 11.4 Paginação - Pular os primeiros 2 e pegar os próximos 2 (OFFSET)
SELECT * FROM students LIMIT 2 OFFSET 2;

-- ================================================================
-- 12. FUNÇÕES DE STRING
-- ================================================================

-- 12.1 Concatenar nome e apelido (CONCAT)
SELECT CONCAT(StudentName, ' - ', StudentEmail) AS Estudante 
FROM students;

-- 12.2 Converter nome para maiúsculas (UPPER)
SELECT UPPER(TeacherName) AS Nome FROM teachers;

-- 12.3 Converter nome para minúsculas (LOWER)
SELECT LOWER(TeacherEmail) AS Email FROM teachers;

-- 12.4 Obter os primeiros 10 caracteres do nome (SUBSTRING)
SELECT SUBSTRING(StudentName, 1, 10) AS NomeAbreviado FROM students;

-- 12.5 Tamanho do nome (LENGTH)
SELECT StudentName, LENGTH(StudentName) AS Tamanho FROM students;

-- ================================================================
-- 13. FUNÇÕES DE DATA E HORA
-- ================================================================

-- 13.1 Data e hora atual
SELECT NOW() AS DataHoraAtual;

-- 13.2 Apenas a data atual
SELECT CURDATE() AS DataAtual;

-- 13.3 Apenas a hora atual
SELECT CURTIME() AS HoraAtual;

-- 13.4 Extrair ano da data de criação
SELECT TeacherName, YEAR(CreatedAt) AS Ano FROM teachers;

-- 13.5 Extrair mês da data de criação
SELECT TeacherName, MONTH(CreatedAt) AS Mes FROM teachers;

-- 13.6 Extrair dia da data de criação
SELECT TeacherName, DAY(CreatedAt) AS Dia FROM teachers;

-- 13.7 Formatar data (DATE_FORMAT)
SELECT TeacherName, DATE_FORMAT(CreatedAt, '%d/%m/%Y') AS DataFormatada FROM teachers;

-- 13.8 Diferença de dias entre datas (DATEDIFF)
SELECT TeacherName, DATEDIFF(NOW(), CreatedAt) AS DiasDesdeRegistro FROM teachers;

-- ================================================================
-- 14. CONSULTAS COM DISTINCT (VALORES ÚNICOS)
-- ================================================================

-- 14.1 Listar cursos únicos dos estudantes
SELECT DISTINCT CourseId FROM students;

-- 14.2 Listar salas únicas onde há estudantes
SELECT DISTINCT ClassroomId FROM students;

-- 14.3 Listar professores únicos que ministram aulas
SELECT DISTINCT T.TeacherName
FROM teachers T
INNER JOIN classes C ON T.TeacherId = C.TeacherId;

-- ================================================================
-- 15. CONSULTAS COM UNION (UNIÃO DE RESULTADOS)
-- ================================================================

-- 15.1 Listar todos os emails (professores e estudantes)
SELECT TeacherEmail AS Email, 'Professor' AS Tipo FROM teachers
UNION
SELECT StudentEmail AS Email, 'Estudante' AS Tipo FROM students;

-- 15.2 Listar nomes de professores e estudantes
SELECT TeacherName AS Nome, 'Professor' AS Tipo FROM teachers
UNION
SELECT StudentName AS Nome, 'Estudante' AS Tipo FROM students
ORDER BY Nome;

-- ================================================================
-- 16. CONSULTAS COM CASE (CONDIÇÕES)
-- ================================================================

-- 16.1 Classificar cursos por área
SELECT CourseName,
       CASE 
           WHEN CourseName LIKE '%Informática%' THEN 'Tecnologia'
           WHEN CourseName LIKE '%Petróleos%' THEN 'Engenharia'
           ELSE 'Outros'
       END AS Area
FROM courses;

-- 16.2 Classificar quantidade de estudantes
SELECT C.CourseName, COUNT(S.StudentId) AS Quantidade,
       CASE 
           WHEN COUNT(S.StudentId) >= 10 THEN 'Turma Grande'
           WHEN COUNT(S.StudentId) >= 5 THEN 'Turma Média'
           ELSE 'Turma Pequena'
       END AS Classificacao
FROM courses C
LEFT JOIN students S ON C.CourseId = S.CourseId
GROUP BY C.CourseId, C.CourseName;

-- ================================================================
-- 17. VIEWS (VISÕES)
-- ================================================================

-- 17.1 Criar uma VIEW com estudantes e seus cursos
CREATE OR REPLACE VIEW vw_estudantes_cursos AS
SELECT S.StudentId, S.StudentName, S.StudentEmail, C.CourseName, CL.ClassroomName
FROM students S
INNER JOIN courses C ON S.CourseId = C.CourseId
INNER JOIN classrooms CL ON S.ClassroomId = CL.ClassroomId;

-- Usar a VIEW
SELECT * FROM vw_estudantes_cursos;

-- 17.2 Criar uma VIEW com professores e suas disciplinas
CREATE OR REPLACE VIEW vw_professores_disciplinas AS
SELECT T.TeacherId, T.TeacherName, T.TeacherEmail, S.SubjectName
FROM teachers T
LEFT JOIN subjects S ON T.TeacherId = S.TeacherId;

-- Usar a VIEW
SELECT * FROM vw_professores_disciplinas;

-- 17.3 Criar uma VIEW com estatísticas de cursos
CREATE OR REPLACE VIEW vw_estatisticas_cursos AS
SELECT C.CourseId, C.CourseName, 
       COUNT(S.StudentId) AS TotalEstudantes,
       COUNT(DISTINCT ST.SubjectId) AS TotalDisciplinas
FROM courses C
LEFT JOIN students S ON C.CourseId = S.CourseId
LEFT JOIN subjects ST ON C.CourseId = ST.CourseId
GROUP BY C.CourseId, C.CourseName;

-- Usar a VIEW
SELECT * FROM vw_estatisticas_cursos;

-- ================================================================
-- 18. STORED PROCEDURES (PROCEDIMENTOS ARMAZENADOS) - MySQL
-- ================================================================

-- 18.1 Criar procedure para listar estudantes de um curso
DELIMITER //
CREATE PROCEDURE sp_listar_estudantes_curso(IN p_course_id INT)
BEGIN
    SELECT S.StudentName, S.StudentEmail, C.CourseName
    FROM students S
    INNER JOIN courses C ON S.CourseId = C.CourseId
    WHERE S.CourseId = p_course_id;
END //
DELIMITER ;

-- Executar a procedure
CALL sp_listar_estudantes_curso(1);

-- 18.2 Criar procedure para contar estudantes por curso
DELIMITER //
CREATE PROCEDURE sp_contar_estudantes()
BEGIN
    SELECT C.CourseName, COUNT(S.StudentId) AS Quantidade
    FROM courses C
    LEFT JOIN students S ON C.CourseId = S.CourseId
    GROUP BY C.CourseId, C.CourseName;
END //
DELIMITER ;

-- Executar a procedure
CALL sp_contar_estudantes();

-- 18.3 Criar procedure para inserir novo estudante
DELIMITER //
CREATE PROCEDURE sp_inserir_estudante(
    IN p_name VARCHAR(45),
    IN p_email VARCHAR(45),
    IN p_classroom_id INT,
    IN p_course_id INT
)
BEGIN
    INSERT INTO students (StudentName, StudentEmail, ClassroomId, CourseId)
    VALUES (p_name, p_email, p_classroom_id, p_course_id);
END //
DELIMITER ;

-- Executar a procedure
-- CALL sp_inserir_estudante('Novo Estudante', 'novo@isptec.co.ao', 1, 1);

-- ================================================================
-- 19. TRIGGERS (GATILHOS) - MySQL
-- ================================================================

-- 19.1 Trigger para impedir deleção de estudantes
DELIMITER //
CREATE TRIGGER trg_proibir_delete_estudantes
BEFORE DELETE ON students
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'PROIBIDO ELIMINAR ESTUDANTES!';
END //
DELIMITER ;

-- Testar o trigger (vai dar erro)
-- DELETE FROM students WHERE StudentId = 1;

-- 19.2 Trigger para validar email antes de inserir professor
DELIMITER //
CREATE TRIGGER trg_validar_email_professor
BEFORE INSERT ON teachers
FOR EACH ROW
BEGIN
    IF NEW.TeacherEmail NOT LIKE '%@isptec.co.ao' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email deve ser do domínio @isptec.co.ao';
    END IF;
END //
DELIMITER ;

-- Testar o trigger
-- INSERT INTO teachers (TeacherName, TeacherEmail) VALUES ('Teste', 'teste@gmail.com');

-- ================================================================
-- 20. CONSULTAS AVANÇADAS
-- ================================================================

-- 20.1 Listar professores com suas disciplinas usando GROUP_CONCAT
SELECT T.TeacherName, 
       GROUP_CONCAT(S.SubjectName SEPARATOR ', ') AS Disciplinas
FROM teachers T
LEFT JOIN subjects S ON T.TeacherId = S.TeacherId
GROUP BY T.TeacherId, T.TeacherName;

-- 20.2 Ranking de cursos por número de estudantes
SELECT C.CourseName, 
       COUNT(S.StudentId) AS TotalEstudantes,
       RANK() OVER (ORDER BY COUNT(S.StudentId) DESC) AS Ranking
FROM courses C
LEFT JOIN students S ON C.CourseId = S.CourseId
GROUP BY C.CourseId, C.CourseName;

-- 20.3 Numerar estudantes por curso
SELECT StudentName, CourseName,
       ROW_NUMBER() OVER (PARTITION BY CourseName ORDER BY StudentName) AS NumeroNoCurso
FROM students S
INNER JOIN courses C ON S.CourseId = C.CourseId;

-- 20.4 Consulta com múltiplas subconsultas
SELECT 
    (SELECT COUNT(*) FROM teachers) AS TotalProfessores,
    (SELECT COUNT(*) FROM students) AS TotalEstudantes,
    (SELECT COUNT(*) FROM courses) AS TotalCursos,
    (SELECT COUNT(*) FROM subjects) AS TotalDisciplinas,
    (SELECT COUNT(*) FROM classes) AS TotalAulas;

-- ================================================================
-- REMOVER VIEWS, PROCEDURES E TRIGGERS (LIMPEZA)
-- ================================================================

-- Remover views
DROP VIEW IF EXISTS vw_estudantes_cursos;
DROP VIEW IF EXISTS vw_professores_disciplinas;
DROP VIEW IF EXISTS vw_estatisticas_cursos;

-- Remover procedures
DROP PROCEDURE IF EXISTS sp_listar_estudantes_curso;
DROP PROCEDURE IF EXISTS sp_contar_estudantes;
DROP PROCEDURE IF EXISTS sp_inserir_estudante;

-- Remover triggers
DROP TRIGGER IF EXISTS trg_proibir_delete_estudantes;
DROP TRIGGER IF EXISTS trg_validar_email_professor;
DROP DATABASE IF EXISTS ISPTEC;
CREATE DATABASE IF NOT EXISTS ISPTEC;
USE ISPTEC;

-- TABELA: PROFESSORES
CREATE TABLE teachers (
    TeacherId INT NOT NULL AUTO_INCREMENT,
    TeacherName VARCHAR(45) NOT NULL,
    TeacherEmail VARCHAR(45) NOT NULL UNIQUE,
    CreatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (TeacherId)
) COMMENT='Tabela de professores do ISPTEC';

-- TABELA: CURSOS
CREATE TABLE courses (
    CourseId INT NOT NULL AUTO_INCREMENT,
    CourseName VARCHAR(45) NOT NULL UNIQUE,
    Description TEXT NULL,
    Duration INT NULL COMMENT 'Duração em anos',
    CreatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (CourseId)
) COMMENT='Tabela de cursos oferecidos';

-- TABELA: DISCIPLINAS
CREATE TABLE subjects (
    SubjectId INT NOT NULL AUTO_INCREMENT,
    SubjectName VARCHAR(45) NOT NULL,
    Credits INT NULL COMMENT 'Créditos da disciplina',
    Workload INT NULL COMMENT 'Carga horária em horas',
    CourseId INT NOT NULL,
    TeacherId INT NOT NULL,
    CreatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (SubjectId),
    INDEX fk_CourseId_subjects_idx (CourseId ASC),
    INDEX fk_TeacherId_subjects_idx (TeacherId ASC),
    CONSTRAINT fk_CourseId_subjects
        FOREIGN KEY (CourseId)
        REFERENCES courses (CourseId)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_TeacherId_subjects
        FOREIGN KEY (TeacherId)
        REFERENCES teachers (TeacherId)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) COMMENT='Tabela de disciplinas por curso';

-- TABELA: SALAS DE AULA
CREATE TABLE classrooms (
    ClassroomId INT NOT NULL AUTO_INCREMENT,
    ClassroomName VARCHAR(45) NOT NULL UNIQUE,
    Capacity INT NULL COMMENT 'Capacidade da sala',
    CreatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ClassroomId)
) COMMENT='Tabela de salas de aula';

-- TABELA: ESTUDANTES
CREATE TABLE students (
    StudentId INT NOT NULL AUTO_INCREMENT,
    StudentName VARCHAR(45) NOT NULL,
    StudentEmail VARCHAR(45) NOT NULL UNIQUE,
    ClassroomId INT NOT NULL,
    CourseId INT NOT NULL,
    CreatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (StudentId),
    INDEX fk_ClassroomId_students_idx (ClassroomId ASC),
    INDEX fk_CourseId_students_idx (CourseId ASC),
    CONSTRAINT fk_ClassroomId_students
        FOREIGN KEY (ClassroomId)
        REFERENCES classrooms (ClassroomId)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_CourseId_students
        FOREIGN KEY (CourseId)
        REFERENCES courses (CourseId)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) COMMENT='Tabela de estudantes matriculados';

-- TABELA: AULAS
CREATE TABLE classes (
    ClassId INT NOT NULL AUTO_INCREMENT,
    ClassroomId INT NOT NULL,
    TeacherId INT NOT NULL,
    SubjectId INT NOT NULL,
    CreatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ClassId),
    INDEX fk_ClassroomId_classes_idx (ClassroomId ASC),
    INDEX fk_TeacherId_classes_idx (TeacherId ASC),
    INDEX fk_SubjectId_classes_idx (SubjectId ASC),
    CONSTRAINT fk_ClassroomId_classes
        FOREIGN KEY (ClassroomId)
        REFERENCES classrooms (ClassroomId)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_TeacherId_classes
        FOREIGN KEY (TeacherId)
        REFERENCES teachers (TeacherId)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_SubjectId_classes
        FOREIGN KEY (SubjectId)
        REFERENCES subjects (SubjectId)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) COMMENT='Tabela de aulas ministradas';

-- INSERIR DADOS: PROFESSORES
INSERT INTO teachers (TeacherName, TeacherEmail) VALUES 
    ('João Silva', 'joao.silva@isptec.co.ao'),
    ('Maria Santos', 'maria.santos@isptec.co.ao'),
    ('Pedro Costa', 'pedro.costa@isptec.co.ao'),
    ('Ana Fernandes', 'ana.fernandes@isptec.co.ao'),
    ('Carlos Almeida', 'carlos.almeida@isptec.co.ao'),
    ('Rita Oliveira', 'rita.oliveira@isptec.co.ao');

-- INSERIR DADOS: CURSOS
INSERT INTO courses (CourseName, Description, Duration) VALUES 
    ('Engenharia Informática', 'Curso focado em desenvolvimento de software, sistemas e tecnologias da informação', 5),
    ('Engenharia de Construção Civil', 'Curso focado em Construção Civil', 5),
    ('Engenharia Química', 'Curso focado em Química', 5),
    ('Engenharia de Petróleos', 'Curso focado em exploração, produção e gestão de recursos petrolíferos', 5),
    ('Engenharia Mecânica', 'Curso focado em Mecânica', 5);

-- INSERIR DADOS: DISCIPLINAS
INSERT INTO subjects (SubjectName, Credits, Workload, CourseId, TeacherId) VALUES 
    ('Base de Dados I', 6, 90, 1, 3),               -- Eng. Informática, Pedro
    ('Engenharia de Software', 6, 90, 1, 1),        -- Eng. Informática, João
    ('Análise de Algoritmos', 6, 90, 1, 1),         -- Eng. Informática, João
    ('Programação III', 6, 90, 1, 2),               -- Eng. Informática, Maria
    ('Sistemas Operativos', 6, 90, 1, 4),           -- Eng. Informática, Ana
    ('Redes de Computadores I', 6, 90, 1, 6),       -- Eng. Informática, Rita
    ('Linguagens Formais e Autômatos', 6, 90, 1, 5); -- Eng. Informática, Carlos

-- INSERIR DADOS: SALAS DE AULA
INSERT INTO classrooms (ClassroomName, Capacity) VALUES 
    ('BA5_3', 30),
    ('BA5_2', 30),
    ('BA16_2', 30),
    ('A1', 50),
    ('A8', 50),
    ('BA8_2', 30);

-- INSERIR DADOS: ESTUDANTES
INSERT INTO students (StudentName, StudentEmail, ClassroomId, CourseId) VALUES 
    ('Emanuel dos Santos', '20230001@isptec.co.ao', 1, 1),
    ('Beatriz Mendes', '20230002@isptec.co.ao', 1, 1),
    ('Daniel Pereira', '20230003@isptec.co.ao', 1, 1),
    ('Eduarda Carvalho', '20230004@isptec.co.ao', 1, 1),
    ('Fernando Gomes', '20230005@isptec.co.ao', 4, 2),
    ('Gabriela Martins', '20230006@isptec.co.ao', 5, 3),
    ('Hugo Sousa', '20230007@isptec.co.ao', 5, 3),
    ('Isabel Ferreira', '20230008@isptec.co.ao', 5, 3),
    ('Jorge Lopes', '20230009@isptec.co.ao', 5, 3),
    ('Lúcia Pinto', '20230010@isptec.co.ao', 6, 4),
    ('Miguel Rocha', '20230011@isptec.co.ao', 6, 4),
    ('Natália Correia', '20230012@isptec.co.ao', 6, 4);

-- INSERIR DADOS: AULAS
INSERT INTO classes (ClassroomId, TeacherId, SubjectId) VALUES 
    (1, 1, 2),  -- Eng. Software com João na BA5_3
    (1, 1, 3),  -- Análise Algoritmos com João na BA5_3
    (1, 3, 1),  -- Base de Dados I com Pedro na BA5_3
    (2, 1, 2),  -- Eng. Software com João na BA5_2
    (2, 1, 3),  -- Análise Algoritmos com João na BA5_2
    (2, 3, 1),  -- Base de Dados I com Pedro na BA5_2
    (3, 1, 2),  -- Eng. Software com João na BA16_2
    (3, 1, 3),  -- Análise Algoritmos com João na BA16_2
    (3, 3, 1);  -- Base de Dados I com Pedro na BA16_2
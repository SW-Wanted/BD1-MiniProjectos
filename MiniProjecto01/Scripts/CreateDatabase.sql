-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS escola;
USE escola;

-- Criar a tabela de estudantes
CREATE TABLE IF NOT EXISTS Students (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Inserir dados de exemplo (opcional)
INSERT INTO Students (Name, Email) VALUES 
('Emanuel dos Santos', 'emanuel.santos@isptec.co.ao'),
('Mariana da Silva', 'mariana.silva@example.com');
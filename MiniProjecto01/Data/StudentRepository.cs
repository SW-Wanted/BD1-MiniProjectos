using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using MiniProjecto01.Models;
using MiniProjecto01.Repositories;

namespace MiniProjecto01.Data
{
    internal class StudentRepository : IStudentRepository, IDisposable
    {
        private readonly Database _database;

        public StudentRepository(Database database)
        {
            _database = database;
        }

        public Student? GetById(int id)
        {
            try
            {
                var conn = _database.GetConnection();
                using var cmd = new MySqlCommand("SELECT Id, Name, Email FROM Students WHERE Id = @Id", conn);
                cmd.Parameters.AddWithValue("@Id", id);

                using var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    return new Student
                    {
                        Id = reader.GetInt32("Id"),
                        Name = reader.GetString("Name"),
                        Email = reader.GetString("Email")
                    };
                }

                return null;
            }
            catch (MySqlException ex)
            {
                throw new InvalidOperationException($"Erro ao buscar estudante por ID: {ex.Message}", ex);
            }
        }

        public IEnumerable<Student> GetAll()
        {
            var students = new List<Student>();
            
            try
            {
                var conn = _database.GetConnection();
                using var cmd = new MySqlCommand("SELECT Id, Name, Email FROM Students", conn);
                using var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    students.Add(new Student
                    {
                        Id = reader.GetInt32("Id"),
                        Name = reader.GetString("Name"),
                        Email = reader.GetString("Email")
                    });
                }
            }
            catch (MySqlException ex)
            {
                throw new InvalidOperationException($"Erro ao buscar todos os estudantes: {ex.Message}", ex);
            }

            return students;
        }

        public bool Add(Student student)
        {
            if (student == null) return false;

            try
            {
                var conn = _database.GetConnection();
                using var cmd = new MySqlCommand(
                    "INSERT INTO Students (Name, Email) VALUES (@Name, @Email)", conn);
                
                cmd.Parameters.AddWithValue("@Name", student.Name);
                cmd.Parameters.AddWithValue("@Email", student.Email);

                var rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0;
            }
            catch (MySqlException ex) when (ex.Number == 1062) // Duplicate entry
            {
                return false;
            }
            catch (MySqlException ex)
            {
                throw new InvalidOperationException($"Erro ao adicionar estudante: {ex.Message}", ex);
            }
        }

        public bool Update(Student student)
        {
            if (student == null) return false;

            try
            {
                var conn = _database.GetConnection();
                using var cmd = new MySqlCommand(
                    "UPDATE Students SET Name = @Name, Email = @Email WHERE Id = @Id", conn);
                
                cmd.Parameters.AddWithValue("@Id", student.Id);
                cmd.Parameters.AddWithValue("@Name", student.Name);
                cmd.Parameters.AddWithValue("@Email", student.Email);

                var rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0;
            }
            catch (MySqlException ex)
            {
                throw new InvalidOperationException($"Erro ao atualizar estudante: {ex.Message}", ex);
            }
        }

        public bool Delete(int id)
        {
            try
            {
                var conn = _database.GetConnection();
                using var cmd = new MySqlCommand("DELETE FROM Students WHERE Id = @Id", conn);
                cmd.Parameters.AddWithValue("@Id", id);

                var rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0;
            }
            catch (MySqlException ex)
            {
                throw new InvalidOperationException($"Erro ao deletar estudante: {ex.Message}", ex);
            }
        }

        public Student? GetByEmail(string email)
        {
            try
            {
                var conn = _database.GetConnection();
                using var cmd = new MySqlCommand("SELECT Id, Name, Email FROM Students WHERE Email = @Email", conn);
                cmd.Parameters.AddWithValue("@Email", email);

                using var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    return new Student
                    {
                        Id = reader.GetInt32("Id"),
                        Name = reader.GetString("Name"),
                        Email = reader.GetString("Email")
                    };
                }

                return null;
            }
            catch (MySqlException ex)
            {
                throw new InvalidOperationException($"Erro ao buscar estudante por email: {ex.Message}", ex);
            }
        }

        public IEnumerable<Student> GetByNameContains(string name)
        {
            var students = new List<Student>();
            
            try
            {
                var conn = _database.GetConnection();
                using var cmd = new MySqlCommand(
                    "SELECT Id, Name, Email FROM Students WHERE Name LIKE @Name", conn);
                cmd.Parameters.AddWithValue("@Name", $"%{name}%");

                using var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    students.Add(new Student
                    {
                        Id = reader.GetInt32("Id"),
                        Name = reader.GetString("Name"),
                        Email = reader.GetString("Email")
                    });
                }
            }
            catch (MySqlException ex)
            {
                throw new InvalidOperationException($"Erro ao buscar estudantes por nome: {ex.Message}", ex);
            }

            return students;
        }

        public void Dispose()
        {
            _database?.Dispose();
        }
    }
}
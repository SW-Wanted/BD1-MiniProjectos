using System;
using System.Collections.Generic;
using MiniProjecto01.Models;
using MiniProjecto01.Repositories;

namespace MiniProjecto01.Services
{
    internal class StudentService : IStudentService
    {
        private readonly IStudentRepository _studentRepository;

        public StudentService(IStudentRepository studentRepository)
        {
            _studentRepository = studentRepository;
        }

        public IEnumerable<Student> GetAllStudents()
        {
            return _studentRepository.GetAll();
        }

        public Student GetStudentById(int id)
        {
            return _studentRepository.GetById(id);
        }

        public bool CreateStudent(string name, string email)
        {
            // Validações de negócio
            if (string.IsNullOrWhiteSpace(name))
                throw new ArgumentException("Nome não pode ser vazio.");

            if (string.IsNullOrWhiteSpace(email))
                throw new ArgumentException("Email não pode ser vazio.");

            if (_studentRepository.GetByEmail(email) != null)
                throw new InvalidOperationException("Email já está em uso.");

            var student = new Student
            {
                Name = name,
                Email = email
            };

            return _studentRepository.Add(student);
        }

        public bool UpdateStudent(int id, string name, string email)
        {
            var student = _studentRepository.GetById(id);
            if (student == null)
                return false;

            // Verificar se o email já está em uso por outro estudante
            var existingWithEmail = _studentRepository.GetByEmail(email);
            if (existingWithEmail != null && existingWithEmail.Id != id)
                throw new InvalidOperationException("Email já está em uso.");

            student.Name = name;
            student.Email = email;

            return _studentRepository.Update(student);
        }

        public bool DeleteStudent(int id)
        {
            return _studentRepository.Delete(id);
        }

        public IEnumerable<Student> SearchStudents(string searchTerm)
        {
            return _studentRepository.GetByNameContains(searchTerm);
        }
    }
}
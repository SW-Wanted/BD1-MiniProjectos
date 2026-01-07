using System.Collections.Generic;
using System.Linq;
using MiniProjecto01.Models;
using MiniProjecto01.Repositories;

namespace MiniProjecto01.Data
{
    internal class StudentRepository : IStudentRepository
    {
        private readonly List<Student> _students = new();
        private int _nextId = 1;

        public Student? GetById(int id)
        {
            return _students.FirstOrDefault(s => s.Id == id);
        }

        public IEnumerable<Student> GetAll()
        {
            return _students.ToList();
        }

        public bool Add(Student student)
        {
            if (student == null) return false;
            
            student.Id = _nextId++;
            _students.Add(student);
            return true;
        }

        public bool Update(Student student)
        {
            if (student == null) return false;
            
            var existing = GetById(student.Id);
            if (existing == null) return false;

            existing.Name = student.Name;
            existing.Email = student.Email;
            return true;
        }

        public bool Delete(int id)
        {
            var student = GetById(id);
            if (student == null) return false;
            
            return _students.Remove(student);
        }

        // Métodos específicos de IStudentRepository
        public Student? GetByEmail(string email)
        {
            return _students.FirstOrDefault(s => s.Email.Equals(email, StringComparison.OrdinalIgnoreCase));
        }

        public IEnumerable<Student> GetByNameContains(string name)
        {
            return _students.Where(s => s.Name.Contains(name, StringComparison.OrdinalIgnoreCase)).ToList();
        }
    }
}
using MiniProjecto01.Models;
using System.Collections.Generic;

namespace MiniProjecto01.Services
{
    internal interface IStudentService
    {
        IEnumerable<Student> GetAllStudents();
        Student GetStudentById(int id);
        bool CreateStudent(string name, string email);
        bool UpdateStudent(int id, string name, string email);
        bool DeleteStudent(int id);
        IEnumerable<Student> SearchStudents(string searchTerm);
    }
}

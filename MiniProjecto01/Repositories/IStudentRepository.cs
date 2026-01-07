using MiniProjecto01.Models;

namespace MiniProjecto01.Repositories
{
    internal interface IStudentRepository : IRepository<Student>
    {
        Student? GetByEmail(string email);
        IEnumerable<Student> GetByNameContains(string name);
    }
}
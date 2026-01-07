using System.Collections.Generic;

namespace MiniProjecto01.Repositories
{
    internal interface IRepository<T> where T : class
    {
        T? GetById(int id);
        IEnumerable<T> GetAll();
        bool Add(T item);
        bool Update(T item);
        bool Delete(int id);
    }
}
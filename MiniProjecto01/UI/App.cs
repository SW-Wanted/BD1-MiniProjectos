using System;
using MiniProjecto01.Services;

namespace MiniProjecto01.UI
{
    internal class App
    {
        private readonly IStudentService _studentService;

        public App(IStudentService studentService)
        {
            _studentService = studentService;
        }

        /// <summary>
        /// Rodar o aplicativo
        /// </summary>
        public void Run()
        {
            Console.WriteLine("=== Um Sistema Qualquer ===\n");

            // Adicionar alguns estudantes
            //_studentService.CreateStudent("Emanuel dos Santos", "emanuel.santos@isptec.co.ao");
            //_studentService.CreateStudent("Mariana da Silva", "mariana.silva@example.com");

            // Listar todos os estudantes
            Console.WriteLine("Estudantes cadastrados:");
            foreach (var student in _studentService.GetAllStudents())
            {
                Console.WriteLine($"ID: {student.Id}, Nome: {student.Name}, Email: {student.Email}");
            }
        }
    }
}
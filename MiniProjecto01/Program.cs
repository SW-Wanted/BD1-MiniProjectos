using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using MiniProjecto01.Data;
using MiniProjecto01.Repositories;
using MiniProjecto01.Services;
using MiniProjecto01.UI;

// Criar e configurar o Host com Dependency Injection
var host = Host.CreateDefaultBuilder(args)
    .ConfigureServices((context, services) =>
    {
        // Registrar Repositórios (Singleton porque estamos usando lista em memória)
        services.AddSingleton<IStudentRepository, StudentRepository>();
        
        // Registrar Serviços de Negócio
        services.AddScoped<IStudentService, StudentService>();
        
        // Registrar a aplicação principal
        services.AddTransient<App>();
    })
    .Build();

// Obter a instância da App através do DI Container e executar
using (var scope = host.Services.CreateScope())
{
    var app = scope.ServiceProvider.GetRequiredService<App>();
    app.Run();
}
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using MiniProjecto01.Data;
using MiniProjecto01.Repositories;
using MiniProjecto01.Services;
using MiniProjecto01.UI;
using System;

// Criar e configurar o Host com Dependency Injection
var host = Host.CreateDefaultBuilder(args)
    .ConfigureServices((context, services) =>
    {
        // Registrar Database com connection string
        services.AddSingleton(provider => 
            new Database(DatabaseConfig.ConnectionString));
        
        // Registrar Repositórios
        services.AddSingleton<IStudentRepository, StudentRepository>();
        
        // Registrar Serviços de Negócio
        services.AddScoped<IStudentService, StudentService>();
        
        // Registrar a aplicação principal
        services.AddTransient<App>();
    })
    .Build();

// Testar conexão antes de executar
var database = host.Services.GetRequiredService<Database>();
Console.WriteLine("Testando conexão com MySQL...");
if (database.TestConnection())
{
    Console.WriteLine("✓ Conexão bem-sucedida!\n");
    
    // Obter a instância da App através do DI Container e executar
    using (var scope = host.Services.CreateScope())
    {
        var app = scope.ServiceProvider.GetRequiredService<App>();
        app.Run();
    }
}
else
{
    Console.WriteLine("✗ Falha ao conectar ao banco de dados.");
    Console.WriteLine("Verifique a connection string e se o MySQL está rodando.");
}
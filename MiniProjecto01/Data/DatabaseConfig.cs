namespace MiniProjecto01.Data
{
    internal static class DatabaseConfig
    {
        public static string ConnectionString => 
            "Server=localhost;" +
            "Port=3306;" +
            "Database=escola;" +
            "User=root;" +
            "Password=admin;";  // Don't hack me
    }
}
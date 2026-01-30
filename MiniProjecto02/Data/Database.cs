using MySqlConnector;

namespace MiniProjecto02.Data;

internal class Database
{
    private readonly string _conectionString = "server=localhost;user=root;pwd=admin;database=isptec;";

    public Database()
    {
        
    }

    /// <summary>
    /// Initializes a new instance of the Database class using the specified connection string.
    /// </summary>
    /// <param name="connectionString">The connection string used to establish a connection to the database. Cannot be null or empty.</param>
    public Database(string connectionString)
    {
        _conectionString = connectionString;
    }

    /// <summary>
    /// Creates and opens a new MySQL database connection using the configured connection string.
    /// </summary>
    /// <remarks>The caller is responsible for disposing the returned <see cref="MySqlConnection"/> when it is
    /// no longer needed. Each call returns a new connection; it does not reuse existing connections.</remarks>
    /// <returns>A <see cref="MySqlConnection"/> instance that is already open and ready for use.</returns>
    public MySqlConnection GetConnection()
    {
        var conn = new MySqlConnection(_conectionString);
        conn.Open();
        return conn;
    }

    /// <summary>
    /// Determines whether a connection to the data source is currently open and available.
    /// </summary>
    /// <remarks>If an error occurs while attempting to check the connection state, the method returns false.
    /// This method does not throw exceptions.</remarks>
    /// <returns>true if the connection to the data source is open; otherwise, false.</returns>
    public bool IsConnected()
    {
        try
        {
            using var connection = GetConnection();
            return connection.State == System.Data.ConnectionState.Open;
        }
        catch
        {
            return false;
        }
    }

    /// <summary>
    /// Retrieves the current database connection string used by the instance.
    /// </summary>
    /// <returns>A string containing the database connection details. The value may be empty if no connection string has been
    /// configured.</returns>
    public string GetConnectionString()
    {
        return _conectionString;
    }
}

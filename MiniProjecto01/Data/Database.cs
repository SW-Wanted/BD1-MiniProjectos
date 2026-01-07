using MySql.Data.MySqlClient;
using System;

namespace MiniProjecto01.Data
{
    internal class Database : IDisposable
    {
        private readonly string _connectionString;
        private MySqlConnection? _connection;

        public Database(string connectionString)
        {
            if (string.IsNullOrWhiteSpace(connectionString))
                throw new ArgumentException("Connection string não pode ser vazia.", nameof(connectionString));

            _connectionString = connectionString;
        }

        /// <summary>
        /// Obtém a conexão atual ou cria uma nova se não existir
        /// </summary>
        public MySqlConnection GetConnection()
        {
            if (_connection == null)
            {
                _connection = new MySqlConnection(_connectionString);
            }

            if (_connection.State != System.Data.ConnectionState.Open)
            {
                _connection.Open();
            }

            return _connection;
        }

        /// <summary>
        /// Testa se a conexão com o banco de dados está funcionando
        /// </summary>
        public bool TestConnection()
        {
            try
            {
                using var conn = new MySqlConnection(_connectionString);
                conn.Open();
                return true;
            }
            catch (MySqlException)
            {
                return false;
            }
        }

        /// <summary>
        /// Fecha a conexão se estiver aberta
        /// </summary>
        public void CloseConnection()
        {
            if (_connection != null && _connection.State == System.Data.ConnectionState.Open)
            {
                _connection.Close();
            }
        }

        /// <summary>
        /// Libera os recursos da conexão
        /// </summary>
        public void Dispose()
        {
            CloseConnection();
            _connection?.Dispose();
        }
    }
}

using MySqlConnector;

string connectionString = "server=localhost;user=root;pwd=[YourPassword];database=isptec";
bool isConnected()
{
    try
    {
        MySqlConnection conn = new MySqlConnection(connectionString);
        conn.Open();
        return true;
    }
    catch (Exception)
    {
        return false;
    }
}

// Quantidade de estudantes por sala das salas com mais de dois estudantes

void query()
{
    var conn = new MySqlConnection(connectionString);
    conn.Open();
    var cmd = conn.CreateCommand();
    cmd.CommandText = @"
SELECT C.ClassroomName, COUNT(S.StudentId) as Quantidade FROM Classrooms C
LEFT JOIN Students S ON S.ClassroomId = C.ClassroomId
Group By C.ClassroomName
HAVING Quantidade > 2;
";
    var reader = cmd.ExecuteReader();
    Console.WriteLine($"{"Sala", -10} {"Qantidade de estudantes", -20}");
    while(reader.Read())
    {
        Console.WriteLine($"{reader["ClassroomName"], -10} {reader["Quantidade"], -20}");
    }
}

query();
namespace MiniProjecto02.Models;
internal class Teacher
{
    public int TeacherId { get; set; }
    public string TeacherName { get; set; } = string.Empty;
    public string TeacherEmail { get; set; } = string.Empty;
    public DateTime? CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }

    /// <summary>
    /// Initializes a new instance of the Teacher class with the specified identifier, name, and email address.
    /// </summary>
    /// <param name="id">The unique identifier for the teacher.</param>
    /// <param name="name">The full name of the teacher. Cannot be null or empty.</param>
    /// <param name="email">The email address of the teacher. Cannot be null or empty.</param>
    public Teacher(int id, string name, string email)
    {
        this.TeacherId = id;
        this.TeacherName = name;
        this.TeacherEmail = email;
        this.CreatedAt = UpdatedAt = DateTime.Now;
    }

    /// <summary>
    /// Initializes a new instance of the Teacher class with the specified name and email address.
    /// </summary>
    /// <param name="name">The full name of the teacher. Cannot be null or empty.</param>
    /// <param name="email">The email address of the teacher. Cannot be null or empty.</param>
    public Teacher(string name, string email)
    {
        this.TeacherName = name;
        this.TeacherEmail = email;
        this.CreatedAt = UpdatedAt = DateTime.Now;
    }
}
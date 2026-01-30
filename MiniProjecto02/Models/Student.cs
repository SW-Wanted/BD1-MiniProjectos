namespace MiniProjecto02.Models;
internal class Student
{
    public int StudentId { get; init; }
    public string StudentName { get; set; } = string.Empty;
    public string StudentEmail { get; set; } = string.Empty;
    public int ClassroomId { get; set; }
    public int CourseId { get; set; }
    public DateTime? CreatedAt { get; init; }
    public DateTime? UpdatedAt { get; set; }

    /// <summary>
    /// Initializes a new instance of the Student class with the specified identifiers and contact information.
    /// </summary>
    /// <param name="id">The unique identifier for the student.</param>
    /// <param name="name">The full name of the student. Cannot be null or empty.</param>
    /// <param name="email">The email address of the student. Cannot be null or empty.</param>
    /// <param name="classroomId">The identifier of the classroom to which the student is assigned.</param>
    /// <param name="courseId">The identifier of the course in which the student is enrolled.</param>
    public Student(int id, string name, string email, int classroomId, int courseId)
    {
        this.StudentId = id;
        this.StudentName = name;
        this.StudentEmail = email;
        this.ClassroomId = classroomId;
        this.CourseId = courseId;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }

    /// <summary>
    /// Initializes a new instance of the Student class with the specified name, email address, classroom ID, and course
    /// ID.
    /// </summary>
    /// <param name="name">The full name of the student. Cannot be null or empty.</param>
    /// <param name="email">The email address of the student. Cannot be null or empty.</param>
    /// <param name="classroomId">The identifier of the classroom to which the student is assigned.</param>
    /// <param name="courseId">The identifier of the course in which the student is enrolled.</param>
    public Student(string name, string email, int classroomId, int courseId)
    {
        this.StudentName = name;
        this.StudentEmail = email;
        this.ClassroomId = classroomId;
        this.CourseId = courseId;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }
}

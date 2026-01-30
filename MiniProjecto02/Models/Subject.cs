namespace MiniProjecto02.Models;
internal class Subject
{
    public int SubjectId { get; init; }
    public string SubjectName { get; set; } = string.Empty;
    public int? Credits { get; set; }
    public int? Workload { get; set; }
    public int CourseId { get; set; }
    public int TeacherId { get; set; }
    public DateTime? CreatedAt { get; init; }
    public DateTime? UpdatedAt { get; set; }

    /// <summary>
    /// Initializes a new instance of the Subject class with the specified identifier, name, credits, workload, course
    /// identifier, and teacher identifier.
    /// </summary>
    /// <param name="id">The unique identifier for the subject.</param>
    /// <param name="name">The name of the subject. Cannot be null or empty.</param>
    /// <param name="credits">The number of credits assigned to the subject. Must be a non-negative integer.</param>
    /// <param name="workload">The total workload for the subject, typically measured in hours. Must be a non-negative integer.</param>
    /// <param name="courseId">The identifier of the course to which the subject belongs.</param>
    /// <param name="teacherId">The identifier of the teacher responsible for the subject.</param>
    public Subject(int id, string name, int credits, int workload, int courseId, int teacherId)
    {
        this.SubjectId = id;
        this.SubjectName = name;
        this.Credits = credits;
        this.Workload = workload;
        this.CourseId = courseId;
        this.TeacherId = teacherId;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }

    /// <summary>
    /// Initializes a new instance of the Subject class with the specified name, credits, workload, course identifier,
    /// and teacher identifier.
    /// </summary>
    /// <param name="name">The name of the subject. Cannot be null or empty.</param>
    /// <param name="credits">The number of credits assigned to the subject. Must be a non-negative integer.</param>
    /// <param name="workload">The total workload for the subject, typically measured in hours. Must be a non-negative integer.</param>
    /// <param name="courseId">The unique identifier of the course to which the subject belongs.</param>
    /// <param name="teacherId">The unique identifier of the teacher responsible for the subject.</param>
    public Subject(string name, int credits, int workload, int courseId, int teacherId)
    {
        this.SubjectName = name;
        this.Credits = credits;
        this.Workload = workload;
        this.CourseId = courseId;
        this.TeacherId = teacherId;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }

    /// <summary>
    /// Initializes a new instance of the Subject class with the specified name, course identifier, and teacher
    /// identifier.
    /// </summary>
    /// <param name="name">The name of the subject. Cannot be null or empty.</param>
    /// <param name="courseId">The unique identifier of the course to which the subject belongs.</param>
    /// <param name="teacherId">The unique identifier of the teacher assigned to the subject.</param>
    public Subject(string name, int courseId, int teacherId)
    {
        this.SubjectName = name;
        this.CourseId = courseId;
        this.TeacherId = teacherId;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }
}


namespace MiniProjecto02.Models;

internal class Course
{
    public int CourseId { get; init; }
    public string CourseName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int? Duration { get; set; }
    public DateTime? CreatedAt { get; init; }
    public DateTime? UpdatedAt { get; set; }

    /// <summary>
    /// Initializes a new instance of the Course class with the specified identifier, name, description, and duration.
    /// </summary>
    /// <param name="id">The unique identifier for the course.</param>
    /// <param name="name">The name of the course. Cannot be null or empty.</param>
    /// <param name="description">A brief description of the course. Cannot be null.</param>
    /// <param name="duration">The duration of the course, in hours. Must be a non-negative integer.</param>
    public Course(int id, string name, string description, int duration)
    {
        this.CourseId = id;
        this.CourseName = name;
        this.Description = description;
        this.Duration = duration;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }

    /// <summary>
    /// Initializes a new instance of the Course class with the specified name, description, and duration.
    /// </summary>
    /// <param name="name">The name of the course. Cannot be null or empty.</param>
    /// <param name="description">A brief description of the course. Cannot be null.</param>
    /// <param name="duration">The duration of the course, in days. Must be a positive integer.</param>
    public Course(string name, string description, int duration)
    {
        this.CourseName = name;
        this.Description = description;
        this.Duration = duration;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }

    /// <summary>
    /// Initializes a new instance of the Course class with the specified course name.
    /// </summary>
    /// <param name="name">The name of the course. Cannot be null or empty.</param>
    public Course(string name)
    {
        this.CourseName = name;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }
}

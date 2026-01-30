namespace MiniProjecto02.Models;

internal class Classroom
{
    public int ClassroomId { get; init; }
    public string ClassroomName { get; set; } = string.Empty;
    public int? Capacity { get; set; }
    public DateTime? CreatedAt { get; init; }
    public DateTime? UpdatedAt { get; set; }

    /// <summary>
    /// Initializes a new instance of the Classroom class with the specified identifier, name, and capacity.
    /// </summary>
    /// <param name="id">The unique identifier for the classroom.</param>
    /// <param name="name">The name of the classroom. Cannot be null or empty.</param>
    /// <param name="capacity">The maximum number of students that the classroom can accommodate. Must be greater than zero.</param>
    public Classroom(int id, string name, int capacity)
    {
        this.ClassroomId = id;
        this.ClassroomName = name;
        this.Capacity = capacity;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }

    /// <summary>
    /// Initializes a new instance of the Classroom class with the specified name and capacity.
    /// </summary>
    /// <param name="name">The name of the classroom. Cannot be null or empty.</param>
    /// <param name="capacity">The maximum number of students that the classroom can accommodate. Must be greater than zero.</param>
    public Classroom(string name, int capacity)
    {
        this.ClassroomName = name;
        this.Capacity = capacity;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }

    /// <summary>
    /// Initializes a new instance of the Classroom class with the specified name.
    /// </summary>
    /// <param name="name">The name to assign to the classroom. Cannot be null or empty.</param>
    public Classroom(string name)
    {
        this.ClassroomName = name;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }
}

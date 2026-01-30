namespace MiniProjecto02.Models;

internal class Class
{
    public int ClassId { get; init; }
    public int ClassroomId { get; set; }
    public int TeacherId { get; set; }
    public int SubjectId { get; set; }
    public DateTime? CreatedAt { get; init; }
    public DateTime? UpdatedAt { get; set; }
    
    /// <summary>
    /// Initializes a new instance of the Class class with the specified identifiers for the class, classroom, teacher,
    /// and subject.
    /// </summary>
    /// <param name="id">The unique identifier for the class.</param>
    /// <param name="classroomId">The identifier of the classroom where the class is held.</param>
    /// <param name="teacherId">The identifier of the teacher assigned to the class.</param>
    /// <param name="subjectId">The identifier of the subject taught in the class.</param>
    public Class(int id, int classroomId, int teacherId, int subjectId)
    {
        this.ClassId = id;
        this.ClassroomId = classroomId;
        this.TeacherId = teacherId;
        this.SubjectId = subjectId;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }

    /// <summary>
    /// Initializes a new instance of the Class class with the specified classroom, teacher, and subject identifiers.
    /// </summary>
    /// <param name="classroomId">The unique identifier of the classroom associated with this class.</param>
    /// <param name="teacherId">The unique identifier of the teacher assigned to this class.</param>
    /// <param name="subjectId">The unique identifier of the subject taught in this class.</param>
    public Class(int classroomId, int teacherId, int subjectId)
    {
        this.ClassroomId = classroomId;
        this.TeacherId = teacherId;
        this.SubjectId = subjectId;
        this.CreatedAt = DateTime.Now;
        this.UpdatedAt = DateTime.Now;
    }
}

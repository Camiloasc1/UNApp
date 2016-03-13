package unapp

class Course extends Commentable
{
    int code
    String name
    int credits
    String description
    String contents
    static belongsTo = Teacher
    static hasMany = [teachers: Teacher, evaluations: CourseEvaluation]
    static constraints = {
    }
}

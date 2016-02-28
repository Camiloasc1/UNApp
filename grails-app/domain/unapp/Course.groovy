package unapp

class Course extends Commentable
{
    String name
    static belongsTo = Teacher
    static hasMany = [teachers: Teacher, evaluations: CourseEvaluation]
    static constraints = {
    }
}

package unapp

class Course extends Commentable
{
    String code
    String name
    int credits
    String description
    String contents
    static belongsTo = Teacher
    static hasMany = [teachers: Teacher, evaluations: CourseEvaluation]

    static constraints = {
        teachers nullable: true
        evaluations nullable: true
        description nullable: true
        contents nullable: true
    }

    String toString(){
        return code+" "+name+" "+credits
    }

}

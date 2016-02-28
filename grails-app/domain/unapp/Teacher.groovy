package unapp

class Teacher extends Commentable
{
    String name
    String username // the institutional username
    String url
    static hasMany = [courses: Course, evaluations: TeacherEvaluation]
    static constraints = {
    }

    String getEmail()
    {
        return "${username}@unal.edu.co"
    }
}

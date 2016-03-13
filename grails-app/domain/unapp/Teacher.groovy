package unapp

class Teacher extends Commentable
{
    String name
    String username // the institutional username
    static hasMany = [courses: Course, evaluations: TeacherEvaluation]
    static constraints = {
    }

    String getEmail()
    {
        return "${username}@unal.edu.co"
    }

    String getURL()
    {
        return "http://www.docentes.unal.edu.co/${username}/"
    }
}

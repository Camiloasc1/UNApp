package unapp

class TeacherEvaluation
{
    User author
    int overall
    int knowledge
    int explanation
    int punctuality
    int gradeMethod
    def Teacher teacher
    static belongsTo = [Teacher]
    static constraints = {
    }
}

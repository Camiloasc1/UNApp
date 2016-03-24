package unapp

class CourseEvaluation
{
    User author
    int overall
    int workEffort
    def Course course
    static belongsTo = [Course]
    static constraints = {
    }
}

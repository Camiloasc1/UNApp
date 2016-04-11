package unapp

class Teacher {
    String name
    String username // the institutional username
    static belongsTo = [location: Location]
    static hasMany = [comments: Comment, courses: Course, evaluations: TeacherEvaluation]

    static constraints = {
        comments nullable: false
        username nullable: false

        location nullable: false

        comments nullable: true
        courses nullable: true
        evaluations nullable: true

    }

    String getEmail() {
        return "${username}@unal.edu.co"
    }

    String getURL() {
        return "http://www.docentes.unal.edu.co/${username}/"
    }

    String toString() {
        return name
    }

}

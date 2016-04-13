package unapp

class Teacher {
    String name
    String username // the institutional username
    static belongsTo = [location: Location]
    static hasMany = [comments: Comment, courses: Course, evaluations: TeacherEvaluation]

    static constraints = {
        name nullable: false
        username nullable: false

        location nullable: true

        comments nullable: true
        courses nullable: true
        evaluations nullable: true
    }

    //static embedded = ['comments']

    String getEmail() {
        return "${username}@unal.edu.co"
    }

    String getURL() {
        return "http://www.docentes.unal.edu.co/${username}/"
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "name='" + name + '\'' +
                ", username='" + username + '\'' +
                ", location=" + location +
                '}';
    }
}

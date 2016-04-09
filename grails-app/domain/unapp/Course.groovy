package unapp

class Course {
    int internalcode
    int code
    String name
    String typology
    int credits
    String description
    String contents
    Location location
    static belongsTo = Teacher
    static hasMany = [comments: Comment, teachers: Teacher, evaluations: CourseEvaluation]

    static constraints = {
        internalcode nullable: false, min: 0
        code nullable: false, min: 0
        name nullable: false
        typology nullable: false
        credits nullable: false, min: 0
        description nullable: true
        contents nullable: true
        location nullable: false

        comments nullable: true
        teachers nullable: true
        evaluations nullable: true
    }

    @Override
    public String toString() {
        return "Course{" +
                "code=" + code +
                ", name='" + name + '\'' +
                ", typology='" + typology + '\'' +
                ", credits=" + credits +
                ", location='" + location + '\'' +
                '}';
    }
}

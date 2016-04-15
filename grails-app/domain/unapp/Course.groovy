package unapp

class Course {
    int internalCode
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
        internalCode nullable: false, min: 0
        code nullable: false, min: 0
        name nullable: false, blank: false
        typology nullable: false, blank: false
        credits nullable: false, min: 0
        description nullable: true
        contents nullable: true
        location nullable: true

        teachers nullable: true

        comments nullable: true
        evaluations nullable: true
    }

    static mapping = {
        code index:true
        name index:true
    }

    //static embedded = ['comments']

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

package unapp

class Degree {
    int code
    String name
    String faculty
    String type
    static belongsTo = [location: Location]
    static hasMany = [courses: Course]

    static constraints = {
        code nullable: false
        name nullable: false
        faculty nullable: false
        type nullable: false
        location nullable: true
        courses nullable: true
    }

    @Override
    public String toString() {
        return "Degree{" +
                "code=" + code +
                ", name='" + name + '\'' +
                ", faculty='" + faculty + '\'' +
                ", type='" + type + '\'' +
                ", location=" + location +
                '}';
    }
}

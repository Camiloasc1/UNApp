package unapp

class Degree {
    int code
    String name
    String type
    static belongsTo = [location:Location]
    static hasMany = [courses:Course]
    static constraints = {
    }
}

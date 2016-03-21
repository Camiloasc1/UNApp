package unapp

class Course extends Commentable
{
    String code
    String name
    String typology
    int credits
    String description
    String contents
    String location
    static belongsTo = Teacher
    static hasMany = [teachers: Teacher, evaluations: CourseEvaluation]

    static constraints = {
        teachers nullable: true
        evaluations nullable: true
        description nullable: true
        contents nullable: true
        location nullable: true
        typology nullable: true

        description display:false
        contents display:false
        name display:true
    }

    /*static mapping = {
        id column: 'code', type: 'String' insert:false update:false
    }*/

    String toString(){
        return code+" "+name+" "+credits+" "+location
    }

}

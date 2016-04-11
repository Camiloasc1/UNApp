package unapp

class Comment
{
    User author
    String body
    int positiveVotes
    int negativeVotes
    Date date

    static belongsTo = [teacher: Teacher, course: Course]
    static hasMany=[likes:Votes]

    static constraints = {
        teacher nullable:  true
        course nullable: true
        likes nullable: true
        author nullable: false
        body nullable: false
        positiveVotes nullable: false, min: 0
        negativeVotes nullable: false, min: 0
    }
}
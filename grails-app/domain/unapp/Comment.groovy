package unapp

class Comment {
    User author
    String body
    int positiveVotes
    int negativeVotes

    static belongsTo = [teacher: Teacher, course: Course]
    static constraints = {
        author nullable: false
        body nullable: false
        positiveVotes nullable: false, min: 0
        negativeVotes nullable: false, min: 0
    }
}
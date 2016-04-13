package unapp

class Comment {
    User author
    String body
    int positiveVotes = 0
    int negativeVotes = 0
    Date date
    static belongsTo = [teacher: Teacher, course: Course]
    static hasMany = [votes: Vote]

    static constraints = {
        author nullable: false
        body nullable: false
        positiveVotes nullable: false, min: 0
        negativeVotes nullable: false, min: 0
        date nullable: false

        teacher nullable: true
        course nullable: true

        votes nullable: true
    }

    //static embedded = ['votes']
}
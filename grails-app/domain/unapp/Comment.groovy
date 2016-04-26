package unapp

class Comment {
    User author
    String body
    Date date
    static belongsTo = [teacher: Teacher, course: Course]
    static hasMany = [votes: Vote]

    static constraints = {
        author nullable: false
        body nullable: false
        date nullable: false

        teacher nullable: true
        course nullable: true

        votes nullable: true
    }

    def countPositiveVotes() {
        if (!votes) return 0
        return votes.count { vote -> vote.value == 1 }
    }

    def countNegativeVotes() {
        if (!votes) return 0
        return votes.count { vote -> vote.value == -1 }
    }
}
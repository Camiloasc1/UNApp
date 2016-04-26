package unapp

class Vote {

    int value // -1: negative, 1: positive

    static belongsTo = [author: User, comment: Comment]

    static constraints = {
        value nullable: false

        author nullable: false
        comment nullable: false
    }
}
package unapp

class Vote {

    boolean value // False: negative, True: positive

    static belongsTo = [author: User, comment: Comment]

    static constraints = {
        value nullable: false

        author nullable: false
        comment nullable: true
    }
}
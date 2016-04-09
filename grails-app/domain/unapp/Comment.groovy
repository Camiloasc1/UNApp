package unapp

class Comment
{
    User author
    String body
    int positiveVotes
    int negativeVotes
    def Teacher teacher
    def Course course
    Date date

    //static belongsTo = [Commentable]
    static constraints = {
        teacher nullable:  true
        course nullable: true
    }
}
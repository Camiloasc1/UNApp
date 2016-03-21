package unapp

class Comment
{
    User author
    String body
    int positiveVotes
    int negativeVotes
    def Commentable commentable

    static belongsTo = [Commentable]
    static constraints = {
    }
}
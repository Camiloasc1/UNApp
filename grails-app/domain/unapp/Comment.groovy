package unapp

class Comment
{
    User author
    String body
    int positiveVotes = 0
    int negativeVotes = 0
    def Commentable commentable

    static belongsTo = [Commentable]
    static constraints = {

    }
}
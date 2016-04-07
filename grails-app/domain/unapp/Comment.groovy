package unapp

class Comment
{
    User author
    String body
    int positiveVotes
    int negativeVotes
    def Teacher teacher
    def Course course

    //static belongsTo = [Commentable]
    static constraints = {
    }
}
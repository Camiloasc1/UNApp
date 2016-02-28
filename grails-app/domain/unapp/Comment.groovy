package unapp

class Comment
{
    User author
    String title
    String body
    def Commentable commentable
    static belongsTo = [Commentable]
    static constraints = {
    }
}

package unapp

class Comment
{
    def Commentable commentable
    static belongsTo = [Commentable]
    static constraints = {
    }
}

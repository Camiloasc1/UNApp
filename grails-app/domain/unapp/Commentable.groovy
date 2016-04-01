package unapp

class Commentable
{
    static hasMany = [comments: Comment]
    static constraints = {
        comments nullable: true
    }
    static mapping = {
        tablePerHierarchy false // One table per each child class
    }
}

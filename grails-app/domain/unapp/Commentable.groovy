package unapp

class Commentable
{
    static hasMany = [comments: Comment]
    static constraints = {
    }
    static mapping = {
        tablePerHierarchy false // One table per each child class
    }
}

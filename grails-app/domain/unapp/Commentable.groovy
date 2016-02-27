package unapp

class Commentable
{
    static hasMany = [Comments: Comment]
    static constraints = {
    }
    static mapping = {
        tablePerHierarchy false // One table per each child class
    }
}

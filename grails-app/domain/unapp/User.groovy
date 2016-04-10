package unapp

class User
{
    String googleID // sub field is an unique identifier
    String name
    String email
    int positiveVotes = 0
    int negativeVotes = 0
    boolean isAdmin = false
    static hasMany=[likes:Votes]

    static constraints = {
        likes nullable: true
    }

    String toString(){
        return name
    }
}


package unapp

class User
{
    String googleID // sub field is an unique identifier
    String name
    String email
    int positiveVotes
    int negativeVotes
    boolean isAdmin

    static constraints = {
        positiveVotes nullable: true
        negativeVotes nullable: true
        isAdmin nullable: true
    }

    static mapping = {
        positiveVotes defaultValue: 0
        negativeVotes defaultValue: 0
        isAdmin defaultValue:false
    }

    String toString(){
        return name
    }
}


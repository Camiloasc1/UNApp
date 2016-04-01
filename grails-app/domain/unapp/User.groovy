package unapp

class User
{
    String googleID // sub field is an unique identifier
    String name
    String email
    int positiveVotes
    int negativeVotes
    boolean isAdmin

    String toString(){
        return name
    }
}


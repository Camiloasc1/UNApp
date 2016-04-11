package unapp

class User {
    String googleID // sub field is an unique identifier
    String name
    String email
    int positiveVotes = 0
    int negativeVotes = 0
    boolean isAdmin = false
    static hasMany = [votes: Vote]

    static constraints = {
        googleID nullable: false
        name nullable: false
        email nullable: false
        positiveVotes nullable: false, min: 0
        negativeVotes nullable: false, min: 0
        isAdmin nullable: false

        votes nullable: true
    }

    //static embedded = ['votes']

    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", googleID='" + googleID + '\'' +
                ", isAdmin=" + isAdmin +
                '}';
    }
}


package unapp

class Teacher extends Commentable
{
    String name
    String username // the institutional username
    static constraints = {
    }

    String getEmail()
    {
        return "${username}@unal.edu.co"
    }
}

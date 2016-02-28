package unapp

class Teacher extends Commentable
{
    String name
    String username // the institutional username
    String url
    static constraints = {
    }

    String getEmail()
    {
        return "${username}@unal.edu.co"
    }
}

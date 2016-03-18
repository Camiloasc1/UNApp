package unapp

class Location {

    String name
    String url

    public String toString(){
        return name
    }

    static constraints = {

        name blank: false, unique: true
        url blank: false
    }
}
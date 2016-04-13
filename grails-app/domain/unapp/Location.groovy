package unapp

class Location {
    String name
    String url

    static constraints = {
        name nullable: false, blank: false, unique: true
        url nullable: false, blank: false
    }

    @Override
    public String toString() {
        return "Location{" +
                "name='" + name + '\'' +
                ", url='" + url + '\'' +
                '}';
    }
}
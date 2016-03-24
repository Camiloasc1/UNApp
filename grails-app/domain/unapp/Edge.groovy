package unapp

class Edge {

    Course prev
    Course next
    static belongsTo = [degree:Degree]

    static constraints = {
    }

    @Override
    String toString() {
        return prev.toString() + " " + next.toString() + " " + degree.toString()
    }
}

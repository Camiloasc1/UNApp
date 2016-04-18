package unapp

class ProfessorController {

    static allowedMethods = [save: "POST", read: "GET", update: "PUT", delete: "DELETE"]

    def index() {
        def teacher = Teacher.get(params.id)
        render view: "index", model: [t: teacher]
    }
}

package unapp

class SubjectController {

    static allowedMethods = [save: "POST", read: "GET", update: "PUT", delete: "DELETE"]

    def index() {
        def course = Course.get( params.id )
        render view: "index", model: [ c: course ]
    }
}

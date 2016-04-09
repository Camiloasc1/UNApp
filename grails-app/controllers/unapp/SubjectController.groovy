package unapp

class SubjectController {

    static allowedMethods = [save: "POST", read: "GET", update: "PUT", delete: "DELETE"]

    def index() {
        def course = Course.get( params.id )
        render view: "index", model: [ c: course ]
    }

    def comment(){

        def user = session["user"]

        if(user == null){
            render "ingresa para comentar"
            return
        }

        def course = Course.get( params.id )

        def teacher = null //TODO

        Comment comment = new Comment( body:params.body , course: course ,teacher: teacher ,author: user )
        comment.save()

        render view: "index", model: [ c: course ]
        //render "Commentario guardado"//redirect action: "index" , params: params
    }

}

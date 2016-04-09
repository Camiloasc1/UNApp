package unapp

class SubjectController {

    static allowedMethods = [save: "POST", read: "GET", update: "PUT", delete: "DELETE"]

    def index() {
        def course = Course.get( params.id )
        def comentarios = Comment.findAllByCourse(course)
        comentarios.sort{a,b-> b.date<=>a.date}
        render view: "index", model: [ c: course, comments: comentarios ]
    }

    def comment(){

        def user = session["user"]

        if(user == null){
            render "ingresa para comentar"
            return
        }

        def course = Course.get( params.id )

        def teacher = null //TODO

        Comment comment = new Comment( body:params.body , course: course ,teacher: teacher ,author: user, date: new Date() )
        comment.save()

        def comentarios = Comment.findAllByCourse(course)
        comentarios.sort{a,b-> b.date<=>a.date}


        [comments: comentarios]
        //render view: "index", model: [ c: course ]
        //render "Commentario guardado"//redirect action: "index" , params: params
    }

}

package unapp

class SubjectController {

    static allowedMethods = [save: "POST", read: "GET", update: "PUT", delete: "DELETE"]

    def index() {
        def course = Course.get( params.id )
        render view: "index", model: [ c: course ]
    }

    def comment(){

        //Mock user
        def user = User.list().get(0)

        def course = Course.get( params.id )
        Comment comment = new Comment( body:params.body , commentable: course , author: user )
        comment.save()

        render "Commentario guardado"//redirect action: "index" , params: params
    }

}

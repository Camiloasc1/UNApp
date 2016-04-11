package unapp



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CommentableController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Commentable.list(params), model:[commentableInstanceCount: Commentable.count()]
    }

    def show(Commentable commentableInstance) {
        respond commentableInstance
    }

    def create() {
        respond new Commentable(params)
    }

    @Transactional
    def save(Commentable commentableInstance) {
        if (commentableInstance == null) {
            notFound()
            return
        }

        if (commentableInstance.hasErrors()) {
            respond commentableInstance.errors, view:'create'
            return
        }

        commentableInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'commentable.label', default: 'Commentable'), commentableInstance.id])
                redirect commentableInstance
            }
            '*' { respond commentableInstance, [status: CREATED] }
        }
    }

    def edit(Commentable commentableInstance) {
        respond commentableInstance
    }

    @Transactional
    def update(Commentable commentableInstance) {
        if (commentableInstance == null) {
            notFound()
            return
        }

        if (commentableInstance.hasErrors()) {
            respond commentableInstance.errors, view:'edit'
            return
        }

        commentableInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Commentable.label', default: 'Commentable'), commentableInstance.id])
                redirect commentableInstance
            }
            '*'{ respond commentableInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Commentable commentableInstance) {

        if (commentableInstance == null) {
            notFound()
            return
        }

        commentableInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Commentable.label', default: 'Commentable'), commentableInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'commentable.label', default: 'Commentable'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

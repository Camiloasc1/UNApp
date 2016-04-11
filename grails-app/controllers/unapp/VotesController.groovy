package unapp



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class VotesController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Votes.list(params), model:[votesInstanceCount: Votes.count()]
    }

    def show(Votes votesInstance) {
        respond votesInstance
    }

    def create() {
        respond new Votes(params)
    }

    @Transactional
    def save(Votes votesInstance) {
        if (votesInstance == null) {
            notFound()
            return
        }

        if (votesInstance.hasErrors()) {
            respond votesInstance.errors, view:'create'
            return
        }

        votesInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'votes.label', default: 'Votes'), votesInstance.id])
                redirect votesInstance
            }
            '*' { respond votesInstance, [status: CREATED] }
        }
    }

    def edit(Votes votesInstance) {
        respond votesInstance
    }

    @Transactional
    def update(Votes votesInstance) {
        if (votesInstance == null) {
            notFound()
            return
        }

        if (votesInstance.hasErrors()) {
            respond votesInstance.errors, view:'edit'
            return
        }

        votesInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Votes.label', default: 'Votes'), votesInstance.id])
                redirect votesInstance
            }
            '*'{ respond votesInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Votes votesInstance) {

        if (votesInstance == null) {
            notFound()
            return
        }

        votesInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Votes.label', default: 'Votes'), votesInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'votes.label', default: 'Votes'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

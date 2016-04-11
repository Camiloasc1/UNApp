package unapp



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EdgeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Edge.list(params), model:[edgeInstanceCount: Edge.count()]
    }

    def show(Edge edgeInstance) {
        respond edgeInstance
    }

    def create() {
        respond new Edge(params)
    }

    @Transactional
    def save(Edge edgeInstance) {
        if (edgeInstance == null) {
            notFound()
            return
        }

        if (edgeInstance.hasErrors()) {
            respond edgeInstance.errors, view:'create'
            return
        }

        edgeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'edge.label', default: 'Edge'), edgeInstance.id])
                redirect edgeInstance
            }
            '*' { respond edgeInstance, [status: CREATED] }
        }
    }

    def edit(Edge edgeInstance) {
        respond edgeInstance
    }

    @Transactional
    def update(Edge edgeInstance) {
        if (edgeInstance == null) {
            notFound()
            return
        }

        if (edgeInstance.hasErrors()) {
            respond edgeInstance.errors, view:'edit'
            return
        }

        edgeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Edge.label', default: 'Edge'), edgeInstance.id])
                redirect edgeInstance
            }
            '*'{ respond edgeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Edge edgeInstance) {

        if (edgeInstance == null) {
            notFound()
            return
        }

        edgeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Edge.label', default: 'Edge'), edgeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'edge.label', default: 'Edge'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

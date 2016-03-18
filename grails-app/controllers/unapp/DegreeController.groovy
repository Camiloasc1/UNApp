package unapp


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DegreeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /*def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Degree.list(params), model: [degreeInstanceCount: Degree.count()]
    }*/

    static scaffold = true

    def show(Degree degreeInstance) {
        respond degreeInstance
    }

    def create() {
        respond new Degree(params)
    }

    @Transactional
    def save(Degree degreeInstance) {
        if (degreeInstance == null) {
            notFound()
            return
        }

        if (degreeInstance.hasErrors()) {
            respond degreeInstance.errors, view: 'create'
            return
        }

        degreeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'degree.label', default: 'Degree'), degreeInstance.id])
                redirect degreeInstance
            }
            '*' { respond degreeInstance, [status: CREATED] }
        }
    }

    def edit(Degree degreeInstance) {
        respond degreeInstance
    }

    @Transactional
    def update(Degree degreeInstance) {
        if (degreeInstance == null) {
            notFound()
            return
        }

        if (degreeInstance.hasErrors()) {
            respond degreeInstance.errors, view: 'edit'
            return
        }

        degreeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Degree.label', default: 'Degree'), degreeInstance.id])
                redirect degreeInstance
            }
            '*' { respond degreeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Degree degreeInstance) {

        if (degreeInstance == null) {
            notFound()
            return
        }

        degreeInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Degree.label', default: 'Degree'), degreeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'degree.label', default: 'Degree'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

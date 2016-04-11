package unapp



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CourseEvaluationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CourseEvaluation.list(params), model:[courseEvaluationInstanceCount: CourseEvaluation.count()]
    }

    def show(CourseEvaluation courseEvaluationInstance) {
        respond courseEvaluationInstance
    }

    def create() {
        respond new CourseEvaluation(params)
    }

    @Transactional
    def save(CourseEvaluation courseEvaluationInstance) {
        if (courseEvaluationInstance == null) {
            notFound()
            return
        }

        if (courseEvaluationInstance.hasErrors()) {
            respond courseEvaluationInstance.errors, view:'create'
            return
        }

        courseEvaluationInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'courseEvaluation.label', default: 'CourseEvaluation'), courseEvaluationInstance.id])
                redirect courseEvaluationInstance
            }
            '*' { respond courseEvaluationInstance, [status: CREATED] }
        }
    }

    def edit(CourseEvaluation courseEvaluationInstance) {
        respond courseEvaluationInstance
    }

    @Transactional
    def update(CourseEvaluation courseEvaluationInstance) {
        if (courseEvaluationInstance == null) {
            notFound()
            return
        }

        if (courseEvaluationInstance.hasErrors()) {
            respond courseEvaluationInstance.errors, view:'edit'
            return
        }

        courseEvaluationInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CourseEvaluation.label', default: 'CourseEvaluation'), courseEvaluationInstance.id])
                redirect courseEvaluationInstance
            }
            '*'{ respond courseEvaluationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CourseEvaluation courseEvaluationInstance) {

        if (courseEvaluationInstance == null) {
            notFound()
            return
        }

        courseEvaluationInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CourseEvaluation.label', default: 'CourseEvaluation'), courseEvaluationInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'courseEvaluation.label', default: 'CourseEvaluation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

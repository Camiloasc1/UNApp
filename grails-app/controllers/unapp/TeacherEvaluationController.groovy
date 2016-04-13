package unapp



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TeacherEvaluationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TeacherEvaluation.list(params), model:[teacherEvaluationInstanceCount: TeacherEvaluation.count()]
    }

    def show(TeacherEvaluation teacherEvaluationInstance) {
        respond teacherEvaluationInstance
    }

    def create() {
        respond new TeacherEvaluation(params)
    }

    @Transactional
    def save(TeacherEvaluation teacherEvaluationInstance) {
        if (teacherEvaluationInstance == null) {
            notFound()
            return
        }

        if (teacherEvaluationInstance.hasErrors()) {
            respond teacherEvaluationInstance.errors, view:'create'
            return
        }

        teacherEvaluationInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'teacherEvaluation.label', default: 'TeacherEvaluation'), teacherEvaluationInstance.id])
                redirect teacherEvaluationInstance
            }
            '*' { respond teacherEvaluationInstance, [status: CREATED] }
        }
    }

    def edit(TeacherEvaluation teacherEvaluationInstance) {
        respond teacherEvaluationInstance
    }

    @Transactional
    def update(TeacherEvaluation teacherEvaluationInstance) {
        if (teacherEvaluationInstance == null) {
            notFound()
            return
        }

        if (teacherEvaluationInstance.hasErrors()) {
            respond teacherEvaluationInstance.errors, view:'edit'
            return
        }

        teacherEvaluationInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TeacherEvaluation.label', default: 'TeacherEvaluation'), teacherEvaluationInstance.id])
                redirect teacherEvaluationInstance
            }
            '*'{ respond teacherEvaluationInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TeacherEvaluation teacherEvaluationInstance) {

        if (teacherEvaluationInstance == null) {
            notFound()
            return
        }

        teacherEvaluationInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TeacherEvaluation.label', default: 'TeacherEvaluation'), teacherEvaluationInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'teacherEvaluation.label', default: 'TeacherEvaluation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

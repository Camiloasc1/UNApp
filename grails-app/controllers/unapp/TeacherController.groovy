package unapp


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TeacherController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        def result = Location.list().collect { l ->
            [name    : l.name,
             teachers: Teacher.findAllByLocation(l).collect { c ->
                 [id: c.id, name: c.name, username: c.username]
             }
            ]
        }

        respond result, model: [result: result]
    }

    def search(String query) {
        def result = Teacher.findAllByNameIlike("%" + query + "%").collect { c ->
            [id: c.id, name: c.name, username: c.username]
        }

        respond result, model: [result: result]
    }

    def show(Teacher teacherInstance) {
        respond teacherInstance
    }

    def create() {
        respond new Teacher(params)
    }

    @Transactional
    def save(Teacher teacherInstance) {
        if (teacherInstance == null) {
            notFound()
            return
        }

        if (teacherInstance.hasErrors()) {
            respond teacherInstance.errors, view: 'create'
            return
        }

        teacherInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'teacher.label', default: 'Teacher'), teacherInstance.id])
                redirect teacherInstance
            }
            '*' { respond teacherInstance, [status: CREATED] }
        }
    }

    def edit(Teacher teacherInstance) {
        respond teacherInstance
    }

    @Transactional
    def update(Teacher teacherInstance) {
        if (teacherInstance == null) {
            notFound()
            return
        }

        if (teacherInstance.hasErrors()) {
            respond teacherInstance.errors, view: 'edit'
            return
        }

        teacherInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Teacher.label', default: 'Teacher'), teacherInstance.id])
                redirect teacherInstance
            }
            '*' { respond teacherInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Teacher teacherInstance) {

        if (teacherInstance == null) {
            notFound()
            return
        }

        teacherInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Teacher.label', default: 'Teacher'), teacherInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'teacher.label', default: 'Teacher'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

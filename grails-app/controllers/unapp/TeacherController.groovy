package unapp

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TeacherController {

    static allowedMethods = [index: "GET", show: "GET", comments: "GET", save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        def result = Location.list().collect { l ->
            [name    : l.name,
             teachers: Teacher.findAllByLocation(l, [sort: "name", order: "asc"]).collect { c ->
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

    def show(int id) {
        def result = Teacher.get(id).collect { teacher ->
            [id         : teacher.id,
             name       : teacher.name,
             username   : teacher.username,
             information: teacher.information,
             location   : teacher.location.name,
             URL        : teacher.getURL(),
             courses    : teacher.courses.collect { course ->
                 [id  : course.id,
                  name: course.name,
                  code: course.code
                 ]
             }
            ]
        }[0]

        respond result, model: [result: result]
    }

    def comments(int id, int max, int offset) {
        def result = Comment.findAllByTeacher(Teacher.get(id), [sort: "date", order: "desc", max: max, offset: offset]).collect { comment ->
            [id           : comment.id,
             author       : comment.author.name,
             picture      : comment.author.picture,
             body         : comment.body,
             date         : comment.date.format("yyyy-MM-dd 'a las' HH:mm"),
             voted        : Vote.findByAuthorAndComment(session.user, comment)?.value ?: 0,
             positiveVotes: comment.countPositiveVotes(),
             negativeVotes: comment.countNegativeVotes(),
             course       : [id: comment.course?.id, name: comment.course?.name],
             teacher      : [id: comment.teacher?.id, name: comment.teacher?.name]
            ]
        }

        respond result, model: [result: result]
    }

    def create() {
        respond new Teacher(params)
    }

    def getTeacherForm( int id ){
        def teacher = Teacher.findById(id)
        def result = [
                teacherInstance: teacher,
                courses: teacher.courses.collect { course ->
                    [
                            id: course.id,
                            name: course.name
                    ]
                },
                locations     : Location.findAll().collect { location ->
                    [
                            id: location.id,
                            location: location.name,
                            selected: ( teacher.location.id == location.id  )? 1 : 0
                    ]
                }
        ]
        respond result, model: [result: result]
    }

    def updateTeacher() {
        def id = request.JSON.id.toInteger()
        def location = request.JSON.location.toInteger()
        def name = request.JSON.name
        def username = request.JSON.username
        def info = request.JSON.info
        def links = request.JSON.links
        def courses = request.JSON.courses

        if( ( id != null && id > 0 )&& ( location != null && location > 0 ) && ( name != null && name != "" ) && ( username != null && username != "" ) ) {

            def teacher = Teacher.findById(id)

            teacher.location = Location.findById(location)
            teacher.name = name
            teacher.username = username
            teacher.information = info
            //teacher.links = links

            def courses_array = courses.collect {
                Course.findById(it.id)
            }

            teacher.courses = courses_array
            if (teacher.save(flush: true))
                render 1
            else
                render 0
        }else
            render 0
    }

    def courseSearch(String course) {
        def result = Course.findAllByNameIlike("%" + course + "%", [max: 5]).collect { cour ->
            [
                    id  : cour.id,
                    name: cour.name
            ]
        }
        render result as JSON
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

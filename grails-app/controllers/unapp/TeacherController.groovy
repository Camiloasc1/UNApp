package unapp

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON

@Transactional(readOnly = true)
class TeacherController {

    static allowedMethods = [index: "GET", show: "GET", comments: "GET", save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        def result = Location.list().collect { l ->
            [name    : l.name,
             teachers: Teacher.findAllByLocation(l, [sort: "name", order: "asc"]).collect { c ->
                 [id: c.id, name: c.name, email: c.getEmail()]
             }
            ]
        }

        respond result, model: [result: result]
    }

    def search(String query) {
        def result = Teacher.findAllByNameIlike("%" + query + "%").collect { c ->
            [id: c.id, name: c.name, email: c.getEmail()]
        }

        respond result, model: [result: result]
    }

    def show(int id) {
        def result = Teacher.get(id).collect { teacher ->
            [id         : teacher.id,
             name       : teacher.name,
             email      : teacher.getEmail(),
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

    def erase(){
        render template: "erase"
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

    def starMedian(int id) {
        def user = session.user
        def star = 0
        if (user) {
            star = TeacherEvaluation.findByTeacherAndAuthor(Teacher.findById(id), user)
            if (star)
                star = star.overall
            else
                star = 0
        }

        def votes = TeacherEvaluation.findAllByTeacher(Teacher.findById(id))
        def median = -1
        if (votes.size() != 0)
            median = Math.floor((votes.sum { it.overall }) / votes.size())


        def result = [
                median: median,
                stars : star
        ]
        respond result, model: [result: result]
    }

    def starRate(int id, int vote) {
        def user = session.user
        if (!user) {
            return
        }

        def exists = TeacherEvaluation.findByTeacherAndAuthor(Teacher.findById(id), user)
        if (exists == null) {
            def rate = new TeacherEvaluation(
                    author: user,
                    overall: vote,
                    teacher: Teacher.findById(id)
            ).save(flush: true)
        } else {
            exists.overall = vote
            exists.save(flush: true)
        }

        def votes = TeacherEvaluation.findAllByTeacher(Teacher.findById(id))
        def median = 0
        if( votes.size() != 0 )
            median = Math.floor((votes.sum { it.overall }) / votes.size())

        def result = [
                median: median
        ]
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

        if( ( id.intValue() > 0 )&& ( location.intValue() > 0 ) && ( name != "" ) && ( username != "" ) ) {

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

    def createTeacher(){
        def location = request.JSON.location.toInteger()
        def name = request.JSON.name
        def username = request.JSON.username
        def info = request.JSON.info
        def links = request.JSON.links
        def courses = request.JSON.courses

        if( ( location.intValue() > 0 ) && ( name != "" ) && ( username != "" ) ) {
            def teacher = new Teacher()

            teacher.location = Location.findById(location)
            teacher.name = name
            teacher.username = username
            teacher.information = info
            //teacher.links = links

            if( courses.size() > 0 ) {
                def courses_array = courses.collect {
                    Course.findById(it.id)
                }

                teacher.courses = courses_array
            }

            if (teacher.save(flush: true))
                render 1
            else
                render 0
        }else render 0
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

    @Transactional
    def deleteAux(){
        def id = request.JSON.id
        def teacher = Teacher.findById(id)
        try{
            teacher.delete(failOnError:true, flush:true)
            render "true"
        }
        catch(e) {
            render "false"
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

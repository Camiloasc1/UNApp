package unapp


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON

@Transactional(readOnly = true)
class CourseController {

    static allowedMethods = [index: "GET", search: "GET", show: "GET", comments: "GET", commentsFiltered: "POST", save: "POST", update: "PUT", delete: "DELETE", updateCourse: "POST"]

    def index() {
        def result = Location.list().collect { l ->
            [name   : l.name,
             courses: Course.findAllByLocation(l, [sort: "name", order: "asc"]).collect { c ->
                 [id: c.id, code: c.code, name: c.name, credits: c.credits]
             }
            ]
        }

        respond result, model: [result: result]
    }

    def search(String query) {
        def result = Course.findAllByNameIlike("%" + query + "%").collect { c ->
            [id: c.id, code: c.code, name: c.name, credits: c.credits]
        }

        respond result, model: [result: result]
    }

    def show(int id) {
        def result = Course.get(id).collect { course ->
            [id         : course.id,
             code       : course.code,
             name       : course.name,
             credits    : course.credits,
             description: course.description,
             contents   : course.contents,
             location   : course.location.name,
             teachers   : course.teachers.collect { teacher ->
                 [id      : teacher.id,
                  name    : teacher.name,
                  username: teacher.username
                 ]
             }
            ]
        }[0]

        respond result, model: [result: result]
    }

    def comments(int id, int max, int offset) {
        def result = Comment.findAllByCourse(Course.get(id), [sort: "date", order: "desc", max: max, offset: offset]).collect { comment ->
            [id           : comment.id,
             author       : [id:comment.author?.id, name:  comment.author?.name],
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

    def commentsFiltered(){
        def id = request.JSON.id
        def max = request.JSON.max
        def offset = request.JSON.offset
        def filters = request.JSON.filters

        def criteria = Comment.createCriteria()
        def res = criteria.list{
            eq( "course", Course.get(id) )
            if( filters[0] != "" )
                like( "body", "%"+filters[0]+"%" )
            if( filters[3] != 0 ){
                if( filters[3] == 2 ){
                    Date yes = new Date(System.currentTimeMillis() - (24 * 60 * 60 * 1000L));
                    between("date", new Date(), yes)
                }else if( filters[3] == 3 ){
                    Date yes = new Date(System.currentTimeMillis() - (7 * 24 * 60 * 60 * 1000L));
                    between("date", new Date(), yes)
                }else if( filters[3] == 4 ){
                    Date yes = new Date(System.currentTimeMillis() - (4 * 7 * 24 * 60 * 60 * 1000L));
                    between("date", new Date(), yes)
                }else if( filters[3] == 5 ){
                    Date yes = new Date(System.currentTimeMillis() - (12 * 4 * 7 * 24 * 60 * 60 * 1000L));
                    between("date", new Date(), yes)
                }
            }
            order("date", "desc")
        }.collect { comment ->
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

        if( filters[1] == true )
            res = res.sort {  a,b -> b.positiveVotes <=> a.positiveVotes }
        else if( filters[1] == false )
            res = res.sort {  a,b -> b.negativeVotes <=> a.negativeVotes }

        def result = []
        if( filters[2] != [] ) {
            res.each { comment ->
                if( comment.teacher.id != null  ){
                    filters[2].each { idt ->
                        if( idt.toInteger() == comment.teacher.id ) {
                            result.push(comment)
                        }
                    }
                }
            }
        }else{
            result = res
        }

        respond result, model: [result: result]
    }

    def starMedian(int id) {
        def user = session.user
        def star = 0
        if (user) {
            star = CourseEvaluation.findByCourseAndAuthor(Course.findById(id), user)
            if (star)
                star = star.overall
            else
                star = 0
        }

        def votes = CourseEvaluation.findAllByCourse(Course.findById(id))
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

        def exists = CourseEvaluation.findByCourseAndAuthor(Course.findById(id), user)
        if (exists == null) {
            def rate = new CourseEvaluation(
                    author: user,
                    overall: vote,
                    course: Course.findById(id)
            ).save(flush: true)
        } else {
            exists.overall = vote
            exists.save(flush: true)
        }

        def votes = CourseEvaluation.findAllByCourse(Course.findById(id))
        def median = Math.floor((votes.sum { it.overall }) / votes.size())

        def result = [
                median: median,
        ]
        respond result, model: [result: result]
    }

    def create() {
        respond new Course(params)
    }

    @Transactional
    def save(Course courseInstance) {
        if (courseInstance == null) {
            notFound()
            return
        }

        if (courseInstance.hasErrors()) {
            respond courseInstance.errors, view: 'create'
            return
        }

        courseInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'course.label', default: 'Course'), courseInstance.id])
                redirect courseInstance
            }
            '*' { respond courseInstance, [status: CREATED] }
        }
    }

    def edit(Course courseInstance) {

        def result = [
                courseInstance: courseInstance,
                locations     : Location.findAll().collect { location ->
                    [
                            name: location.name,
                            url : location.url
                    ]
                }
        ]
        respond result, model: [result: result]
    }

    def getCourseForm( int id ){
        def course = Course.findById(id)
        def result = [
                courseInstance: course,
                teachers: course.teachers.collect { teacher ->
                    [
                            id: teacher.id,
                            name: teacher.name
                    ]
                },
                locations     : Location.findAll().collect { location ->
                    [
                        id: location.id,
                        location: location.name,
                        selected: ( course.location.id == location.id  )? 1 : 0
                    ]
                }
        ]
        respond result, model: [result: result]
    }

    def updateCourse() {
        def id = request.JSON.id.toInteger()
        def location = request.JSON.location.toInteger()
        def code = request.JSON.code.toInteger()
        def name = request.JSON.name
        def typo = request.JSON.typo
        def credits = request.JSON.credits.toInteger()
        def descr = request.JSON.descr
        def cont = request.JSON.cont
        def teachers = request.JSON.teachers

        if( ( id.intValue() > 0 )&& ( location.intValue() > 0 ) && ( name != "" ) && ( code.intValue() > 0 ) && ( typo != "" ) && ( teachers.size() > 0 )  ) {
            def course = Course.findById(id)

            course.location = Location.findById(location)
            course.code = code
            course.name = name
            course.typology = typo
            course.credits = credits
            course.description = descr
            course.contents = cont

            def teachers_array = teachers.collect {
                Teacher.findById(it.id)
            }

            course.teachers = teachers_array
            if (course.save(flush: true))
                render 1
            else
                render 0
        }else render 0
    }

    def teacherSearch(String teacher) {
        def result = Teacher.findAllByNameIlike("%" + teacher + "%", [max: 5]).collect { teach ->
            [
                    id  : teach.id,
                    name: teach.name
            ]
        }
        render result as JSON
    }

    def createCourse(){
        def location = request.JSON.location.toInteger()
        def code = request.JSON.code.toInteger()
        def name = request.JSON.name
        def typo = request.JSON.typo
        def credits = request.JSON.credits.toInteger()
        def descr = request.JSON.descr
        def cont = request.JSON.cont
        def teachers = request.JSON.teachers

        if( ( location.intValue() > 0 ) && ( name != "" ) && ( code.intValue() > 0 ) && ( typo != "" ) && ( teachers.size() > 0 ) && ( credits.intValue() > 0 )  ) {
            def course = new Course()

            course.location = Location.findById(location)
            course.code = code
            course.name = name
            course.typology = typo
            course.credits = credits
            course.description = descr
            course.contents = cont

            def teachers_array = teachers.collect {
                Teacher.findById(it.id)
            }

            course.teachers = teachers_array

            if (course.save(flush: true))
                render 1
            else
                render 0
        }else render 0
    }

    def getLocations(){
        def locations = Location.findAll().collect { location ->
            [
                    id: location.id,
                    location: location.name
            ]
        }
        render locations as JSON
    }

    @Transactional
    def update(Course courseInstance) {
        if (courseInstance == null) {
            notFound()
            return
        }

        if (courseInstance.hasErrors()) {
            respond courseInstance.errors, view: 'edit'
            return
        }

        courseInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Course.label', default: 'Course'), courseInstance.id])
                redirect courseInstance
            }
            '*' { respond courseInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Course courseInstance) {

        if (courseInstance == null) {
            notFound()
            return
        }

        courseInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Course.label', default: 'Course'), courseInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

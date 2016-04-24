package unapp


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CourseController {

    static allowedMethods = [index: "GET", show: "GET", comments: "GET", comment: "POST", voteUp: "POST", voteDown: "POST", save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        def result = Location.list().collect { l ->
            [name   : l.name,
             courses: Course.findAllByLocation(l).collect { c ->
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
             author       : comment.author.name,
             picture      : comment.author.picture,
             body         : comment.body,
             date         : comment.date.format("yyyy-MM-dd 'a las' HH:mm"),
             voted        : ( Vote.findByCommentAndAuthor( comment, session.user ) != null  )? Vote.findByCommentAndAuthor( comment, session.user ).value: -1,
             positiveVotes: comment.positiveVotes,
             negativeVotes: comment.negativeVotes,
             teacher      : comment.teacher ? comment.teacher.name : null,
             teacherId      : comment.teacher ? comment.teacher.id : null
            ]
        }
        respond result, model: [result: result]
    }

    def comment() {
        if (!session.user) {
            return
        }

        def comment = new Comment(
                body: request.JSON.body,
                course: Course.get(request.JSON.id),
                teacher: Teacher.get(request.JSON.teacherId.toInteger()),
                author: session.user,
                date: new Date()
        ).save(flush: true)

        def result = [id           : comment.id,
                      author       : comment.author.name,
                      picture      : comment.author.picture,
                      body         : comment.body,
                      date         : comment.date,
                      voted        : ( Vote.findByCommentAndAuthor( comment, session.user ) != null  )? Vote.findByCommentAndAuthor( comment, session.user ).value: -1,
                      positiveVotes: comment.positiveVotes,
                      negativeVotes: comment.negativeVotes,
                      teacher      : comment.teacher ? comment.teacher.name : null,
                      teacherId      : comment.teacher ? comment.teacher.id : null
        ]

        respond result, model: [result: result]
    }

    def voteUp() {
        def user = session.user
        if (!user) {
            return
        }

        def comment = Comment.findById(request.JSON.id)
        if (!comment) {
            return
        }

        def vote = Vote.findByAuthorAndComment(user, comment)
        if (vote) {
            if (vote.value == 0) {
                vote.value = 1
                comment.negativeVotes--;
                comment.positiveVotes++;
            }
        } else {
            vote = new Vote(value: 1, author: user, comment: comment)
            comment.positiveVotes++;
        }

        comment.save(flush: true)
        vote.save(flush: true)

        def result = [id           : comment.id,
                      author       : comment.author.name,
                      picture      : comment.author.picture,
                      body         : comment.body,
                      date         : comment.date.format("yyyy-MM-dd 'a las' HH:mm"),
                      voted        : ( Vote.findByCommentAndAuthor( comment, session.user ) != null  )? Vote.findByCommentAndAuthor( comment, session.user ).value: -1,
                      positiveVotes: comment.positiveVotes,
                      negativeVotes: comment.negativeVotes,
                      teacher      : comment.teacher ? comment.teacher.name : null,
                      teacherId      : comment.teacher ? comment.teacher.id : null
        ]

        respond result, model: [result: result]
    }

    def voteDown() {
        def user = session.user
        if (!user) {
            return
        }

        def comment = Comment.findById(request.JSON.id)
        if (!comment) {
            return
        }

        def vote = Vote.findByAuthorAndComment(user, comment)
        if (vote) {
            if (vote.value == 1) {
                vote.value = 0
                comment.negativeVotes++;
                comment.positiveVotes--;
            }
        } else {
            vote = new Vote(value: 0, author: user, comment: comment)
            comment.negativeVotes++;
        }

        comment.save(flush: true)
        vote.save(flush: true)

        def result = [id           : comment.id,
                      author       : comment.author.name,
                      picture      : comment.author.picture,
                      body         : comment.body,
                      date         : comment.date.format("yyyy-MM-dd 'a las' HH:mm"),
                      voted        : ( Vote.findByCommentAndAuthor( comment, session.user ) != null  )? Vote.findByCommentAndAuthor( comment, session.user ).value: -1,
                      positiveVotes: comment.positiveVotes,
                      negativeVotes: comment.negativeVotes,
                      teacher      : comment.teacher ? comment.teacher.name : null,
                      teacherId      : comment.teacher ? comment.teacher.id : null
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
        respond courseInstance
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

package unapp


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TeacherController {

    static allowedMethods = [index: "GET", show: "GET", comments: "GET", comment: "POST", voteUp: "POST", voteDown: "POST", save: "POST", update: "PUT", delete: "DELETE"]

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
             date         : comment.date,
             positiveVotes: comment.positiveVotes,
             negativeVotes: comment.negativeVotes
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
                course: null,
                teacher: Teacher.get(request.JSON.id),
                author: session.user,
                date: new Date()
        ).save(flush: true)

        def result = [id           : comment.id,
                      author       : comment.author.name,
                      picture      : comment.author.picture,
                      body         : comment.body,
                      date         : comment.date,
                      positiveVotes: comment.positiveVotes,
                      negativeVotes: comment.negativeVotes
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
                      date         : comment.date,
                      positiveVotes: comment.positiveVotes,
                      negativeVotes: comment.negativeVotes
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
                      date         : comment.date,
                      positiveVotes: comment.positiveVotes,
                      negativeVotes: comment.negativeVotes
        ]

        respond result, model: [result: result]
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

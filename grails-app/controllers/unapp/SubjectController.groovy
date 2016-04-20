package unapp

class SubjectController {

    static allowedMethods = [index: "GET", comments: "GET", comment: "POST"]

    def index(int id) {
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
             date         : comment.date,
             positiveVotes: comment.positiveVotes,
             negativeVotes: comment.negativeVotes
            ]
        }

        respond result, model: [result: result]
    }

    def comment() {
        if (session.user == null) {
            return
        }

        def result = new Comment(
                body: request.JSON.body,
                course: Course.get(request.JSON.id),
                teacher: null,
                author: session.user,
                date: new Date()
        ).save(flush: true)

        result = [id           : result.id,
                  author       : result.author.name,
                  body         : result.body,
                  date         : result.date,
                  positiveVotes: result.positiveVotes,
                  negativeVotes: result.negativeVotes
        ]

        respond result, model: [result: result]
    }

    def upVote(String id2) {
        def id = id2.toInteger()

        def comment = Comment.findById(id)
        def user = session["user"]

        if (user == null) {
            render comment.positiveVotes + " " + comment.negativeVotes
            return
        }

        def like = Vote.findByAuthorAndComment(user, comment)


        if (like != null) {
            if (like.value == 0) {
                like.value = 1
                comment.negativeVotes--;
                comment.positiveVotes++;
            }
        } else {
            like = new Vote(value: 1, author: user, comment: comment)
            comment.positiveVotes++;
        }


        comment.save(flush: true, failOnError: true)

        def aux = like.errors
        like.save(flush: true, failOnError: true)

        render comment.positiveVotes + " " + comment.negativeVotes
    }

    def downVote(String id2) {
        def id = id2.toInteger()

        def comment = Comment.findById(id)
        def user = session["user"]

        if (user == null) {
            render comment.positiveVotes + " " + comment.negativeVotes
            return
        }

        def like = Vote.findByAuthorAndComment(user, comment)


        if (like != null) {
            if (like.value == 1) {
                like.value = 0
                comment.negativeVotes++;
                comment.positiveVotes--;
            }
        } else {
            like = new Vote(value: 0, author: user, comment: comment)
            comment.negativeVotes++;
        }

        comment.save(flush: true, failOnError: true)
        like.save(flush: true, failOnError: true)

        render comment.positiveVotes + " " + comment.negativeVotes
    }
}

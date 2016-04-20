package unapp

class SubjectController {

    static allowedMethods = [index: "GET", comments: "GET", comment: "POST", voteUp: "POST", voteDown: "POST"]

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
        if (!session.user) {
            return
        }

        def comment = new Comment(
                body: request.JSON.body,
                course: Course.get(request.JSON.id),
                teacher: null,
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
}

package unapp

import grails.transaction.Transactional

@Transactional(readOnly = true)
class CommentController {

    static allowedMethods = [addCourseComment: "POST", addTeacherComment: "POST", voteUp: "POST", voteDown: "POST"]

    def addCourseComment() {
        def user = session.user
        if (!user) {
            return
        }

        def comment = new Comment(
                body: request.JSON.body,
                course: Course.get(request.JSON.id),
                teacher: null,
                author: user,
                date: new Date()
        ).save(flush: true)

        def result = [id           : comment.id,
                      author       : comment.author.name,
                      picture      : comment.author.picture,
                      body         : comment.body,
                      date         : comment.date,
                      voted        : Vote.findByAuthorAndComment(user, comment)?.value ?: 0,
                      positiveVotes: comment.countPositiveVotes(),
                      negativeVotes: comment.countNegativeVotes()
        ]

        respond result, model: [result: result]
    }

    def addTeacherComment() {
        def user = session.user
        if (!user) {
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
                      voted        : Vote.findByAuthorAndComment(user, comment)?.value ?: 0,
                      positiveVotes: comment.countPositiveVotes(),
                      negativeVotes: comment.countNegativeVotes()
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
            vote.value = 1
        } else {
            vote = new Vote(value: 1, author: user, comment: comment)
        }

        comment.save(flush: true)
        vote.save(flush: true)

        def result = [id           : comment.id,
                      author       : comment.author.name,
                      picture      : comment.author.picture,
                      body         : comment.body,
                      date         : comment.date,
                      voted        : Vote.findByAuthorAndComment(user, comment)?.value ?: 0,
                      positiveVotes: comment.countPositiveVotes(),
                      negativeVotes: comment.countNegativeVotes()
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
            vote.value = -1
        } else {
            vote = new Vote(value: 0, author: user, comment: comment)
        }

        comment.save(flush: true)
        vote.save(flush: true)

        def result = [id           : comment.id,
                      author       : comment.author.name,
                      picture      : comment.author.picture,
                      body         : comment.body,
                      date         : comment.date,
                      voted        : Vote.findByAuthorAndComment(user, comment)?.value ?: 0,
                      positiveVotes: comment.countPositiveVotes(),
                      negativeVotes: comment.countNegativeVotes()
        ]

        respond result, model: [result: result]
    }
}

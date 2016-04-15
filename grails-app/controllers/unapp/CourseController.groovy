package unapp


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CourseController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        def result = []
        List<Location> locations = Location.list()
        List<Course> courses = []
        locations.eachWithIndex { l, i ->
            courses.add(Course.findAllByLocation(l))
            def listOfCourses = []
            courses[i].each { c ->
                listOfCourses.add([code: c.code, name: c.name, credits: c.credits])
            }
            result.add([location: [name: l.name, courses: listOfCourses]])
        }
        respond result,
                model: [
                        locations: locations,
                        courses  : courses
                ]
    }

    def search() {
        def result = []
        List<Course> courses = Course.findAllByNameIlike("%" + params.query + "%")
        courses.each { c ->
            result.add([code: c.code, name: c.name, credits: c.credits])
        }

        respond result,
                model: [
                        courses: courses
                ]
    }

    def show(Course courseInstance) {
        respond courseInstance
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

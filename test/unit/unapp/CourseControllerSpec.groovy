package unapp


import grails.test.mixin.*
import spock.lang.*

@TestFor(CourseController)
@Mock(Course)
class CourseControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        return [code: "342332", name: "Matematicas discretas II", credits: 4]
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.courseInstanceList
        model.courseInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.courseInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def course = new Course()
        course.validate()
        controller.save(course)

        then: "The create view is rendered again with the correct model"
        model.courseInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        def params = populateValidParams(params)

        println params

        course = new Course(params)

        controller.save(course)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/course/show/1'
        controller.flash.message != null
        Course.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def course = new Course(params)
        controller.show(course)

        then: "A model is populated containing the domain instance"
        model.courseInstance == course
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def course = new Course(params)
        controller.edit(course)

        then: "A model is populated containing the domain instance"
        model.courseInstance == course
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/course/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def course = new Course()
        course.validate()
        controller.update(course)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.courseInstance == course

        when: "A valid domain instance is passed to the update action"
        response.reset()
        def params = populateValidParams(params)
        course = new Course(params).save(flush: true)
        controller.update(course)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/course/show/$course.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/course/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        def params = populateValidParams(params)
        def course = new Course(params).save(flush: true)

        then: "It exists"
        Course.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(course)

        then: "The instance is deleted"
        Course.count() == 0
        response.redirectedUrl == '/course/index'
        flash.message != null
    }
}

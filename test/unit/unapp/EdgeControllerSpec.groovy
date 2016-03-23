package unapp


import grails.test.mixin.*
import spock.lang.*

@TestFor(EdgeController)
@Mock(Edge)
class EdgeControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        params["prev"] = new Course([code: "342332", name: "Matematicas discretas II", credits: 4])
        params["next"] =new Course([code: "342331", name: "Matematicas discretas I", credits: 4])
        params["degree"] = new Degree( code:"1", name: "name" , type : "type", location : new Location( name: "d", url : "a") , courses : [] )
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.edgeInstanceList
        model.edgeInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.edgeInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def edge = new Edge()
        edge.validate()
        controller.save(edge)

        then: "The create view is rendered again with the correct model"
        model.edgeInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        edge = new Edge(params)

        controller.save(edge)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/edge/show/1'
        controller.flash.message != null
        Edge.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def edge = new Edge(params)
        controller.show(edge)

        then: "A model is populated containing the domain instance"
        model.edgeInstance == edge
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def edge = new Edge(params)
        controller.edit(edge)

        then: "A model is populated containing the domain instance"
        model.edgeInstance == edge
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/edge/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def edge = new Edge()
        edge.validate()
        controller.update(edge)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.edgeInstance == edge

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        edge = new Edge(params).save(flush: true)
        controller.update(edge)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/edge/show/$edge.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/edge/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def edge = new Edge(params).save(flush: true)

        then: "It exists"
        Edge.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(edge)

        then: "The instance is deleted"
        Edge.count() == 0
        response.redirectedUrl == '/edge/index'
        flash.message != null
    }
}

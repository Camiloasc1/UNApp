package unapp

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(LoginController)
class LoginControllerSpec extends Specification
{

    def setup()
    {
    }

    def cleanup()
    {
    }

    void "test something"()
    {
        given: "test given"
        println "first given"

        when: "test when"
        println "first when"

        then: "test then"
        println "first then"
    }
}

package unapp

import org.scribe.model.Token
import grails.converters.JSON

class LoginController {
    def oauthService
    def googleAPIService

    def index() {}

    def success() {
        def googleResponse = googleAPIService.getJSON((Token) session[oauthService.findSessionKeyForAccessToken('google')])
        if (googleResponse.hd != "unal.edu.co") {
            session[oauthService.findSessionKeyForAccessToken('google')] = null
            flash.message = "Only unal.edu.co users can login."
            redirect(uri: '/')
        }

        def user = User.findByGoogleID(googleResponse.id)
        if (user == null) {
            user = new User(googleID: googleResponse.id, name: googleResponse.name, email: googleResponse.email)
            user.save(flush: true)
        }
        session.user = user

        flash.message = "Login success."
        redirect(uri: '/')
    }

    def failure() {
        flash.message = "Login failure."
        redirect(uri: '/')
    }

    def revoke() {
        if (session[oauthService.findSessionKeyForAccessToken('google')]) {
            session[oauthService.findSessionKeyForAccessToken('google')] = null
        }
        session.user = null
        flash.message = "Logged out."

        redirect(uri: '/')
    }

    def me() {
        if (session[oauthService.findSessionKeyForAccessToken('google')]) {
            def googleResponse = googleAPIService.getJSON((Token) session[oauthService.findSessionKeyForAccessToken('google')])
            Map userData = [:]
            googleResponse.each { k, v ->
                userData[k] = v
            }
            respond userData
        }
    }


}

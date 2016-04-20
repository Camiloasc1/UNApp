package unapp

import org.scribe.model.Token
import uk.co.desirableobjects.oauth.scribe.holder.RedirectHolder

class LoginController {
    def oauthService
    def googleAPIService

    def index() {}

    def success() {
        def googleResponse = googleAPIService.get((Token) session[oauthService.findSessionKeyForAccessToken('google')])
        if (googleResponse.hd != "unal.edu.co") {
            session[oauthService.findSessionKeyForAccessToken('google')] = null
            flash.message = "Only unal.edu.co users can login."
            redirect(uri: RedirectHolder.getRedirect().uri)
        }

        def user = User.findByGoogleID(googleResponse.id)
        if (!user) {
            user = new User(googleID: googleResponse.id, name: googleResponse.name, email: googleResponse.email, picture: googleResponse.picture).save(flush: true)
        }
        user.setPicture(googleResponse.picture) //Update picture in case the user was already created
        session.user = user

        flash.message = "Login success."
        redirect(uri: RedirectHolder.getRedirect().uri)
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
            Map userData = googleAPIService.get((Token) session[oauthService.findSessionKeyForAccessToken('google')])
            respond userData
        }
    }
}

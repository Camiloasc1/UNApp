package unapp

import org.scribe.model.Token
import grails.converters.JSON

class LoginController
{
    def oauthService
    def googleAPIService

    def index() {}

    def success()
    {
        def googleResponse = googleAPIService.getJSON((Token) session[oauthService.findSessionKeyForAccessToken('google')])
        if (googleResponse.hd != "unal.edu.co")
        {
            session[oauthService.findSessionKeyForAccessToken('google')] = null
            flash.message = "Only unal.edu.co users can login."
            //redirect action: 'index'
            redirect(uri: '/')
        }
        def user = User.findByGoogleID(googleResponse.id)
        if(user == null){
            user = new User( name: googleResponse.name  , email : googleResponse.email , googleID: googleResponse.id )
            user.save()
        }

        session ["user"] = user

        redirect(uri: '/')
    }

    def failure()
    {
        flash.message = "Login failure."
        //redirect action: 'index'
        redirect(uri: '/')
    }

    def revoke()
    {
        if (session[oauthService.findSessionKeyForAccessToken('google')])
        {
            session[oauthService.findSessionKeyForAccessToken('google')] = null
            flash.message = "Logged out."
        }

        session["user"] = null

        redirect(uri: '/')
    }

    def me()
    {
        if (session[oauthService.findSessionKeyForAccessToken('google')])
        {
            def googleResponse = googleAPIService.getJSON((Token) session[oauthService.findSessionKeyForAccessToken('google')])
            //Map data = [name: googleResponse.name, id: googleResponse.id, hd: googleResponse.hd, email: googleResponse.email]
            render googleResponse as JSON
        }
    }


}

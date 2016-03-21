package unapp

import grails.converters.JSON
import org.scribe.model.Token

class LoginController
{
    def oauthService

    def index() {}

    def success()
    {
        Token googleAccessToken = (Token) session[oauthService.findSessionKeyForAccessToken('google')]
        def googleResource = oauthService.getGoogleResource(googleAccessToken, "https://www.googleapis.com/oauth2/v2/userinfo")
        def googleResponse = JSON.parse(googleResource?.getBody())
        if (googleResponse.hd != "unal.edu.co")
        {
            session[oauthService.findSessionKeyForAccessToken('google')] = null
            flash.message = "Only unal.edu.co users can login."
            redirect action: 'failure'
        }

        Map data = [name: googleResponse.name, id: googleResponse.id, hd: googleResponse.hd, email: googleResponse.email]

        [data: googleResponse]
    }

    def failure() {}

    def revoke()
    {
        if (session[oauthService.findSessionKeyForAccessToken('google')])
        {
            session[oauthService.findSessionKeyForAccessToken('google')] = null
            flash.message = "Token revoked successfully."
        }
        redirect action: 'index'
    }
}

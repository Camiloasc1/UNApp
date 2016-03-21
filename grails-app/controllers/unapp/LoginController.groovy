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
        [data: googleResponse]
    }

    def failure() {}

    def revoke()
    {
        if (params.id && session[oauthService.findSessionKeyForAccessToken(params.id)])
        {
            session[oauthService.findSessionKeyForAccessToken(params.id)] = null
            flash.message = "Token revoked successfully."
        }
        redirect action: 'index'
    }
}

package unapp

class LoginController
{
    def oauthService

    def index() {}

    def success() {}

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

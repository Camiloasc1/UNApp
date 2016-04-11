package unapp

class AdminFilters {

    def filters = {
        all(controller: '*', action: 'create|update|save|delete|show|edit') {
            before = {
                def user = session["user"]
                if(user == null || !user.isAdmin ){
                    redirect uri:"/"
                    return false
                }
            }
        }

        adm(controller: 'admin', action: '*') {
            before = {
                def user = session["user"]
                if(user == null || !user.isAdmin ){
                    redirect uri:"/"
                    return false
                }
            }
        }

    }
}

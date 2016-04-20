package unapp

class UnappTagLib {
    static namespace = 'unapp'
    static defaultEncodeAs = [taglib: 'raw']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]
    def isAdmin = { attrs, body ->
        if (session.user?.isAdmin) {
            out << body()
        }
    }
}

package unapp

class SubjectController {

    static allowedMethods = [save: "POST", read: "GET", update: "PUT", delete: "DELETE"]

    def index() {
        def course = Course.get( params.id )
        def comentarios = Comment.findAllByCourse(course,[sort:"date",order:"desc", max:5])
        render view: "index", model: [ c: course, comments: comentarios , offset: 5]
    }



    def cargarComentarios(String offset, String id){
        def off = offset.toInteger()
        def course = Course.get( id.toInteger() )
        def comentarios = Comment.findAllByCourse(course,[sort:"date",order:"desc", max:5 , offset: off])

        def str = concatComentarios(comentarios)

        if(str.size()==0)
            render "<div align = \"center\"> No existen mas comentarios </div>"
        else
            render str
    }

    def concatComentarios(comentarios){

        def str =""

        comentarios.each {
            str += '<div class = "comentario">\n' +
                    '    <div class="col-sm-1">\n' +
                    '        <div class="thumbnail">\n' +
                    '            <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">\n' +
                    '        </div><!-- /thumbnail -->\n' +
                    '    </div><!-- /col-sm-1 -->\n' +
                    '\n' +
                    '    <div class="col-sm-11">\n' +
                    '        <div class="panel panel-default">\n' +
                    '            <div class="panel-heading">\n' +
                    '                <strong>'+it.author.name+'</strong> <span class="text-muted">'+it.date+'</span>\n' +
                    '            </div>\n' +
                    '            <div class="panel-body">\n' +
                    '                '+ it.body +'\n' +
                    '            </div><!-- /panel-body -->\n' +
                    '        </div><!-- /panel panel-default -->\n' +
                    '    </div><!-- /sm-11 -->\n' +
                    '</div>'
        }



        str

    }

    def comment(){

        def user = session["user"]

        if(user == null){
            render "<div align = \"center\"> Ingresar para comentar </div>"
            return
        }

        def course = Course.get( params.id )

        def teacher = null //TODO

        Comment comment = new Comment( body:params.body , course: course ,teacher: teacher ,author: user, date: new Date() )
        comment.save()

        def str = concatComentarios([comment])

        render str
    }

}

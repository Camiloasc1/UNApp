import unapp.*
import java.text.Normalizer
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.POST
import grails.converters.JSON


class BootStrap {

    def normalize(String s){
        return Normalizer.normalize(s, Normalizer.Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", '').toUpperCase().replaceAll("'", "")
    }

    def init = { servletContext ->
        //return
        def user = new User(name:"Pepito suarez",googleID:"1234",email:"amrondonp@gmail.com")
        user.save()
        if(Location.list().size()>0) return

        new Location( [name:"Bogota", url:"http://sia.bogota.unal.edu.co" ] ).save()
        new Location( [ name:"Amazonas", url:"http://siaama.unal.edu.co" ] ).save()
        new Location( [ name:"Caribe", url:"http://siacar.unal.edu.co" ] ).save()
        new Location( [ name:"Manizales", url:"http://sia2.manizales.unal.edu.co" ] ).save()
        //new Location( [ name:"Medellin", url:"http://sia.medellin.unal.edu.co" ] ).save()
        //new Location( [ name:"Palmira", url:"http://sia2.palmira.unal.edu.co" ] ).save()
        new Location( [ name:"Orinoquia", url:"http://siaori.unal.edu.co" ] ).save()
        new Location( [ name:"Tumaco", url:"http://siatum.unal.edu.co" ] ).save()

        def pattern = ~"'.+'"
        def type = ['PRE', 'POS']
        def source, html

        Location.list().each { loc ->
            type.each {
                try {

                    source = new URL(loc.url + '/academia/scripts/catalogo-programas/items_catalogo_' + it + '.js')
                            .getText('ISO-8859-1')
                    source = source.findAll(pattern)

                    String faculty = ''

                    for (def i = 0; i < source.size(); i++) {
                        source[i] = Normalizer.normalize(source[i], Normalizer.Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", '').toUpperCase().replaceAll("'", "")
                        if (source[i].contains('FACULTAD')) {
                            faculty = source[i]
                        } else if (i + 1 < source.size() && source[i + 1].contains('semaforo')) {
                            new Degree(location: loc, code: source[i + 1].find(/[0-9]+/),
                                    name: source[i], type: it).save( )
                        }
                    }

                } catch (Exception e) {
                    //e.printStackTrace()
                    println "Sia sede $loc.name no disponible"
                }
            }
        }

        //Modify this query if you want to include more Degrees
        Degree.findAll("from Degree as d where d.type='PRE' and d.code = 2879").each { sp ->

            println sp.toString()

            def url = (sp.location == 'Medellin') ? Location.findByName(sp.location).url + ":9401/" :
                    Location.findByName(sp.location).url
            def http = new HTTPBuilder(url + '/buscador/JSON-RPC')
            def codeStudyPlan = sp.code

            def list = []
            http.request(POST, groovyx.net.http.ContentType.JSON) { req ->

                body = [
                        "jsonrpc": "2.0",
                        "method" : "buscador.obtenerAsignaturas",
                        "params" : ["", "PRE", "", "" , codeStudyPlan, "", 1, 999]
                ]

                // success response handler
                response.success = { resp, json ->

                    json.result.asignaturas.list.each { v ->
                        list.add(["name": normalize(v.nombre), "typology": v.tipologia,
                                  "code": v.codigo, "credits": v.creditos])

                        if (!Course.findByCode(v.codigo)) {
                            def course = new Course(list.last())
                            course.location = sp.location.name
                            if (!course.save()) {
                                println "error guardando curso"
                            }
                        }
                    }
                }

                // failure response handler
                response.failure = { resp ->
                    println "Unexpected error: ${resp.statusLine.statusCode}"
                    println "${resp.statusLine.reasonPhrase}"
                }
            }
        }

        def co = new Course( [name:"SIN PREREQUISITOS" , code:-1 , credits: 0, typology: "P"])
        co.location = Location.findByName("Bogota")
        co.save()

        Course.list().each{ course ->
            println course.toString()

            def loc = Location.findByName(course.location)

            def url = (loc.name == 'Medellin') ? loc.url + ":9401/" : loc.url
            def http = new HTTPBuilder(url + '/buscador/JSON-RPC')

            def groups = []
            http.request(POST, groovyx.net.http.ContentType.JSON) { req ->
                body = [
                        "jsonrpc": "2.0",
                        "method" : "buscador.obtenerGruposAsignaturas",
                        "params" : [course.code, "0"]
                ]

                // success response handler
                response.success = { resp, json ->
                    json.result.list.each { a ->
                        def temp = ["teacher"       : (a.nombredocente.trim().size() == 0)? 'Profesor no asignado': a.nombredocente, "code": a.codigo,
                                    "availableSpots": a.cuposdisponibles, "totalSpots": a.cupostotal, "timeSlots": []]
                        def name = temp["teacher"]
                        if(Teacher.findByName(name)==null){
                            def teacher = new Teacher([name:name]).addToCourses( course )
                            if(!teacher.save()){
                                println "Error guardando el profesor " + name
                            }
                        }
                    }
                }

                // failure response handler
                response.failure = { resp ->
                    println "Unexpected error: ${resp.statusLine.statusCode}"
                    println $ { resp.statusLine.reasonPhrase }
                }
            }

        }


        Degree.findAll("from Degree as d where d.type='PRE' and d.code = 2879").each { sp ->
            def url = sp.location.url + '/academia/catalogo-programas/semaforo.do?plan=' + sp.code + '&tipo=' + sp.type + '&tipoVista=semaforo&nodo=1&parametro=on'
            def http = new HTTPBuilder(url)
            html = http.get([:])

            //Filling codes
            html."**".findAll { it.@class.toString().contains("caja-ass") }.each { it2 ->

                String code = it2.DIV[1].A.H5.text()
                def credits

                try {
                    credits = Integer.parseInt(it2.DIV[1].A.DIV[1].text())
                } catch (Exception e) {
                    credits = -1
                }

                String name = it2.DIV[2].DIV[1].H4.text()

                if(name == "") name = code

                name = normalize(name)

                if( Course.findByName(name) == null ) {
                    def cc = new Course( [code: code, name: name, credits: credits] )
                    cc.location = sp.location
                    if(!cc.save(flush:true)){
                        log.error "${cc.errors.allErrors}"
                        println name+" "+cc.toString()
                    }
                }

            }

        }


        Degree.findAll("from Degree as d where d.type='PRE' and d.code = 2879").each { sp ->

            println sp.toString()

            def url = sp.location.url + '/academia/catalogo-programas/semaforo.do?plan=' + sp.code + '&tipo=' + sp.type + '&tipoVista=semaforo&nodo=1&parametro=on'

            def http = new HTTPBuilder(url)

            html = http.get([:])

            //Filling codes
            html."**".findAll { it.@class.toString().contains("caja-ass") }.each { it2 ->

                String code = it2.DIV[1].A.H5.text()

                String name = it2.DIV[2].DIV[1].H4.text()
                name = normalize(name)

                if(name == "") name = code

                def iterator = it2.DIV[2].DIV[1].childNodes()

                def i = 0
                while(iterator.hasNext()){
                    def prerequisite = iterator.next()
                    if(i>=3){
                        def aux = prerequisite.text()
                        aux = normalize(aux)
                        aux = aux.find(/[a-zA-Z][a-zA-Z ]+/).trim()
                        def prev = Course.findByName(aux)
                        if(prev==null || aux==null){
                            println normalize(prerequisite.text())
                            println prev+" wasn't found"
                        }else{
                            name = name.trim()
                            def edge = new Edge( [prev: prev , next: Course.findByName(name) , degree: sp   ] )
                            if(!edge.save()){
                                println name+" "+aux
                                log.error "${edge.errors.allErrors}"
                            }
                        }
                    }
                    i++
                }


            }

        }


    }

    def destroy = {

    }
}

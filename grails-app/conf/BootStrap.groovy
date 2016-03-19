import unapp.DBFillerService
import unapp.Degree
import unapp.Location
import unapp.Course
import java.text.Normalizer
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.POST
import grails.converters.JSON


class BootStrap {

    def init = { servletContext ->
        new Location( [name:"Bogota", url:"http://sia.bogota.unal.edu.co" ] ).save()
        new Location( [ name:"Amazonas", url:"http://siaama.unal.edu.co" ] ).save()
        new Location( [ name:"Caribe", url:"http://siacar.unal.edu.co" ] ).save()
        new Location( [ name:"Manizales", url:"http://sia2.manizales.unal.edu.co" ] ).save()
        new Location( [ name:"Medellin", url:"http://sia.medellin.unal.edu.co" ] ).save()
        new Location( [ name:"Palmira", url:"http://sia2.palmira.unal.edu.co" ] ).save()
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


        Degree.findAll("from Degree as d where d.type='PRE'").each { sp ->

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
                        list.add(["name": v.nombre, "typology": v.tipologia,
                                  "code": v.codigo, "credits": v.creditos])

                        if (!Course.findByCode(v.codigo)) {
                            def course = new Course(list.last())
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
    }


    def destroy = {

    }
}

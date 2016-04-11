import unapp.*
import java.text.Normalizer
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.POST
import grails.converters.JSON

class BootStrap {

    def normalize(String s) {
        return Normalizer.normalize(s, Normalizer.Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", '').toUpperCase().replaceAll("'", "")
    }

    def init = { servletContext ->
        def count;
        // Fill the data base if is empty
        if (Location.list().size() == 0) {
            println("Loading Locations...")
            new Location(name: "Bogota", url: "http://sia.bogota.unal.edu.co").save()
            new Location(name: "Amazonas", url: "http://siaama.unal.edu.co").save()
            new Location(name: "Caribe", url: "http://siacar.unal.edu.co").save()
            new Location(name: "Manizales", url: "http://sia2.manizales.unal.edu.co").save()
            new Location(name: "Medellin", url: "http://sia.medellin.unal.edu.co").save()
            new Location(name: "Palmira", url: "http://sia.palmira.unal.edu.co").save()
            new Location(name: "Orinoquia", url: "http://siaori.unal.edu.co").save()
            new Location(name: "Tumaco", url: "http://siatum.unal.edu.co").save()
        }
        count = Location.list().size();
        println("${count} Locations Loaded.")

        def types = ['PRE', 'POS']
        def strings, html

        if (Degree.list().size() == 0) {
            println("Loading Degrees...")
            Location.list().each { loc ->
                types.each { ty ->
                    try {
                        strings = new URL(loc.url + '/academia/scripts/catalogo-programas/items_catalogo_' + ty + '.js')
                                .getText('ISO-8859-1')
                        strings = strings.findAll(/'(.+)'/, { it[1] })

                        String currentFac = ''

                        for (def i = 0; i < strings.size(); i++) {
                            if (strings[i].startsWith('FACULTAD') || strings[i].startsWith('SEDE')) {
                                currentFac = strings[i]
                            } else if (strings[i].startsWith('semaforo')) {
                                new Degree(
                                        code: strings[i].find(/[0-9]+/)?.toInteger() ?: 0,
                                        name: strings[i - 1],
                                        faculty: currentFac,
                                        type: ty,
                                        location: loc
                                ).save()
                            }
                        }

                    } catch (Exception e) {
                        //e.printStackTrace()
                        println "Sede $loc.name no disponible"
                    }
                }
            }
        }
        count = Degree.list().size();
        println("${count} Degrees Loaded.")

        if (Course.list().size() == 0) {
            new Course(
                    name: "SIN PREREQUISITOS",
                    code: 0,
                    credits: 0,
                    typology: "P",
                    location: Location.findByName("Bogota")
            ).save(flush: true)
        }
        if (Course.list().size() == 1) {
            println("Loading Courses...")
            //Degree.list().each { degree ->
            Degree.findByCode(2879).each { degree ->
                def http = new HTTPBuilder(degree.location.url + (degree.location.name == "Medellin" ? ":9401" : "") + "/buscador/JSON-RPC")
                http.request(POST, groovyx.net.http.ContentType.JSON) {
                    body = [
                            "jsonrpc": "2.0",
                            "method" : "buscador.obtenerAsignaturas",
                            "params" : ["", "PRE", "", degree.type, degree.code.toString(), "", 1, 999]
                    ]

                    // success response handler
                    response.success = { resp, json ->
                        json.result.asignaturas.list.each { c ->
                            if (!Course.findByCode(c.id_asignatura.toInteger())) {
                                new Course(
                                        internalcode: c.codigo.toInteger(),
                                        code: c.id_asignatura.toInteger(),
                                        name: c.nombre,
                                        typology: c.tipologia,
                                        credits: c.creditos.toInteger(),
                                        location: degree.location
                                ).save()
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
        count = Course.list().size();
        println("${count} Courses Loaded.")

        if (Teacher.list().size() == 0) {
            println("Loading Teachers...")
            Course.list().each { course ->
                def http = new HTTPBuilder(course.location.url + (course.location.name == "Medellin" ? ":9401" : "") + "/buscador/JSON-RPC")
                http.request(POST, groovyx.net.http.ContentType.JSON) {
                    body = [
                            "jsonrpc": "2.0",
                            "method" : "buscador.obtenerGruposAsignaturas",
                            "params" : [course.internalcode.toString(), "0"]
                    ]

                    // success response handler
                    response.success = { resp, json ->
                        json.result.list.each { group ->
                            def name = group.nombredocente ?: "Información Pendiente"
                            def user = group.usuariodocente ?: "InfoPendiente"
                            name = name.trim()
                            user = user.trim()
                            if (!Teacher.findByUsername(user)) {
                                new Teacher(
                                        name: name,
                                        username: user,
                                        location: course.location
                                ).save()
                            }
                            Teacher.findByUsername(user).addToCourses(course).save()
                        }
                    }

                    // failure response handler
                    response.failure = { resp ->
                        println "Unexpected error: ${resp.statusLine.statusCode}"
                        println $ { resp.statusLine.reasonPhrase }
                    }
                }
            }
        }
        count = Teacher.list().size();
        println("${count} Teachers Loaded.")

        /*
        //Degree.list().each { degree ->
        Degree.findByCode(2879).each { sp ->
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

                if (name == "") name = code

                name = normalize(name)

                if (Course.findByName(name) == null) {
                    def cc = new Course([code: code, name: name, credits: credits])
                    cc.location = sp.location
                    if (!cc.save(flush: true)) {
                        log.error "${cc.errors.allErrors}"
                        println name + " " + cc.toString()
                    }
                }

            }

        }

        //Degree.list().each { degree ->
        Degree.findByCode(2879).each { sp ->

            println sp.toString()

            def url = sp.location.url + '/academia/catalogo-programas/semaforo.do?plan=' + sp.code + '&tipo=' + sp.type + '&tipoVista=semaforo&nodo=1&parametro=on'

            def http = new HTTPBuilder(url)

            html = http.get([:])

            //Filling codes
            html."**".findAll { it.@class.toString().contains("caja-ass") }.each { it2 ->

                String code = it2.DIV[1].A.H5.text()

                String name = it2.DIV[2].DIV[1].H4.text()
                name = normalize(name)

                if (name == "") name = code

                def iterator = it2.DIV[2].DIV[1].childNodes()

                def i = 0
                while (iterator.hasNext()) {
                    def prerequisite = iterator.next()
                    if (i >= 3) {
                        def aux = prerequisite.text()
                        aux = normalize(aux)
                        aux = aux.find(/[group-zA-Z][group-zA-Z ]+/).trim()
                        def prev = Course.findByName(aux)
                        if (prev == null || aux == null) {
                            println normalize(prerequisite.text())
                            println prev + " wasn't found"
                        } else {
                            name = name.trim()
                            def edge = new Edge([prev: prev, next: Course.findByName(name), degree: sp])
                            if (!edge.save()) {
                                println name + " " + aux
                                log.error "${edge.errors.allErrors}"
                            }
                        }
                    }
                    i++
                }


            }

        }
        */
    }

    def destroy = {
    }
}

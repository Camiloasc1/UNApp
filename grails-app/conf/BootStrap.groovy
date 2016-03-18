import unapp.DBFillerService
import unapp.Degree
import unapp.Location
import java.text.Normalizer

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

                    //source = new URL('http://www.google.com.co/').getContent()
                    //source = source.findAll(pattern)
                    source = new URL(loc.url + '/academia/scripts/catalogo-programas/items_catalogo_' + it + '.js')
                            .getText('ISO-8859-1')
                    source = source.findAll(pattern)

                    String faculty = ''

                    for (def i = 0; i < source.size(); i++) {
                        source[i] = Normalizer.normalize(source[i], Normalizer.Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", '').toUpperCase().replaceAll("'", "")
                        //source[i] = Utility.stripAccents()
                        if (source[i].contains('FACULTAD')) {
                            faculty = source[i]
                        } else if (i + 1 < source.size() && source[i + 1].contains('semaforo')) {
                            new Degree(location: loc, code: source[i + 1].find(/[0-9]+/),
                                    name: source[i], type: it).save( )
                        }
                    }

                } catch (Exception e) {
                    println "Sia sede $loc.name no disponible"
                }
            }
        }

        /*Degree.findAllByType("PRE").each { sp ->
            try {
                source = new HTTPBuilder(sp.location.url + '/academia/catalogo-programas/semaforo.do?plan=' + sp.code +
                        '&tipo=' + sp.type + '&tipoVista=semaforo&nodo=1&parametro=on')
                html = source.get([:])
                type = [["fundamentalCredits", "B"], ["disciplinaryCredits", "C"], ["freeChoiceCredits", "L"]]
                def pr
                html."**".findAll { it.@id.text().find(/arco_[0-9]+/) }.TABLE.TBODY.each {
                    def value = -1
                    def component = it.TR[0].TD[0].text().toUpperCase()
                    //Se obtiene la cantidad de creditos por componente
                    if (component.contains("FUND")) {
                        value = type[0]
                        sp[value[0]] = component.find(/[0-9]+/).toInteger()
                    } else if (component.contains("DISC") || component.contains("GRAD")) {
                        value = type[1]
                        if (sp[value[0]] == null) sp[value[0]] = 0
                        sp[value[0]] += component.find(/[0-9]+/).toInteger()
                    }else if (component.contains("LIBRE")) {
                        value = type[2]
                        sp[value[0]] = component.find(/[0-9]+/).toInteger()
                    }
                    if (value != -1) {
                        it.TR[1].TD[0].TABLE.each {
                            it.TBODY.TR[0].TD[1].DIV.each {
                                pr = getCourseInfo(it, value[1], sp)
                                if (pr != null) sp.addToCourses(pr)
                            }
                            it.TBODY.TR[0].TD[1].TABLE.each {
                                it.TBODY.TR[0].TD[1].DIV.each {
                                    pr = getCourseInfo(it, value[1], sp)
                                    if (pr != null) sp.addToCourses(pr)
                                }
                            }
                        }
                    }
                }
                println sp.name + " " +sp.disciplinaryCredits + " " + sp.freeChoiceCredits + " " + sp.fundamentalCredits +
                        ((sp.courses != null) ? "courses " + sp.courses.size() : "no courses")
                sp.save( )
            } catch (Exception e) {
                println "Programa academico $sp.name de la sede $sp.location.name no disponible"
            }
        }*/

    }
    def destroy = {
    }
}

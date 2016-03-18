import unapp.DBFillerService
import unapp.Degree
import unapp.Location
import unapp.Course
import java.text.Normalizer
import groovyx.net.http.HTTPBuilder

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
                    e.printStackTrace()
                    println "Sia sede $loc.name no disponible"
                }
            }
        }


        Degree.findAll("from Degree as d where d.type='PRE'").each { sp ->

            println sp.toString()

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

                def name = it2.DIV[2].DIV[1].H4.text()

                if( Course.findByCode(code) == null ) {
                    println code+" "+name
                    new Course([code: code, name: name, credits: credits]).save()
                }
            }

        }
    }
    def destroy = {
    }
}

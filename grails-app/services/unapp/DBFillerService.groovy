package unapp

import grails.transaction.Transactional

@Transactional
class DBFillerService {
    static transactional = false

    def generateLocation(){
        new Location( [ name:"Bogota", url:"http://sia.bogota.unal.edu.co" ] ).save()
        new Location( [ name:"Amazonas", url:"http://siaama.unal.edu.co" ] ).save()
        new Location( [ name:"Caribe", url:"http://siacar.unal.edu.co" ] ).save()
        new Location( [ name:"Manizales", url:"http://sia2.manizales.unal.edu.co" ] ).save()
        new Location( [ name:"Medellin", url:"http://sia.medellin.unal.edu.co" ] ).save()
        new Location( [ name:"Palmira", url:"http://sia2.palmira.unal.edu.co" ] ).save()
        new Location( [ name:"Orinoquia", url:"http://siaori.unal.edu.co" ] ).save()
        new Location( [ name:"Tumaco", url:"http://siatum.unal.edu.co" ] ).save()
    }

    def DBFill() {
        generateLocation()
        Location.list().each { loc ->
            type.each {
                try {
                    source = new URL(loc.url + '/academia/scripts/catalogo-programas/items_catalogo_' + it + '.js')
                            .getText('ISO-8859-1')
                    source = source.findAll(pattern)

                    String faculty = ''

                    for (def i = 0; i < source.size(); i++) {
                        source[i] = Utility.stripAccents(source[i]).toUpperCase().replaceAll("'", "")
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
    }
}

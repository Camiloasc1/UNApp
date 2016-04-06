import unapp.Location

class BootStrap {

    def init = { servletContext ->

        // Check if the database is empty
        if (Location.list().size() > 0) return

        // Fill the data base
        new Location([name: "Bogota", url: "http://sia.bogota.unal.edu.co"]).save()
        new Location([name: "Amazonas", url: "http://siaama.unal.edu.co"]).save()
        new Location([name: "Caribe", url: "http://siacar.unal.edu.co"]).save()
        new Location([name: "Manizales", url: "http://sia2.manizales.unal.edu.co"]).save()
        new Location([name: "Medellin", url: "http://sia.medellin.unal.edu.co"]).save()
        new Location([name: "Palmira", url: "http://sia2.palmira.unal.edu.co"]).save()
        new Location([name: "Orinoquia", url: "http://siaori.unal.edu.co"]).save()
        new Location([name: "Tumaco", url: "http://siatum.unal.edu.co"]).save()
    }
    def destroy = {
    }
}

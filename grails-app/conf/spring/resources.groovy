import unapp.DBFillerService

// Place your Spring DSL code here
beans = {
    filler(DBFillerService) { bean ->
        bean.autowire = 'byName'
    }
}
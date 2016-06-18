deleteCollectionController <- function(input, output, session) {
    output$deletecollectionContents <- renderTable({
        if (input$deleteCollection == 1) {
            collection_name <- names(collectionOptions[as.integer(input$selectCollectionToDelete)])
            db <- mongo(collection = names(collectionOptions[as.integer(input$selectCollectionToDelete)]),
                                      url = sprintf(
                                        "mongodb://%s:%s@%s/%s",
                                        options()$mongodb$username,
                                        options()$mongodb$password,
                                        options()$mongodb$host,
                                        databaseName))
            db$drop()

            db <- mongo(collection = collectionOfCollections,
                                      url = sprintf(
                                        "mongodb://%s:%s@%s/%s",
                                        options()$mongodb$username,
                                        options()$mongodb$password,
                                        options()$mongodb$host,
                                        databaseName))

            db$remove(paste("{\"name\":\"", collection_name, "\"}", sep = ""))

            observe({
                updateSelectInput(session, "selectCollectionToDelete",
                                        label = "Target collection",
                                        choices = refreshCollectionNames(),
                                        selected = 1)
                session$sendCustomMessage(type = 'alertMessageWithRepload', message = "Collection successfully deleted!")
            })
        }
        NULL
    })
}
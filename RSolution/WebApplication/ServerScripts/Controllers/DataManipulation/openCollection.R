openCollectionController <- function(input, output, session) {
    output$collectionTable <- DT::renderDataTable({
        data <- NULL
        if (input$openCollection == 1) {
            data <- loadDataFromCollection(names(collectionOptions[as.integer(input$selectCollectionToOpen)]))
        }
        DT::datatable(data, options = list(lengthMenu = c(5, 30, 50), pageLength = 30))
    })
}
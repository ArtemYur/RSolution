fileDownloadingController <- function(input, output, session) {
    receiveData <- function() {
        loadDataFromCollection(names(collectionOptions[as.integer(input$selectCollectionDownLoadFile)]))
    }

    ## choose columns to display
    #output$downloadData <- DT::renderDataTable({
    #data <-
    #DT::datatable(data[, input$show_vars, drop = FALSE])
    #})

    output$downloadCollection <- downloadHandler(
    filename = function() {
        paste(input$selectCollectionDownLoadFile, '.csv', sep = '')
    },
    content = function(file) {
        write.csv(receiveData(), file)
    })
}
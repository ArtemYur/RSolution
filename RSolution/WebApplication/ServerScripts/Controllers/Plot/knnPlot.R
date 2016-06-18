knnPlotController <- function(input, output, session) {
    output$knnPlot <- renderPlot({
        data <- NULL
        if (input$renderKnnP >= 1) {
            data <- loadDataFromCollection(names(collectionOptions[as.integer(input$selectCollectionKnnP)]))
            library(dbscan)
            return(kNNdistplot(data, ncol(data) + 1))
        }
    })
}
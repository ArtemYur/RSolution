plot2dController <- function(input, output, session) {
    output$plot2d <- renderPlot({
        data <- NULL
        if (as.integer(input$selectCollectionP2dClass) != 0) {

            record <- loadFirstRecord(names(collectionOptions[as.integer(input$selectCollectionP2dClass)]))
            #print(paste('Schema record: ', record))
            schema <- c(names(record), "none")
            #print(paste('Schema: ', schema))
            #print(paste('List ', names(input$selectColumnP2dClass)))
            #print(paste("If statement: ", compare(schema, names(columnClassCode))))
            if (!compare(schema, names(columnClassCode))) {
                columnClassCode <- list()
                j <- 1
                selectedColumn <- 0
                for (name in schema) {
                    columnClassCode[name] <- j
                    if (j == input$selectColumnP2dClass) {
                        selectedColumn <- input$selectColumnP2dClass
                    }
                    j <- j + 1
                }
                columnClassCode["none"] <- 0
                #print(paste("Column Class Code: ", names(columnClassCode)))

                observe({
                    updateSelectInput(session, "selectColumnP2dClass",
                                                                       label = "Class column",
                                                                       choices = columnClassCode,
                                                                       selected = selectedColumn)
                })
            }

            if (input$renderPlot2d >= 1) {
                data <- loadDataFromCollection(names(collectionOptions[as.integer(input$selectCollectionP2d)]))
                color <- 1
                if (as.integer(input$selectColumnP2dClass) != 0) {
                    classesFrame <- loadDataFromCollection(names(classCode[as.integer(input$selectCollectionP2dClass)]))
                    print(names(classesFrame))
                    print(names(columnClassCode[as.integer(input$selectColumnP2dClass)]))
                    color <- array(classesFrame[, names(columnClassCode[as.integer(input$selectColumnP2dClass)])]) + 1
                }
                return(plot(data, col = color))
            }
        }
    })
}
factorAnalyzeController <- function(input, output, session) {
    output$faTable <- DT::renderDataTable({
        data <- NULL
        if (input$startAlgorithmFA == 1 && notNullNaEmpty(tempfilename) && notNullNaEmpty(input$knnMeasure)) {
            if (file.exists(tempfilename)) {
                unlink(tempfilename)
            }

            data <- loadDataFromCollection(names(collectionOptions[as.integer(input$selectCollectionFA)]))
            kmo = KMO_measure(data)

            if (kmo$KMO >= as.double(gsub(",", ".", input$knnMeasure))) {
                data <- getFactors(data, rotation = names(rotationList[as.integer(input$rotationInput)]))
                write.csv(data, tempfilename)
                data
            }
        }

        if (input$sendToNewContainerFA == 1 && file.exists(tempfilename) && notNullNaEmpty(input$newConteinerFA)) {
            data <- read.csv(tempfilename)
            if (compareNA(match("na", names(collectionOptions)), NA)) {
                data <- data[-1]
                data <- sendDataToDB(data, gsub(" ", "", input$newConteinerFA))
                addNewNameToCollection(input$newConteinerFA)
                observe({

                    session$sendCustomMessage(type = 'alertMessageWithRepload', message = "Data successfully uploaded to the data base!")
                })
            }
        }

        DT::datatable(data, options = list(lengthMenu = c(5, 30, 50), pageLength = 30))
    })
}
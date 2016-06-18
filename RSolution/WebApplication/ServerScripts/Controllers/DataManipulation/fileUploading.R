fileUploadingController <- function(input, output, session) {
    sendData <- function(data) {
        if (input$sendToExistingCollection == 1) {
            data <- sendDataToDB(data, names(collectionOptions[as.integer(input$selectCollection)]))
            observe({
                session$sendCustomMessage(type = 'alertMessageWithRepload', message = "Data successfully uploaded to the data base!")
            })
        }

        if (input$sendToNewContainer == 1) {
            if (compareNA(match("na", names(collectionOptions)), NA)) {
                data <- sendDataToDB(data, input$newConteiner)
                addNewNameToCollection(input$newConteiner)
                observe({
                    updateSelectInput(session, "selectCollection",
                                        label = "Target collection",
                                        choices = refreshCollectionNames(),
                                        selected = 1)
                    session$sendCustomMessage(type = 'alertMessageWithRepload', message = "Data successfully uploaded to the data base!")
                })
            }
        }
        data
    }

    output$file1 <- renderUI({
        if (flagForSuccessUpload == "flagForSuccessUpload") {
            fileInput('file1', 'Choose CSV File',
                    accept = c('text/csv',
                    'text/comma-separated-values,text/plain',
                    '.csv'))
        }
        input$file1
    })

    output$uploadedContents <- renderTable({

        # input$file1 will be NULL initially. After the user selects
        # and uploads a file, it will be a data frame with 'name',
        # 'size', 'type', and 'datapath' columns. The 'datapath'
        # column will contain the local filenames where the data can
        # be found.

        inFile <- input$file1

        if (is.null(inFile))
            return(NULL)

        data <- read.csv(inFile$datapath, header = input$header, sep = input$sep, quote = input$quote)
        sendData(data)
    })
}
createRecordController <- function(input, output, session) {
    output$createRecordContents <- renderUI({

        record <- loadFirstRecord(names(collectionOptions[as.integer(input$selectCollectionCreate)]))
        schema <- names(record)
        if (input$submit == 1) {
            record <- matrix(nrow = 1, ncol = length(schema))
            i <- 1
            for (attrName in schema) {
                record[1, i] <- as.double(input[[attrName]])
                #record <- c(record, as.double(input[[attrName]]))
                i <- i + 1
            }
            names(record) <- schema
            #record <- array(record)
            #
            print(record)
            sendDataToDB(record, names(collectionOptions[as.integer(input$selectCollectionCreate)]))
            session$sendCustomMessage(type = 'alertMessageWithRepload', message = "Record successfully created!")
            return(inputPanel())
        }
        elements <- c()

        for (name in schema) {
            elements <- c(elements, textInput(name, label = p(name), value = ""))
            textInput(name, label = p(name), value = "")
        }

        return(inputPanel(elements))

        #if (is.na(match("submit", names(input)))) {
        #record <- loadFirstRecord(names(collectionOptions[as.integer(input$selectCollectionCreate)]))
        #schema <- names(record)
        #elements <- c()

        #for (name in schema) {
        #elements <- c(elements, textInput(name, label = p(name), value = ""))
        #textInput(name, label = p(name), value = "")
        #}

        #return(inputPanel(elements))
        #} else {
        #if (input$submit == 1) {
        #record <- loadFirstRecord(names(collectionOptions[as.integer(input$selectCollectionCreate)]))
        #schema <- names(record)

        #record <- NULL
        #for (attrName in schema) {
        #record <- c(record, list(attrName = inputPanel[attrName]))
        #}
        #sendDataToDB(record, names(collectionOptions[as.integer(input$selectCollectionCreate)]))
        #}
        #}

    })
}
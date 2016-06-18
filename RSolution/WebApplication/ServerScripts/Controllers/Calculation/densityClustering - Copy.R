densityClusteringController <- function(input, output, session) {
    objectNum <- "\\{objectNum\\}"
    epsObj <- "\\{epsObj\\}"
    minPtsObj <- "\\{minPtsObj\\}"
    clustNum <- "\\{clustNum\\}"
    noise <- "\\{noise\\}"

    dbsResText <- paste("DBSCAN clustering for ", gsub("\\\\", "", objectNum), " objects.",
                    "\nParameters: eps = ", gsub("\\\\", "", epsObj), ", minPts = ", gsub("\\\\", "", minPtsObj),
                    "\nThe clustering contains ", gsub("\\\\", "", clustNum), " cluster(s).",
                    "\nPoints that don't clustered: ", gsub("\\\\", "", noise))



    output$dbsTable <- DT::renderDataTable({
        data <- NULL
        if (input$startAlgorithmDC == 1 && notNullNaEmpty(tempfilename)) {
            if (file.exists(tempfilename)) {
                unlink(tempfilename)
            }
            data <- loadDataFromCollection(names(collectionOptions[as.integer(input$selectCollectionDC)]))
            dbsRes <- executeImprovedDbscan(data, as.double(gsub(",", ".", input$epsDC)))

            dbsResText <- gsub(objectNum, nrow(data), dbsResText)
            dbsResText <- gsub(epsObj, as.double(gsub(",", ".", dbsRes$eps)), dbsResText)
            dbsResText <- gsub(minPtsObj, ncol(data) + 1, dbsResText)
            dbsResText <- gsub(clustNum, length(unique(dbsRes$clust)) - 1, dbsResText)
            dbsResText <- gsub(noise, length(which(dbsRes$cluster == 0)), dbsResText)

            print(dbsResText)

            output$dbsText <- renderText({
                dbsResText
            })

            data <- array(unlist(dbsRes$cluster))
            data <- array(c(1:length(data), data), c(length(data), 2))
            write.csv(data[, -1], tempfilename)
        }

        if (input$sendToNewContainerDC == 1 && file.exists(tempfilename) && notNullNaEmpty(input$newConteinerDC)) {
            data <- read.csv(tempfilename)
            if (compareNA(match("na", names(collectionOptions)), NA)) {
                print(data)
                data <- data[-1]
                print(data)
                data <- sendDataToDB(data, gsub(" ", "", input$newConteinerDC))
                addNewNameToCollection(input$newConteinerIDC)
                observe({
                    updateSelectInput(session, "selectCollectionDC",
                                        label = "Target collection",
                                        choices = refreshCollectionNames(),
                                        selected = 1)
                    session$sendCustomMessage(type = 'alertMessageWithRepload', message = "Data successfully uploaded to the data base!")
                })
            }
        }

        DT::datatable(data, options = list(lengthMenu = c(5, 30, 50), pageLength = 30))
    })
}
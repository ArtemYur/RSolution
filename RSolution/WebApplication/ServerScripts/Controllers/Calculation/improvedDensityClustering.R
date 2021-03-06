improvedDensityClusteringController <- function(input, output, session) {

    objectNum <- "\\{objectNum\\}"
    epsObj <- "\\{epsObj\\}"
    minPtsObj <- "\\{minPtsObj\\}"
    clustNum <- "\\{clustNum\\}"
    noise <- "\\{noise\\}"

    dbsResText <- paste("DBSCAN clustering for ", gsub("\\\\", "", objectNum), " objects.",
                    "\nParameters: eps = ", gsub("\\\\", "", epsObj), ", minPts = ", gsub("\\\\", "", minPtsObj),
                    "\nThe clustering contains ", gsub("\\\\", "", clustNum), " cluster(s).",
                    "\nPoints that don't clustered: ", gsub("\\\\", "", noise))



    output$idbsTable <- DT::renderDataTable({
        data <- NULL
        if (input$startAlgorithmIDC == 1 && notNullNaEmpty(tempfilename)) {
            if (file.exists(tempfilename)) {
                unlink(tempfilename)
            }
            data <- loadDataFromCollection(names(collectionOptions[as.integer(input$selectCollectionIDC)]))
            dbsRes <- executeImprovedDbscan(data, as.double(gsub(",", ".", input$epsIDC)))

            dbsResText <- gsub(objectNum, nrow(data), dbsResText)
            dbsResText <- gsub(epsObj, as.double(gsub(",", ".", dbsRes$eps)), dbsResText)
            dbsResText <- gsub(minPtsObj, ncol(data) + 1, dbsResText)
            dbsResText <- gsub(clustNum, length(unique(dbsRes$clust)) - 1, dbsResText)
            dbsResText <- gsub(noise, length(which(dbsRes$cluster == 0)), dbsResText)

            print(dbsResText)

            output$idbsText <- renderText({
                dbsResText
            })

            data <- array(unlist(dbsRes$cluster))
            data <- array(c(1:length(data), data), c(length(data), 2))
            write.csv(data[, -1], tempfilename)
        }

        if (input$sendToNewContainerIDC == 1 && file.exists(tempfilename) && notNullNaEmpty(input$newConteinerIDC)) {
            data <- read.csv(tempfilename)
            if (compareNA(match("na", names(collectionOptions)), NA)) {
                print(data)
                data <- data[-1]
                print(data)
                data <- sendDataToDB(data, gsub(" ", "", input$newConteinerIDC))
                addNewNameToCollection(input$newConteinerIDC)
                observe({
                    updateSelectInput(session, "selectCollectionIDC",
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
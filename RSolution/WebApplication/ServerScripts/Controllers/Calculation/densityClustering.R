densityClusteringController <- function(input, output, session) {

    objectNum <- "\\{objectNum\\}"
    epsObj <- "\\{epsObj\\}"
    minPtsObj <- "\\{minPtsObj\\}"
    clustNum <- "\\{clustNum\\}"
    groupNum <- "\\{groupNum\\}"

    dbsResText <- paste("DBSCAN clustering for ", gsub("\\\\", "", objectNum), " objects.",
                    "\nMinPts = ", gsub("\\\\", "", minPtsObj),
                    "\nThe clustering contains ", gsub("\\\\", "", clustNum), " cluster(s)",
                    "\nAnd ", gsub("\\\\", "", groupNum), " group(s)")



    output$dbsTable <- DT::renderDataTable({
        data <- NULL
        if (input$startAlgorithmDC == 1 && !file.exists(tempfilename)) {
            data <- loadDataFromCollection(names(collectionOptions[as.integer(input$selectCollectionDC)]))
            dbsRes <- dbscanFin(data)

            dbsResText <- gsub(objectNum, nrow(data), dbsResText)
            #dbsResText <- gsub(epsObj, as.double(gsub(",", ".", input$epsDC)), dbsResText)
            dbsResText <- gsub(minPtsObj, ncol(data) + 1, dbsResText)
            dbsResText <- gsub(clustNum, length(unique(dbsRes$clust)) - 1, dbsResText)
            dbsResText <- gsub(groupNum, length(unique(dbsRes$group)) - 1, dbsResText)

            print(dbsResText)

            output$dbsText <- renderText({
                dbsResText
            })

            data <- data.frame(cluster = array(unlist(dbsRes$cluster)), group = array(unlist(dbsRes$group)))
            #data <- array(c(1:length(data), data), c(length(data), 2))
            write.csv(data, tempfilename)
        }

        if (input$sendToNewContainerDC == 1 && file.exists(tempfilename) && notNullNaEmpty(input$newConteinerDC)) {
            data <- read.csv(tempfilename)
            if (compareNA(match("na", names(collectionOptions)), NA)) {
                print(data)
                data <- data[-1]
                print(data)
                data <- sendDataToDB(data, gsub(" ", "", input$newConteinerDC))
                addNewNameToCollection(input$newConteinerDC)
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
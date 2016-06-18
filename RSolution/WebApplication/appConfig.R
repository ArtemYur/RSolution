#=================================================================================================
# Libs and settings ==============================================================================
options(rgl.useNULL = TRUE)
library(shiny)
library(stringr)
library(shinyRGL)
library(rgl)
library(mongolite)
library(RCurl)
library(httr)
library(ggplot2)

options(mongodb = list(
      "host" = "ds064628.mlab.com:64628",
      "username" = "Admin",
      "password" = "me"))
databaseName <- "fbme"
collectionName <- "localClinic"
apiKey <- "wmMG33o5YrQm2WnvkvdwMS5iGyXwtFPP"
dbnReplace <- "{databaseName}"
dbnReplacePattern <- "/{databaseName/}"
collectionsUrl <- paste("https://api.mlab.com/api/1/databases/", dbnReplace, "/collections?apiKey=wmMG33o5YrQm2WnvkvdwMS5iGyXwtFPP", sep = "")
collectionOfCollections <- "collectionNames"

loadDataFromCollection <- function(collection_name) {
    # Connect to the database
    db <- mongo(collection = collection_name,
                  url = sprintf(
                    "mongodb://%s:%s@%s/%s",
                    options()$mongodb$username,
                    options()$mongodb$password,
                    options()$mongodb$host,
                    databaseName))
    # Read all the entries
    data <- db$find()
    data
}


getCollectionList <- function() {
    collectionList <- loadDataFromCollection(collectionOfCollections)$name;
    listOptions <- list()
    for (i in 1:length(collectionList)) {
        listOptions[collectionList[i]] <- i
    }
    listOptions
}

collectionOptions <- getCollectionList()
classCode <- collectionOptions
classCode["none"] <- 0
columnClassCode <- list(none=0)
selectorNames <- c()
plot3dHref <- "https://fbme2015.shinyapps.io/Plot3d/"

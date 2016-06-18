sendDataToDB <- function(data, collection_name) {
    tryCatch({
        # Connect to the database
        db <- mongo(collection = collection_name,
                    url = sprintf(
                    "mongodb://%s:%s@%s/%s",
                    options()$mongodb$username,
                    options()$mongodb$password,
                    options()$mongodb$host,
                    databaseName))
        # Insert the data into the mongo collection as a data.frame
        dataFrame <- as.data.frame(data)
        db$insert(dataFrame)
        flagForSuccessUpload <- "flagForSuccessUpload"
        # An observer is used to send messages to the client.
        # The message is converted to JSON
        data <- NULL
    }, error = function(e) {
        errorMessage <- e
        flagForSuccessUpload <- "error"
    })
}


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

loadFirstRecord <- function(collection_name) {
    # Connect to the database
    db <- mongo(collection = collection_name,
                      url = sprintf(
                        "mongodb://%s:%s@%s/%s",
                        options()$mongodb$username,
                        options()$mongodb$password,
                        options()$mongodb$host,
                        databaseName))
    # Read all the entries
    record <- db$find(limit = 1)
    record
}

addNewNameToCollection <- function(name) {
    sendDataToDB(list("name" = name), collectionOfCollections)
}
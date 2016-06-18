# Create a random name for the temp file
tempfilename <- paste0('tempfile',
                        floor(runif(1, 1e+05, 1e+06 - 1)),
                        '.csv')
flagForSuccessUpload <- ""
errorMessage <- ""

compareNA <- function(v1, v2) {
    # This function returns TRUE wherever elements are the same, including NA's,
    # and false everywhere else.
    same <- (v1 == v2) | (is.na(v1) & is.na(v2))
    same[is.na(same)] <- FALSE
    return(same)
}

notNullNaEmpty <- function(value) {
    if (!(compareNA(value, NA) || is.null(value) || compareNA(value, ""))) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}

refreshCollectionNames <- function() {
    collectionOptions <- getCollectionList()
    collectionOptions
}

compare <- function(v1, v2) {
    lv1 <- length(v1)
    lv2 <- length(v2)
    if (lv1 <= 0 && lv2 <= 0 && lv1 != lv2) {
        return(FALSE)
    }
    v1 <- v1[order(v1)]
    v2 <- v2[order(v2)]
    j <- 1
    for (v in v1) {
        if (v != v2[j]) {
            return(FALSE)
        }
        j <- j + 1
    }
    return(TRUE)
}

getClassesColumn <- function() {
    record <- loadFirstRecord(names(collectionOptions[as.integer(input$selectCollectionP2dClass)]))
    schema <- c(names(record), "none")
    columnClassCode <- list()
    if (!compare(schema, names(columnClassCode))) {
        j <- 1
        for (name in schema) {
            columnClassCode[name] <- j
            j <- j + 1
        }
    }
    columnClassCode["none"] <- 0
    return(columnClassCode)
}
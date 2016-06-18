source("appConfig.R")
source("serverConfig.R")

shinyServer(function(input, output, session) {

    # Data Manipulation ===================================================================================================

    # file uploading controller
    source("ServerScripts/Controllers/DataManipulation/fileUploading.R")
    fileUploadingController(input, output, session);

    # Open exisitng collection
    source("ServerScripts/Controllers/DataManipulation/openCollection.R")
    openCollectionController(input, output, session);

    # file downloading controller
    source("ServerScripts/Controllers/DataManipulation/fileDownloading.R")
    fileDownloadingController(input, output, session);

    #creating record
    source("ServerScripts/Controllers/DataManipulation/createRecord.R")
    createRecordController(input, output, session);

    # deleting collection
    source("ServerScripts/Controllers/DataManipulation/deleteCollection.R")
    deleteCollectionController(input, output, session);
    #======================================================================================================================


    # Calculation controllers =============================================================================================

    # Factor Analyze
    source("ServerScripts/Controllers/Calculation/factorAnalyze.R")
    factorAnalyzeController(input, output, session);

    # Density clustering
    source("ServerScripts/Controllers/Calculation/densityClustering.R")
    densityClusteringController(input, output, session);

    # Improved Density clustering
    source("ServerScripts/Controllers/Calculation/improvedDensityClustering.R")
    improvedDensityClusteringController(input, output, session);
    #======================================================================================================================


    # Plots ===============================================================================================================

    # plot 2d controller
    source("ServerScripts/Controllers/Plot/plot2d.R")
    plot2dController(input, output, session);

    # knnDisPlot
    source("ServerScripts/Controllers/Plot/knnPlot.R")
    knnPlotController(input, output, session);
    #======================================================================================================================

    observe({
        collectionOptions <- getCollectionList()

        # data manipulation
        updateSelectInput(session, "selectCollection",
            label = "Target collection",
            choices = collectionOptions,
            selected = 1)
        updateSelectInput(session, "selectCollectionToDelete",
                    label = "Target collection",
                    choices = collectionOptions,
                    selected = 1)
        updateSelectInput(session, "selectCollectionDownLoadFile",
                                        label = "Target collection",
                                        choices = collectionOptions,
                                        selected = 1)
        updateSelectInput(session, "selectCollectionCreate",
                                        label = "Target collection",
                                        choices = collectionOptions,
                                        selected = 1)
        updateSelectInput(session, "selectCollectionToOpen",
                                                label = "Target collection",
                                                choices = collectionOptions,
                                                selected = 1)


        # Calculations
        updateSelectInput(session, "selectCollectionFA",
                                        label = "Target collection",
                                        choices = collectionOptions,
                                        selected = 1)

        updateSelectInput(session,
                "selectCollectionDC",
                        label = "Target collection",
                        choices = collectionOptions,
                        selected = 1)

        updateSelectInput(session,
                        "selectCollectionIDC",
                                label = "Target collection",
                                choices = collectionOptions,
                                selected = 1)

        # Plots
        updateSelectInput(session,
                "selectCollectionP2d",
                        label = "Target collection",
                        choices = collectionOptions,
                        selected = 1)
        updateSelectInput(session,
                "selectCollectionP2dClass",
                        label = "Classes collection",
                        choices = collectionOptions,
                        selected = 1)

        #updateSelectInput(session, "selectColumnP2dClass",
                                        #label = "Class column",
                                        #choices = columnClassCode,
                                        #selected = 0)
        updateSelectInput(session,
                "selectCollectionKnnP",
                        label = "Target collection",
                        choices = collectionOptions,
                        selected = 1)

    })
})
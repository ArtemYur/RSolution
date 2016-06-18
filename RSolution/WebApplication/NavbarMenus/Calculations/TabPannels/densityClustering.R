selectorNames <- c(selectorNames, "selectCollectionDC")
 
densityClusteringPanel <- tabPanel("Improved Density Clustering",
    titlePanel("Improved Density Clustering"),
    sidebarLayout(
        sidebarPanel(selectInput("selectCollectionDC",
                label = p("Target collection"),
                choices = collectionOptions,
                selected = 1),
            tags$hr(),
            actionButton("startAlgorithmDC", label = "Start"),
            tags$hr(),
            textInput("newConteinerDC", label = p("New Container:"), value = ""),
            actionButton("sendToNewContainerDC", label = "Save Results")),
        mainPanel(
            verbatimTextOutput("dbsText"),
            tabPanel('densityClustering', DT::dataTableOutput('dbsTable')))))
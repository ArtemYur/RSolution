selectorNames <- c(selectorNames, "selectCollectionIDC")
 
improvedDensityClusteringPanel <- tabPanel("Density Clustering",
    titlePanel("Density Clustering"),
    sidebarLayout(
        sidebarPanel(selectInput("selectCollectionIDC",
                label = p("Target collection"),
                choices = collectionOptions,
                selected = 1),
            tags$hr(),
            textInput("epsIDC", label = p("Eps"), value = ""),
            tags$hr(),
            actionButton("startAlgorithmIDC", label = "Start"),
            tags$hr(),
            textInput("newConteinerIDC", label = p("New Container:"), value = ""),
            actionButton("sendToNewContainerIDC", label = "Save Results")),
        mainPanel(
            verbatimTextOutput("idbsText"),
            tabPanel('improvedDensityClustering', DT::dataTableOutput('idbsTable')))))
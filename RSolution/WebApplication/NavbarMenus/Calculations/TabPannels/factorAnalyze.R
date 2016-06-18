selectorNames <- c(selectorNames, "selectCollectionFA")

factorAnalyzePannel <- tabPanel("Factor Analyze",
    titlePanel("Factor Analyze"),
    sidebarLayout(
        sidebarPanel(selectInput("selectCollectionFA",
                label = p("Target collection"),
                choices = collectionOptions,
                selected = 1),
            tags$hr(),
            textInput("knnMeasure", label = p("KNN Measure:"), value = "0.6"),
            selectInput("rotationInput",
                            label = p("Rotation"),
                            choices = rotationList,
                            selected = 1),
            tags$hr(),
            actionButton("startAlgorithmFA", label = "Start"),
            tags$hr(),
            textInput("newConteinerFA", label = p("New Container:"), value = ""),
            actionButton("sendToNewContainerFA", label = "Save Results")),
        mainPanel(
            tabPanel('factorAnalyze', DT::dataTableOutput('faTable')))))
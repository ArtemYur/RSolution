knnPlotPanel <- tabPanel("KNN Plot",
    titlePanel("KNN Plot"),
    sidebarLayout(
        sidebarPanel(selectInput("selectCollectionKnnP",
                label = p("Target collection"),
                choices = collectionOptions,
                selected = 1),
            tags$hr(),
            actionButton("renderKnnP", label = "Render")),
                                            mainPanel(
                                                plotOutput("knnPlot"))))

selectorNames <- c(selectorNames, "selectCollectionKnnP")
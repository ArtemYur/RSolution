plot2DPanel <- tabPanel("Plot 2d",
    titlePanel("Plot 2d"),
    sidebarLayout(
        sidebarPanel(selectInput("selectCollectionP2d",
                label = p("Target collection"),
                choices = collectionOptions,
                selected = 1),
            tags$hr(),
            selectInput("selectCollectionP2dClass",
                            label = p("Classes collection"),
                            choices = classCode,
                            selected = 0),
            selectInput("selectColumnP2dClass",
                                        label = p("Class column"),
                                        choices = columnClassCode,
                                        selected = 0),
            tags$hr(),
            actionButton("renderPlot2d", label = "Render")),
                                            mainPanel(
                                                plotOutput("plot2d"))))

selectorNames <- c(selectorNames, "selectCollectionP2d")
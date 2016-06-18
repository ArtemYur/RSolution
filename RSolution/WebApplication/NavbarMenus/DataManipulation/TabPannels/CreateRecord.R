createRecordPanel <- tabPanel("Create Record",
    titlePanel("Create Record"),
    sidebarLayout(
        sidebarPanel(selectInput("selectCollectionCreate",
            label = p("Target collection"),
            choices = collectionOptions,
            selected = 1),
            actionButton("getInputForm", label = "Get Input Form")),
        mainPanel(
            actionButton("submit", label = "Submit"),
            uiOutput("createRecordContents"))))

selectorNames <- c(selectorNames, "selectCollectionCreate")
deleteFilePanel <- tabPanel("Delete Container", titlePanel("Delete Container"),
            sidebarLayout(
                        sidebarPanel(
                                    selectInput("selectCollectionToDelete",
                                        label = p("Target collection"),
                                        choices = collectionOptions,
                                        selected = 1),
                                    actionButton("deleteCollection", label = "Delete Collection")),
                                                mainPanel(
                                                    tableOutput('deletecollectionContents'))))

selectorNames <- c(selectorNames, "selectCollectionToDelete")
openCollectionPanel <- tabPanel("Open Container", titlePanel("Open Container"),
            sidebarLayout(
                        sidebarPanel(
                                    selectInput("selectCollectionToOpen",
                                        label = p("Target collection"),
                                        choices = collectionOptions,
                                        selected = 1),
                                    actionButton("openCollection", label = "Open Collection")),
                                                mainPanel(
                                                    tabPanel('openCollectionContents', DT::dataTableOutput('collectionTable')))))

selectorNames <- c(selectorNames, "selectCollectionToOpen")
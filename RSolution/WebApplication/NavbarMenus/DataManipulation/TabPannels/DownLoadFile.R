downloadFilePanel <- tabPanel("Download File",
    titlePanel("Downlad File"),
        sidebarLayout(
            sidebarPanel(selectInput("selectCollectionDownLoadFile",
                label = p("Target collection"),
                choices = collectionOptions,
                selected = 1),
                #checkboxGroupInput('show_vars', 'Columns in diamonds to show:',
#names(outdownloadedContents), selected = names(downloadedContents)),
downloadButton('downloadCollection', 'Download')),
            mainPanel(
                tableOutput('downloadedContents'))))

selectorNames <- c(selectorNames, "selectCollectionDownLoadFile")
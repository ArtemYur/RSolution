fileUploadingPanel <- tabPanel("File Uploading",
                                titlePanel("Uploading Files"),
                                                      sidebarLayout(
                                                          sidebarPanel(
                                                            fileInput('file1', 'Choose CSV File',
                                                                      accept = c('text/csv',
                                                                                       'text/comma-separated-values,text/plain',
                                                                                       '.csv')),
                                                            tags$hr(),
                                                            checkboxInput('header', 'Header', TRUE),
                                                            radioButtons('sep', 'Separator',
                                                                         c(Comma = ',',
                                                                           Semicolon = ';',
                                                                           Tab = '\t'),
                                                                         ','),
                                                            radioButtons('quote', 'Quote',
                                                                         c(None = '',
                                                                           'Double Quote' = '"',
                                                                           'Single Quote' = "'"),
                                                                         '"'),
                                                              tags$hr(),

                                                          selectInput("selectCollection", label = p("Target collection"),
                                                                      choices = collectionOptions,
                                                                      selected = 1),

                                                          actionButton("sendToExistingCollection", label = "Send to Collection"),

                                                        tags$hr(),
                                                        textInput("newConteiner", label = p("New Container:"), value = "Enter name..."),
                                                        actionButton("sendToNewContainer", label = "Send to db")),

                                                                                                              mainPanel(
                                                                                                                tableOutput('uploadedContents'))),
                                                            # This makes web page load the JS file in the HTML head.
# The call to singleton ensures it's only included once
# in a page. It's not strictly necessary in this case, but
# it's good practice.
singleton(
                                                                    tags$head(tags$script(src = "message-handler.js"))))

selectorNames <- c(selectorNames, "selectCollection")
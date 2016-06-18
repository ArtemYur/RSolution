source("appConfig.R")
source("uiConfig.R")
 
shinyUI(fluidPage(
    navbarPage("R science",
        #there should locate navbarMenus
tabPanel("Home Page"),
        DataManipulationNavBarMenu,
        CalculationsNavBarMenu,
        PlotsNavBarMenu,
        tabPanel("Summary"))))
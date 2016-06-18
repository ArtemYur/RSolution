source("NavbarMenus/Plots/TabPannels/plot2dPannel.R")
source("NavbarMenus/Plots/TabPannels/kNNdistplot.R")

PlotsNavBarMenu <- navbarMenu("Plots",
    plot2DPanel,
    tabPanel(a("Plot 3d", href = plot3dHref, target = "_blank")),
    knnPlotPanel)
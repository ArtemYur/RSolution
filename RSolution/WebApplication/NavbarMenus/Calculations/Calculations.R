source("NavbarMenus/Calculations/TabPannels/densityClustering.R")
source("NavbarMenus/Calculations/TabPannels/factorAnalyze.R")
source("NavbarMenus/Calculations/TabPannels/improvedDensityClustering.R")

CalculationsNavBarMenu <- navbarMenu("Calculations",
        factorAnalyzePannel,
        densityClusteringPanel,
        improvedDensityClusteringPanel)
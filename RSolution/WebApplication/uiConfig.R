set_config(config(ssl_verifypeer = 0L))
rotationList <- list("none" = 2, "varimax" = 1, "promax" = 3, "equamax" = 4, "oblimin" = 5)

#print(getwd())
#print(list.files())
#setwd("NavbarMenus")
#print(list.files())
#setwd("DataManipulation")
#print(list.files())
#print(getwd())

source("NavbarMenus/DataManipulation/DataManipulation.R")
source("NavbarMenus/Calculations/Calculations.R")
source("NavbarMenus/Plots/plots.R")
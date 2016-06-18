source("NavbarMenus/DataManipulation/TabPannels/FileUploading.R")
source("NavbarMenus/DataManipulation/TabPannels/CreateRecord.R")
source("NavbarMenus/DataManipulation/TabPannels/DeleteContainer.R")
source("NavbarMenus/DataManipulation/TabPannels/DownLoadFile.R")
source("NavbarMenus/DataManipulation/TabPannels/openCollection.R")

DataManipulationNavBarMenu <- navbarMenu("Data Manipulation",
                        fileUploadingPanel,
                        openCollectionPanel,
                        deleteFilePanel,
                        downloadFilePanel,
                        createRecordPanel)
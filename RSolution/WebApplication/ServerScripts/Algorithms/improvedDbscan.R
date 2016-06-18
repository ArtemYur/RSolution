getNClust <- function(data) {
    ev <- eigen(cor(t(data)))
    return(length(which(ev$values > 1)) + 1)
}

dbscanImproved <- function(data, eps, nclust = NULL) {
    library(dbscan)

    db <- NULL
    eps0 <- eps
    if (!is.null(nclust)) {
        maxClust <- 0
        maxEps <- eps
        maxPts <- ncol(data) + 1
        nPts <- ncol(data) + 1
        df <- data.frame(clusters = numeric(), eps = numeric(), noise = numeric())
        db = dbscan(data, eps, ncol(data) + 1)
        while ((is.null(db) || eps > 0) && length(which(db$cluster == 0)) != nrow(data)) {

            db = dbscan(data, eps, ncol(data) + 1)

            if (length(unique(db$cluster)) - 1 != nclust) {
                if (length(unique(db$cluster)) - 1 > maxClust) {
                    maxClust = length(unique(db$cluster)) - 1
                    maxEps = eps
                    maxPts = nPts
                }
                eps <- eps - 0.001 * eps0
            } else {
                maxClust = length(unique(db$cluster)) - 1
                maxEps = eps
                maxPts = nPts
                break;
            }
        }

        db = dbscan(data, maxEps, ncol(data) + 1)

        print("BEST")
        print(paste("Clusters: ", length(unique(db$cluster)) - 1))
        print(paste("Eps: ", maxEps))
        print(paste("Noise: ", length(which(db$cluster == 0))))

    } else {
        db = dbscan(data, eps, ncol(data) + 1)
    }
    return(db)
}

executeImprovedDbscan <- function(data, eps) {
    return(dbscanImproved(data, eps, getNClust(data)))
}

dbscanImp <- function(data, eps, nclust = NULL) {
    library(dbscan)
    db <- NULL
    eps0 <- eps
    if (!is.null(nclust)) {
        maxClust <- 0
        maxEps <- eps
        maxPts <- ncol(data) + 1
        nPts <- ncol(data) + 1
        db = dbscan(data, eps, ncol(data) + 1)
        while ((is.null(db) || eps > 0) && length(which(db$cluster == 0)) != nrow(data)) {

            db = dbscan(data, eps, nPts)

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
        print(paste("Input data: ", dim(data)))
        print(paste("Clusters: ", length(unique(db$cluster)) - 1))
        print(paste("Eps: ", maxEps))
        print(paste("Noise: ", length(which(db$cluster == 0))))

    } else {
        db = dbscan(data, eps, ncol(data) + 1)
    }
    return(db)
}

getNClust <- function(data) {
    ev <- eigen(cor(t(data)))
    return(length(which(ev$values > 1)) + 1)
}

getEps <- function(data) {
    library(dbscan)
    arrDist <- array(c(kNNdist(data, ncol(data) + 1)))
    return(mean(arrDist) + sd(arrDist)) # + 4 * sd(reachDist))
}

#which(dbs$cluster == 0)
getObjectsByIndexes <- function(data, indexes) {
    if (length(indexes) > 0) {
        df <- NULL #data.frame(data[indexes[1],])
        j <- 1
        for (i in indexes) {
            df <- rbind(df, data.frame(data[i,]))
        }
        return(df)
    }
    return(NA)
}

replaceNoise <- function(clusters, indexesN, clustersN) {
    if (length(clustersN) > 0) {
        j <- 1
        for (c in clustersN) {
            clusters[indexesN[j]] <- c
            j <- j + 1
        }
    }
    return(clusters)
}

getGroups <- function(goups, indexes, group) {
    if (length(indexes) > 0) {
        j <- 1
        for (i in indexes) {
            goups[i] <- group
        }
    }
    return(goups)
}


dbscanFin <- function(data, bias = 0, group = 1) {
    eps <- getEps(data)
    print(paste("CHOSED EPS: ", eps))
    dbs <- dbscanImp(data, eps, getNClust(data))
    nInndexes <- array(which(dbs$cluster == 0))
    dbs$group <- getGroups(integer(nrow(data)), array(which(dbs$cluster != 0)), group)
    noise <- getObjectsByIndexes(data, nInndexes)
    if (!is.na(noise) && nrow(noise) > ncol(data)) {
        dbsN <- dbscanFin(noise, length(unique(dbs$cluster)) - 1, group + 1)
        dbs$cluster <- replaceNoise(dbs$cluster, nInndexes, dbsN$cluster)
        dbs$group <- replaceNoise(dbs$group, nInndexes, dbsN$group)
    }
    dbs$cluster <- dbs$cluster + bias
    dbs$cluster <- replace(dbs$cluster, dbs$cluster == bias, 0)
    return(dbs)
}
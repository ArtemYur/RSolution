df <- data.frame()
clust <- array(unlist(dbs$cluster))
for (i in 1:nrow(clust)) {
    if (dbs$cluster[i] != 0) {
        df <- rbind(df, data[i,])
    }
}
KMO_measure <- function(x) {
    x <- subset(x, complete.cases(x)) # Omit missing values
    r <- cor(x) # Correlation matrix
    r2 <- r ^ 2 # Squared correlation coefficients
    i <- solve(r, tol = 1e-30) # Inverse matrix of correlation matrix
    d <- diag(i) # Diagonal elements of inverse matrix
    p2 <- ( - i / sqrt(outer(d, d))) ^ 2 # Squared partial correlation coefficients
    diag(r2) <- diag(p2) <- 0 # Delete diagonal elements
    KMO <- sum(r2) / (sum(r2) + sum(p2))
    MSA <- colSums(r2) / (colSums(r2) + colSums(p2))
    return(list(KMO = KMO, MSA = MSA))
}


getFactors <- function(data, measureType = "nkaiser", score = "regression", rotation = "varimax") {
    library(nFactors)
    ev <- eigen(cor(data)) # get eigenvalues
    ap <- parallel(subject = nrow(data), var = ncol(data), rep = 100, cent = .05)
    nS <- nScree(x = ev$values, aparallel = ap$eigen$qevpea)
    # Maximum Likelihood Factor Analysis
    # entering raw data and extracting 3 factors, 
    # with varimax rotation 
    # nS$Components has {$noc, $naf, $npar, $nkaiser, ...}
    # scores = c("none", "regression", "Bartlett")
    fit <- factanal(data, nS$Components[measureType][[1]], scores = c(score), rotation = rotation)
    return(fit$scores);
}
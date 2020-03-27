rm(list=ls()) #clears the Environment in R

##### redefines the 'require' function to either install a new package OR load an already installed package from the library #####
require <- function(x) {if (!base::require(x, character.only = TRUE)) {install.packages(x, dep = TRUE) ; base::require(x, character.only = TRUE)}}#overwrites 'require' function to install missing packages

source("makeVector.R")

source("cachemean")

test1 <- makeVector()
test1$set(1:5)

test1$get()

cachemean(test1)

cachemean(test1)

makeCacheMatrix <- function(x = numeric()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setsolve <- function(solve) m <<- solve
        getsolve <- function() m
        list(set = set, get = get,
             setsolve = setsolve,
             getsolve = getsolve)
}

m1 <- matrix( c(4, 2, 2,
                2, 3, 1,
                2, 1, 3), nrow=3, byrow=TRUE)
m1

solve(m1)

cacheSolve <- function(x, ...) {
        m <- x$getsolve()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- solve(data, ...)
        x$setsolve(m)
        m
}
test <- cacheSolve()

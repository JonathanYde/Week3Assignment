rm(list=ls()) #clears the Environment in R

##### redefines the 'require' function to either install a new package OR load an already installed package from the library #####
require <- function(x) {if (!base::require(x, character.only = TRUE)) {install.packages(x, dep = TRUE) ; base::require(x, character.only = TRUE)}}#overwrites 'require' function to install missing packages

source("makeVector.R") #sources the makeVector function that was supplied with the assignment from a separate file

source("cachemean") #sources the cachemean function that was supplied with the assignment from a separate file

test1 <- makeVector() #initiates a test
test1$set(1:5) #creates a vector "test1" from 1 to 5

test1$get() #returns the vector

cachemean(test1) #calculates the mean and saves it in the cache

cachemean(test1) #returns the mean from the cache

##### HERE COMES MY ATTEMPT AT SOLVING THE ASSIGNMENT #####

##### FIRST I CREATE THE makeCacheMatrix FUNCTION #####
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

##### HERE I MANUALLY CREATE A MATRIX m1 AND CALCULATES THE INVERSE THE MATRIX, SO I CAN COMPARE WITH MY RESULT FROM THE LAST FUNCTION #####
m1 <- matrix( c(4, 2, 2,
                2, 3, 1,
                2, 1, 3), nrow=3, byrow=TRUE) #creates the matrix "m1"
m1

solve(m1) #returns the inverse matrix of "m1"

m1 %*% solve(m1) #returns the result of multiplying m1 with its inverse matrix


##### HERE I CREATE THE cacheSolve FUNCTION #####
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

#### HERE I TEST THAT MY TWO FUNCTIONS WORK
test2 <- makeCacheMatrix() #initiates a test

test2$set(matrix( c(4, 2, 2,
                    2, 3, 1,
                    2, 1, 3), nrow=3, byrow=TRUE)) #creates the matrix "test2" similar to "m1"

test4 <- test2$get()

test3 <- cacheSolve(test2)

test4 %*% test3

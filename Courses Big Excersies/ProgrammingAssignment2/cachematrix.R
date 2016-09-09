
## We will be creating a two function structure that given an input matrix "x"
## will enable us to cache its inverse ("inv") and access it without 
## computing it everytime as long as "x" does not change.


## makeCacheMAtrix is the function that will store our input matrix "x"
## and its inverse ("inv"). 
## makeCacheMatrix is actually a list containing functions that will enable us to:
## 1) set & get the value of the matrix "x"
## 2) set & get the inverse of the matrix "x"

makeCacheMatrix <- function(x = matrix()) {
    ## store inverse matrix. NULL when not set.
    inv <- NULL
    
    ## matrix "x" set & get functions
    set <- function(newMatrix) {
        x <<- newMatrix
        ## reset "inv" matrix.
        inv <<- NULL
    }
    get <- function() x
    
    ## inverse matrix "inv" set & get functions
    setInverse <- function(invMatrix) inv <<- invMatrix
    getInverse <- function() inv
    
    ## link functions to list
    list(set = set, get = get, 
         setInverse = setInverse, 
         getInverse = getInverse)
}


## cacheSolve returns the inverse matrix of a makeCacheMatrix object "x" in two ways:
## 1) Inverse Matrix is Not Set: Computes it, stores it and returns it.
## 2) Inverse Matrix is Cached: Gets the data and returns it.

cacheSolve <- function(x, ...) {
    ## Get the value of "x" inverse matrix
    inv <- x$getInverse()
    
    ## if the Inverse Matrix is cached (not NULL): Case 2
    if(!is.null(inv)) {
        message("return inverse cached matrix")
        return(inv)
    }
    
    ## if the Inverse Matrix is not set: Case 1
    currentMatrix <- x$get()
    invMatrix <- solve(currentMatrix)
    x$setInverse(invMatrix)
    invMatrix
}

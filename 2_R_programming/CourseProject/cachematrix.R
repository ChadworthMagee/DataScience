## This second programming assignment will require you to write an R function is able to cache potentially time-consuming computations. For example, taking the mean of a numeric vector is typically a fast operation. However, for a very long vector, it may take too long to compute the mean, especially if it has to be computed repeatedly (e.g. in a loop). If the contents of a vector are not changing, it may make sense to cache the value of the mean so that when we need it again, it can be looked up in the cache rather than recomputed. 

## In this Programming Assignment will take advantage of the scoping rules of the R language and how they can be manipulated to preserve state inside of an R object.


#The first function, makeCacheMatrix creates a special "vector", which is really a list containing a function to
# set the value of the cacheMatrix
# get the value of the cacheMatrix
# set the value of the inverse
# get the value of the inverse

makeCacheMatrix <- function(x = matrix()) 
{
        m <- NULL
        
        set <- function(y) 
        {
                x <<- y
                m <<- NULL
        }
        
        
        get <- function() x
        
        
        setSolve <- function(solve)
        {
                m <<- solve
        }
        
        getSolve <- function() 
        {
                m
        }
        list(set = set, get = get,
             setSolve = setSolve,
             getSolve = getSolve)

}


## The following function calculates the mean of the special matrix created with the above function. However, it first checks to see if the inverse has already been created. If so, it gets the inverse from the cache and skips the computation. Otherwise, it creates the inverse of the data and sets the value of the inverse in the cache via the setSolve function.

cacheSolve <- function(x, ...) 
{
        m <- x$getSolve()
        
        if(!is.null(m)) 
        {
                message("getting cached data")
                return(m)
        }
        
        data <- x$get()
        
        m <- solve(data, ...)
        
        x$setSolve(m)
        
        m
        ## Return a matrix that is the inverse of 'x'
}

# clear environment when starting test: rm(list=ls(all=TRUE)) 
# test script: https://class.coursera.org/rprog-002/forum/thread?thread_id=177#post-1941

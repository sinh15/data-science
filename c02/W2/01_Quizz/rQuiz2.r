#seq_along(x) (create sequence based on length of vector)

#Question 1
#Expected reuslt 27
cube <- function(x, n) {
  x^3
}

cube(3)

#Question 2
#Expecte result trying to conmpare in the if length 10 vs length 1
x <- 1:10
if(x > 5) {
  x <- 0
}


#Question 3
#Expected result = 10
f <- function(x) {
  g <- function(y) {
    y + z
  }g
  z <- 4
  x + g(x)
}

z <- 10
f(3)

#NOTES FROM VIDEO
#how to remove na on mean, sd, etc.
#naming arguments, means no order is required
#you can even mix some by name and others by position LOL
#you can even do partially matching on argument names, as long as only one is matched.
#order of checks:
#1 - Check for exact match or named argument
#2 - Check for a partial match
#3 - Check for a positional match
sd(x=myData, na.rm = FALSE)

#Question 4
# Expected result y = 10
x <- 5
y <- if(x < 3) {
  NA
} else {
  10
}

#Question 5
#Free variable (f) expected. Means that variable not defined / modified on this scope
h <- function(x, y = NULL, d = 3L) {
  z <- cbind(x, d)
  if(!is.null(y))
    z <- z + y
  else
    z <- z + f
  g <- x + y / z
  if(d == 3L)
    return(g)
  g <- g + 10
  g
}



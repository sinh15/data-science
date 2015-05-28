best <- function(state, outcome) {
    ## Read Outcome Data
    data <- read.csv(file="outcome-of-care-measures.csv", header=T, sep=",", colClasses = "character")
    
    ## if nrow for given state == 0, throw error
    ## we start segmentating our sample
    data <- data[data$State == state, ]
    if(nrow(data) == 0) stop("invalid state")
    
    ## if outcome not one of the asked three, throw error
    ## we finish the DD segmentation
    if(outcome == "heart attack") cOutcome <- 11
    else if(outcome == "heart failure") cOutcome <- 17
    else if(outcome == "pneumonia") cOutcome <- 23
    else stop("invalid outcome")
    
    ## Return hospital name in that state with lower 30d death rate.
    dRows <- nrow(data)
    currentMinimum = 100.00
    names = character()
    current = 1

    for(i in c(1:dRows)) {
        if(data[i, cOutcome] != "Not Available") {
            if(currentMinimum > as.numeric(data[i, cOutcome])) {
                current = 1
                names = character()
                currentMinimum <- as.numeric(data[i, cOutcome])
                names[current] <- data[i, 2]
                current = current + 1
            }
            else if(currentMinimum == as.numeric(data[i, cOutcome])) {
                names[current] <- data[i, 2]
                current = current + 1
            }
        }
    }
    ##View(names)
    ##hospitalName
    names <- sort(names)
    names[1]
}
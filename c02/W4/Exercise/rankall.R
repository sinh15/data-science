rankall <- function(outcome, num = "best") {
    ## Read Outocme Data
    data <- read.csv(file="outcome-of-care-measures.csv", header=T, sep=",", colClasses = "character")
    
    ## Check outcome is valid
    if(outcome == "heart attack") cOutcome <- 11
    else if(outcome == "heart failure") cOutcome <- 17
    else if(outcome == "pneumonia") cOutcome <- 23
    else stop("invalid outcome")
    
    ## For each state find the hospital of the given rank
    levels <- sort(unique(data[, 7]))
    result <- data.frame(matrix(ncol = 2, nrow = 0))
    colnames(result) <- c("hospital", "state")
    
    for(i in c(1:length(levels))) {
        ## we create smaller dd
        stateData <- data[data$State == levels[i], ]
        
        ## we prepare for loop
        dRows <- nrow(stateData)
        vOutcome = numeric()
        vHospital = character()
        count = 1
        
        for(j in c(1:dRows)) {
            if(stateData[j, cOutcome] != "Not Available") {
                vOutcome[count] <- as.numeric(stateData[j, cOutcome])
                vHospital[count] <- stateData[j, 2]
                count = count + 1
            }
        }
        
        ## we combine and sort the results
        rMatrix <- cbind(vHospital, vOutcome)
        rMatrix <- as.matrix(rMatrix[order(as.numeric(rMatrix[,2]), rMatrix[,1]), ])
        
        ## we select with hospital goes to the data frame
        if(num == "best") result[i, ] <- c(rMatrix[1, 1], levels[i])
        else if(num == "worst") result[i, ] <- c(rMatrix[nrow(rMatrix), 1], levels[i])
        else if(num <= nrow(rMatrix)) result[i, ] <- c(rMatrix[num], levels[i])
        else result[i, ] <- c("<NA>", levels[i])
    }
    
    ## Return a data frame with the hospital names and state
    result
}
rankhospital <- function(state, outcome, num = "best") {
    ## Read Outcome Data
    data <- read.csv(file="outcome-of-care-measures.csv", header=T, sep=",", colClasses = "character")
    
    ## Check that sate and outcome are valid
    data <- data[data$State == state, ]
    if(nrow(data) == 0) stop("invalid state")

    if(outcome == "heart attack") cOutcome <- 11
    else if(outcome == "heart failure") cOutcome <- 17
    else if(outcome == "pneumonia") cOutcome <- 23
    else stop("invalid outcome")
    
    ## Return hospital name in the state with given rank
    dRows <- nrow(data)
    vOutcome = numeric()
    vHospital = character()
    count = 1

    for(i in c(1:dRows)) {
        if(data[i, cOutcome] != "Not Available") {
            vOutcome[count] <- as.numeric(data[i, cOutcome])
            vHospital[count] <- data[i, 2]
            count = count + 1
        }
    }
    
    rMatrix <- cbind(vHospital, vOutcome)
    rMatrix <- as.matrix(rMatrix[order(as.numeric(rMatrix[,2]), rMatrix[,1]), ])
    
    ## check position
    if(num == "best") result <- rMatrix[1, 1]
    else if(num == "worst") result <- rMatrix[nrow(rMatrix), 1]
    else if(num <= nrow(rMatrix)) result <- rMatrix[num, 1]
    else result <- "NA"
#     
#     View(rMatrix)
#     View(class(rMatrix[, 2]))
    result
}

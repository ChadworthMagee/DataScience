rankall <- function(outcome, num = "best") 
{
        name <- 'Hospital.Name'
        if(outcome == "heart attack")
        {
                column <- 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack'
        }
        else if (outcome == "heart failure")
        {
                column <- 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure' 
        }
        else if (outcome == "pneumonia")
        {
                column <- 'Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia' 
        }
        else
        {
                stop("invalid outcome")
        }
        
        ## Read outcome data
        csv <- read.table("outcome-of-care-measures.csv", header= TRUE, sep = ",", dec=".")
        #csvOrdered <- ordered <- csv[order((as.character(csv[['State']])), as.numeric(as.character(csv[[column]]))) , ]
        stateList <- unique(csv[['State']])
        hospitalFrame=data.frame(matrix(nrow=0, ncol=2)) 
        colnames(hospitalFrame)[1] <- "state"
        colnames(hospitalFrame)[2] <- "hospital"
        
        for(state in stateList)
        {
                print(state)
                csv_1state <- csv[csv$State == state,]
                if(is.numeric(num))
                {
                        ordered <- csv_1state[order(as.numeric(as.character(csv_1state[[column]])), (as.character(csv_1state[[name]]))) , ]
                        hospitalName <- as.character(ordered$Hospital.Name[num])
                        print(hospitalName)
                }
                else if(num == "worst")
                {
                        orderedDesc <- csv_1state[order(-as.numeric(as.character(csv_1state[[column]])), (as.character(csv_1state[[name]]))), ]
                        hospitalName <- as.character(orderedDesc$Hospital.Name[1])
                }
                else if(num == "best")
                {
                        ordered <- csv_1state[order(as.numeric(as.character(csv_1state[[column]])), (as.character(csv_1state[[name]]))) , ]
                        hospitalName <- as.character(ordered$Hospital.Name[1])
                }
                else
                {
                        stop("invalid num")
                        break
                }
                hospitalFrame <- rbind(hospitalFrame, data.frame(state,hospitalName))
        }
        colnames(hospitalFrame)[1] <- "state"
        colnames(hospitalFrame)[2] <- "hospital"
        View(hospitalFrame)
        hospitalFrame
}
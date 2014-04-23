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
        for(state in stateList)
        {
                print(state)
                csv_1state <- csv[csv$State == state,]
                if(is.numeric(num))
                {
                        ordered <- csv_1state[order(as.numeric(as.character(csv_1state[[column]])), (as.character(csv_1state[[name]]))) , ]
                        hospitalName <- as.character(ordered$Hospital.Name[num])
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
                #ordered <- csv_1state[order(as.numeric(as.character(csv_1state[[column]])), (as.character(csv_1state[[name]]))) , ]
                View(ordered)
                break
        }
}
rankhospital <- function(state, outcome, num = "best") 
{
        ## Read outcome data
        csv <- read.table("outcome-of-care-measures.csv", header= TRUE, sep = ",", dec=".")
        csv_1state <- csv[csv$State == state,]
        
        if(nrow(csv_1state) == 0)
        {
                stop("invalid state")
        }
        
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

        # order by mortality rate
        name <- 'Hospital.Name'
        ordered <- csv_1state[order(as.numeric(as.character(csv_1state[[column]])), (as.character(csv_1state[[name]]))) , ]
        if(is.numeric(num))
        {
                hospitalName <- as.character(ordered$Hospital.Name[num])
        }
        else if(num == "worst")
        {
                orderedDesc <- csv_1state[order(-as.numeric(as.character(csv_1state[[column]])), (as.character(csv_1state[[name]]))), ]
                hospitalName <- as.character(orderedDesc$Hospital.Name[1])
        }
        else if(num == "best")
        {
                hospitalName <- as.character(ordered$Hospital.Name[1])
        }
        hospitalName
        ## Check that state and outcome are valid
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
}
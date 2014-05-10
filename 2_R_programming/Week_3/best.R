best <- function(state, outcome) 
{
        ## Read outcome data
        csv <- read.table("outcome-of-care-measures.csv", header= TRUE, sep = ",", dec=".")
        filter_outcome <- csv[csv$State == state,]

        if(outcome == "heart attack")
        {
                test <- filter_outcome[order(as.numeric(as.character(filter_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))) , ]
        }
        else if (outcome == "heart failure")
        {
                test <- filter_outcome[order(as.numeric(as.character(filter_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))) , ] 
        }
        else if (outcome == "pneumonia")
        {
                test <- filter_outcome[order(as.numeric(as.character(filter_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))) , ]
        }
        #View(test)
        if(nrow(test) == 0)
        {
                stop("invalid state")
        }
        else
        {
                hospital <- as.character(test$Hospital.Name[1])
                print(hospital)
                View(test)
                hospital
        }
        ## Check that state and outcome are valid
        ## Return hospital name in that state with lowest 30-day death
        ## rate
}
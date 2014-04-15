best <- function(state, outcome) 
{
        ## Read outcome data
        csv <- read.table("outcome-of-care-measures.csv", header= TRUE, sep = ",", dec=".")
        filter_outcome <- csv[csv$State == state,]

        if(outcome == "heart attack")
        {
                test <- filter_outcome[order(filter_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack) , ]
        }
        else if (outcome == "heart failure")
        {
                test <- filter_outcome[order(filter_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure) , ] 
        }
        else if (outcome == "pneumonia")
        {
                #print(class(filter_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
                test <- filter_outcome[order(as.numeric(as.character(filter_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))) , ]
                min <- min(as.numeric(as.character(filter_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)))
        }
                
        hospital <- test$Hospital.Name[1]
        #View(test)
        print(hospital)
        #print(min)
        
        ## Check that state and outcome are valid
        ## Return hospital name in that state with lowest 30-day death
        ## rate
}
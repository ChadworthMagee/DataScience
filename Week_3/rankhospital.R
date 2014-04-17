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
        
        
        ordered <- csv_1state[order(as.numeric(as.character(csv_1state$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))) , ]
        ordered2 <- csv_1state[order(as.numeric(as.character(csv_1state[[column]]))) , ]
        
        View(ordered)
        View(ordered2)
        if(is.numeric(num))
        {
                
                        mortRate <- as.character(ordered[column], num)
                        #print(mortRate)
                        
                        #sameMortRate <- ordered$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == as.character(mortRate)
                        #sameMortRate <- ordered[ordered$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == as.character(mortRate),]
                        #View(sameMortRate)
        }
                
        #}
        #else if (outcome == "heart failure")
        #{
        #        ordered <- csv_1state[order(as.numeric(as.character(csv_1state$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))) , ] 
        #        
        #}
        #else if (outcome == "pneumonia")
        #
        #        ordered <- csv_1state[order(as.numeric(as.character(csv_1state$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))) , ]
        #}
        
        
        #View(ordered)
        if(is.numeric(num))
        {
                hospital <- as.character(ordered$Hospital.Name[num])
        }
        else if (num == "worst")
        {
                hospital <- as.character(ordered$Hospital.Name[length(ordered)])
        }
        else if (num == "best")
        {
                
        }
        hospital
        ## Check that state and outcome are valid
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
}
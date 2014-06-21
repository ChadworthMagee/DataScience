
calc <- function()
{
        mean <- 4
        sd <- 0.5
        n <- 100
        error <- pnorm(0.95)*sd/sqrt(n)
        left <- mean-error
}
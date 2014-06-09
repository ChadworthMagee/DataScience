

q2 <- function()
{
        answer <- (0.52 * 0.30) / (0.52 * 0.30) + (0.25 * 0.52)
        print(answer)
}

q3 <- function()
{
        answer <- pnorm(70, mean=80, sd=10)
        print(answer)
}

q4 <- function()
{
        sample <- rnorm(n=10000, mean=1100, sd=75)
        answer <- quantile(sample, c(.95))
        print(answer)
}

q5 <- function()
{
        se <- 78/sqrt(100)
        answer <- 1100 + (1.65 * se)
        print(answer)
}

q6 <- function()
{       
        # http://math.stackexchange.com/questions/257610/probability-of-3-heads-in-4-coin-flips       
        possibilities <- 2^5
        # HHHHH
        fiveheads <- 1 / possibilities
        # HHHHT
        # HHHTH
        # HHTHH
        # HTHHH
        # THHHH
        fourheads <- 5 / possibilities
        answer <- fiveheads + fourheads
        print(answer)
}

q7 <- function()
{
        answer <- pnorm(, mean=15, sd=10)
        print(answer)
}

q9 <- function()
{
        answer <- sqrt(1/12)/sqrt(100)
        print(answer)
}

q10 <- function()
{
        answer <- ppois(10, lambda = 5 * 3)
        print(answer)
}
library(quantmod)
library(matrixStats)
 
#Vector of symbols to fetch prices. These can be changed based on Yahoo Finance Symbols https://finance.yahoo.com/cryptocurrencies/
symbols <- c('EOS-USD','BTC-USD','LTC-USD')

symbols <- as.character(symbols)

#Set the date range you wish to use for the analysis
getSymbols(symbols, from="2017-03-01", to="2018-05-16")

ClosePrices <- do.call(merge, lapply(symbols, function(x) Cl(get(x))))
data <- ClosePrices

colnames(data) <- symbols # name columns
data.changes <- data.frame(diff(as.matrix(data))) # calculate changes in value
series.mean <- colMeans(data, na.rm=TRUE) # column mean
sigma.Squared <- colSds(as.matrix(data.changes), na.rm=TRUE) # stdev of daily changes
price.stdev <- colSds(as.matrix(data), na.rm=TRUE) # stdev of prices
demeaned <-  sweep(data,2,series.mean,"-") # subtract mean from all columns of data
row.count <- nrow(demeaned) # row count

# function to calculate the half-life of each column of demeaned data. If slope > 1, instance is not mean reverting and is noted.
halflife.output <- function(x){
  fit <- lm(x[2:row.count] ~ x[1:row.count - 1], data = demeaned)
  slope <- summary(fit)$coefficients[2 ,"Estimate"]
  half.life <- log(0.5)/log(slope)
  ifelse(slope < 1, return(half.life),return("Not Mean Reverting"))
}

# create table of half-life results and series mean
results <- data.frame(sapply(demeaned, halflife.output))
colnames(results) <- c("Halflife")
results$SeriesMean <- series.mean

results

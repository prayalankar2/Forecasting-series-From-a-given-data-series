library(plyr)


input.file <- file("stdin")            
open(f)

numberofdata <- readLines(input.file,n=1);                         # here the first line contains the number of data given in series.
params <- sapply(strsplit(firstLine, " "), strtoi);
N <- params[1];
data <- suppressWarnings(read.table(f, nrows=N, header=FALSE));
close(input.file)
dseries <- data[[2]]

##here the given series is seasonal. data consists of number of passenger in a flight during different month of time.

model <- arima(dseries, optim.method="CG", order = c(0,0,1), seasonal=list(order=c(0,1,1),period=12)) 
p <- predict(model, n.ahead=12)$pred
p <- round(p,0)
write.table(p, row.names=FALSE, col.names=FALSE)

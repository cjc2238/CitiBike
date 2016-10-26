library(networkD3)

###
setwd("~/R/CitiBike Data")
df <- read.csv("201609-citibike-tripdata.csv")
setwd("~/GitHub/CitiBike")

df1 <- subset(df, select = c("start.station.id", "end.station.id"))
names(df1) <- c("Start","End")

networkdata <- df1

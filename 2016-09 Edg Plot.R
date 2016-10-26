library(igraph)
library(dplyr)
library(ggplot2)

###
setwd("~/R/CitiBike Data")
df <- read.csv("201609-citibike-tripdata.csv")
setwd("~/GitHub/CitiBike")

df1 <- subset(df, select = c("start.station.id", "end.station.id"))
names(df1) <- c("from","to")
df2 <- df1[1:1000,]

links <- graph(df2$End, df2$End)

###

df3 <- as.matrix(df2)
links <- as.matrix(links)

##

graph.data.frame(links, df3, directed = T)
